//
//  API.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/9/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class API: NSObject {
    
    class func login ( email: String, password : String, completion: @escaping (_ error : Error?, _ success: Bool,_ state :Bool)->Void) {
        let url = "https://servicevalley.net/api/loginUser"
        let parameters = ["email" :  email,
                          "password": password]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    completion (error, false, false)
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    print(value)
                    guard let userData = value as? [String : [Any]] else {
                        completion(nil, false, false)
                        return
                    }
                    guard let array  = userData["userData"] else {
                        completion(nil, false, false)
                        return
                    }
                    
                    let exist = array.count == 0
                    if exist {
                        
                        let def = UserDefaults.standard
                        def.setValue(email, forKey: "email")
                        def.synchronize()
                        completion(nil, true, true)
                        return
                    } else {
                        let def = UserDefaults.standard
                        def.setValue(email, forKey: "email")
                        def.synchronize()
                        completion (nil, true,false)
                        return
                    }
                    
                }
        }
}

    class   func register (  name : String, email: String, password : String,phone1 : String, completion: @escaping (_ error : Error?, _ success: Bool,_ state :Bool)->Void) {
   
    let url = "https://servicevalley.net/api/registerUser"
    let parameters = ["name" : name,
                      "email" : email,
                      "password" : password,
                      "phone1": phone1]
    
    Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        .validate(statusCode: 200..<300)
        .responseJSON { responce in
            switch responce.result
            {
            case .failure(let error):
                completion (error, false, false)
                
                print(error)
                
            case.success(let value):
                print(value)
                guard let userData = value as? [String : [Any]] else {
                    completion(nil, false, false)
                    return
                }
                guard let array  = userData["userData"] else {
                    completion(nil, false, false)
                    return
                }
                
                let exist = array.count == 0
                if exist {
                    
                    let def = UserDefaults.standard
                    def.setValue(email, forKey: "email")
                    def.synchronize()
                    completion(nil, true, true)
                    return
                } else {
                    let def = UserDefaults.standard
                    def.setValue(email, forKey: "email")
                    def.synchronize()
                    completion (nil, true,false)
                    return
                }
            }
    }
}
    class func getsubServices (ms_id:Int,completion: @escaping (_ error : Error?, _ location_list: [subServices])->Void) {
//        guard let email = helper.getEmail() else {
//            completion ( nil , [] )
//            return
//        }
      
        
        let url = "https://tripleaevent.com/api/subservices1"
        let parameters = ["ms_id" :  ms_id]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["subservices"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var location_list = [subServices]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let userLocation = subServices()
                        userLocation.ms_id = data["ms_id"]?.int ?? 0
                        userLocation.ms_name = data["ms_name"]?.string ?? ""
                       userLocation.ms_description = data["ms_description"]?.string ?? ""
                        userLocation.deleted_at = data["deleted_at"]?.string ?? "";              userLocation.created_at = data["created_at"]?.string ?? ""
                        userLocation.updated_at = data["updated_at"]?.string ?? ""
                        userLocation.s_id = data["s_id"]?.int ?? 0
                        userLocation.s_name = data["s_name"]?.string ?? ""
                        userLocation.s_image = data["s_image"]?.string ?? ""
                        userLocation.mainservice_id = data["mainservice_id"]?.int ?? 0
                        
                        location_list.append(userLocation)
                        
                    }
                    completion(nil, location_list)
                    
                }
        }
    }
//    class func addNewAddress(completion: @escaping (_ error : Error?, _ addNewLocation: userLocations?)->Void){
//        guard let email = helper.getEmail() else {
//            completion ( nil , nil )
//            return
//        }
//        guard let l_name = helper.getL_name() else {
//            completion ( nil , nil )
//            return
//        }
//        guard let longitude = helper.getLongitude() else {
//            completion ( nil , nil )
//            return
//        }
//        guard let latitude = helper.getLatitude() else {
//            completion ( nil , nil )
//            return
//        }
//        guard let l_description = helper.getL_Description() else {
//            completion ( nil , nil )
//            return
//        }
//        guard let building_No = helper.getBuildingNo() else {
//            completion ( nil , nil )
//            return
//        }
//        guard let flat_No = helper.getflatNo() else {
//            completion ( nil , nil )
//            return
//        }
//
//        let url = "https://servicevalley.net/api/addUserLocation"
//        let parameters = [ "email" :  email,
//                           "l_name": l_name,
//                           "l_building_number":building_No,
//                           "l_flat_number": flat_No,
//                           "l_longitude":longitude,
//                           "l_latitude": latitude,
//                           "l_description":l_description] as [String : Any]
//        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
//
//            .validate(statusCode: 200..<900)
//
//            .responseJSON { response in
//
//                switch response.result
//                {
//                case .failure(let error):
//                    completion (error,nil )
//                    print(error)
//
//                case.success(let value):
//
//                    print(value)
//                    let json = JSON(value)
//
//                    guard let data = json["userLocations"].dictionary  else  {return}
//                    let newUserLocation = userLocations()
//                    newUserLocation.l_id = data["l_id"]?.int ?? 0
//                    newUserLocation.l_name = data["l_name"]?.string ?? ""
//                    newUserLocation.l_longitude = data["l_longitude"]?.double ?? 0
//                    newUserLocation.l_latitude = data["l_latitude"]?.double ?? 0
//                    newUserLocation.l_building_number = data["l_building_number"]?.string ?? ""
//                    newUserLocation.l_flat_number = data["l_flat_number"]?.string ?? ""
//                   newUserLocation.l_description = data["l_description"]?.string ?? ""
//                   newUserLocation.user_id = data["user_id"]?.int ?? 0
//
//
//
//                    completion (nil, newUserLocation)
//
//                }
//        }
//
//
//
//    }
//    class func deleteAddress(l_id : Int, completion: @escaping (_ error : Error?, _ success: Bool)->Void){
//        guard let lang = helper.getlang() else {
//            completion ( nil , false )
//            return
//        }
//
//        let url = "https://servicevalley.net/api/deleteUserLocation"
//        let parameters = ["l_id": l_id,
//                          "lang" : lang] as [String : Any]
//        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
//
//
//            .responseJSON { response in
//
//                switch response.result
//                {
//                case .failure(let error):
//                    if response.response?.statusCode == 200 {
//                        completion(nil, true)
//                    } else {
//                        completion (error,false )
//                        print(error)
//                    }
//
//                case.success(let value):
//
//                    print(value)
//                    let json = JSON(value)
//
//                    guard let status = json["status"].toInt, status == 1 else {
//                        completion(nil , false)
//                        return
//                    }
//
//
//
//                    completion (nil, true)
//
//                }
//        }
//
//
//
//    }
    class func getCompanies (s_id:Int,completion: @escaping (_ error : Error?, _ company_list: [companies])->Void) {
       
        
       
       guard let city_id = helper.getcityID() else {
            completion ( nil , [] )
            return
        }
       
        let url = "https://tripleaevent.com/api/companies"
        let parameters = ["s_id" :  s_id,
                          "city_id" : city_id] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["companies"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var company_list = [companies]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let company = companies()
                        company.c_id = data["c_id"]?.int ?? 0
                        company.c_name = data["c_name"]?.string ?? ""
                        company.c_image = data["c_image"]?.string ?? ""
                        company.c_location = data["c_location"]?.string ?? ""
                        company.c_type = data["c_type"]?.string ?? ""
                        company.c_work_started_at = data["c_work_started_at"]?.string ?? ""
                         company.c_work_ended_at = data["c_work_ended_at"]?.string ?? ""
                        company.c_guaranteed = data["c_guaranteed"]?.string ?? ""
                        company.c_base_price = data["c_base_price"]?.string ?? ""
                        company.c_description = data["c_description"]?.string ?? ""
                        company.service_id = data["service_id"]?.int ?? 0
                        company.c_phone = data["c_phone"]?.string ?? ""
                        company.c_mail = data["c_mail"]?.string ?? ""
                        company.c_facebook = data["c_facebook"]?.string ?? ""
                        company.c_instagram = data["c_instagram"]?.string ?? ""
                        company.c_twitter = data["c_twitter"]?.string ?? ""
                       
                        company.deleted_at = data["deleted_at"]?.string ?? ""
                        company.created_at = data["created_at"]?.string ?? ""
                        company.updated_at = data["updated_at"]?.string ?? ""
                        company.ms_id = data["ms_id"]?.int ?? 0
                        
                        company.ms_name = data["ms_name"]?.string ?? ""
                        company.ms_description = data["ms_description"]?.string ?? ""
                        company.c_address = data["c_address"]?.string ?? ""
                        company.c_coverimage = data["c_coverimage"]?.string ?? ""
                        company_list.append(company)
                        
                    }
                    completion(nil, company_list)
                    
                }
        }
    }
    class func getGroups (s_id:Int,completion: @escaping (_ error : Error?, _ group_list: [groups])->Void) {
        
        
        
        guard let city_id = helper.getcityID() else {
            completion ( nil , [] )
            return
        }
        let url = "https://tripleaevent.com/api/groups"
        let parameters = ["s_id" :  s_id,
                          "city_id" : city_id] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["groups"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var group_list = [groups]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let group = groups()
                        group.c_id = data["c_id"]?.int ?? 0
                        group.c_name = data["c_name"]?.string ?? ""
                        group.c_image = data["c_image"]?.string ?? ""
                        group.c_location = data["c_location"]?.string ?? ""
                        group.c_type = data["c_type"]?.string ?? ""
                        group.c_work_started_at = data["c_work_started_at"]?.string ?? ""
                        group.c_work_ended_at = data["c_work_ended_at"]?.string ?? ""
                        group.c_guaranteed = data["c_guaranteed"]?.string ?? ""
                        group.c_base_price = data["c_base_price"]?.string ?? ""
                        group.c_description = data["c_description"]?.string ?? ""
                        group.service_id = data["service_id"]?.int ?? 0
                        group.c_phone = data["c_phone"]?.string ?? ""
                        group.c_mail = data["c_mail"]?.string ?? ""
                        group.c_facebook = data["c_facebook"]?.string ?? ""
                        group.c_instagram = data["c_instagram"]?.string ?? ""
                        group.c_twitter = data["c_twitter"]?.string ?? ""
                        
                        group.deleted_at = data["deleted_at"]?.string ?? ""
                        group.created_at = data["created_at"]?.string ?? ""
                        group.updated_at = data["updated_at"]?.string ?? ""
                        group.ms_id = data["ms_id"]?.int ?? 0
                        
                        group.ms_name = data["ms_name"]?.string ?? ""
                        group.ms_description = data["ms_description"]?.string ?? ""
                        group.c_address = data["c_address"]?.string ?? ""
                        group.c_coverimage = data["c_coverimage"]?.string ?? ""
                        group_list.append(group)
                        
                    }
                    completion(nil, group_list)
                    
                }
        }
    }
    class func getPersons (s_id:Int,completion: @escaping (_ error : Error?, _ person_list: [persons])->Void) {
        
        
        
        guard let city_id = helper.getcityID() else {
            completion ( nil , [] )
            return
        }
        let url = "https://tripleaevent.com/api/persons"
        let parameters = ["s_id" :  s_id,
                          "city_id" : city_id] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["persons"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var person_list = [persons]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let person = persons()
                        person.c_id = data["c_id"]?.int ?? 0
                        person.c_name = data["c_name"]?.string ?? ""
                        person.c_image = data["c_image"]?.string ?? ""
                        person.c_location = data["c_location"]?.string ?? ""
                        person.c_type = data["c_type"]?.string ?? ""
                        person.c_work_started_at = data["c_work_started_at"]?.string ?? ""
                        person.c_work_ended_at = data["c_work_ended_at"]?.string ?? ""
                        person.c_guaranteed = data["c_guaranteed"]?.string ?? ""
                        person.c_base_price = data["c_base_price"]?.string ?? ""
                        person.c_description = data["c_description"]?.string ?? ""
                        person.service_id = data["service_id"]?.int ?? 0
                        person.c_phone = data["c_phone"]?.string ?? ""
                        person.c_mail = data["c_mail"]?.string ?? ""
                        person.c_facebook = data["c_facebook"]?.string ?? ""
                        person.c_instagram = data["c_instagram"]?.string ?? ""
                        person.c_twitter = data["c_twitter"]?.string ?? ""
                        
                        person.deleted_at = data["deleted_at"]?.string ?? ""
                        person.created_at = data["created_at"]?.string ?? ""
                        person.updated_at = data["updated_at"]?.string ?? ""
                        person.ms_id = data["ms_id"]?.int ?? 0
                        
                        person.ms_name = data["ms_name"]?.string ?? ""
                        person.ms_description = data["ms_description"]?.string ?? ""
                         person.c_address = data["c_address"]?.string ?? ""
                        person.c_coverimage = data["c_coverimage"]?.string ?? ""
                        person_list.append(person)
                        
                    }
                    completion(nil, person_list)
                    
                }
        }
    }
    class func getCompanyOffers (c_id:Int,completion: @escaping (_ error : Error?, _ offer_list: [companyOffers])->Void) {
        
        
        
        //        guard let service_id = helper.getSelectedSubServies() else {
        //            completion ( nil , [] )
        //            return
        //        }
        //         let lang = "ar"
        let url = "https://tripleaevent.com/api/companyOffers"
        let parameters = ["c_id" :  c_id] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["companyOffers"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var offer_list = [companyOffers]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let person = companyOffers()
                        person.c_id = data["c_id"]?.int ?? 0
                        person.c_name = data["c_name"]?.string ?? ""
                        person.o_id = data["o_id"]?.int ?? 0
                        person.o_name = data["o_name"]?.string ?? ""
                        person.o_price = data["o_price"]?.string ?? ""
                        person.o_description = data["o_description"]?.string ?? ""
                       
                        offer_list.append(person)
                        
                    }
                    completion(nil, offer_list)
                    
                }
        }
    }
    class func getCompanyWorkgallaries (c_id:Int,completion: @escaping (_ error : Error?, _ gallaris_list: [companyWorkgallaries])->Void) {
        
        
        
        //        guard let service_id = helper.getSelectedSubServies() else {
        //            completion ( nil , [] )
        //            return
        //        }
        //         let lang = "ar"
        let url = "https://tripleaevent.com/api/companyWorkgallaries"
        let parameters = ["c_id" :  c_id] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["companyWorkgallaries"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var gallaris_list = [companyWorkgallaries]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let person = companyWorkgallaries()
                        person.c_id = data["c_id"]?.int ?? 0
                        person.c_name = data["c_name"]?.string ?? ""
                        person.wg_id = data["wg_id"]?.int ?? 0
                        person.wg_name = data["wg_name"]?.string ?? ""
                        person.wg_image = data["wg_image"]?.string ?? ""
                        person.wg_description = data["wg_description"]?.string ?? ""
                        
                        gallaris_list.append(person)
                        
                    }
                    completion(nil, gallaris_list)
                    
                }
        }
    }
    class func getCompanyServices (c_id:Int,completion: @escaping (_ error : Error?, _ service_list: [companyServices])->Void) {
        
        
        
        //        guard let service_id = helper.getSelectedSubServies() else {
        //            completion ( nil , [] )
        //            return
        //        }
        //         let lang = "ar"
        let url = "https://tripleaevent.com/api/companyServices"
        let parameters = ["c_id" :  c_id] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["companyServices"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var service_list = [companyServices]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let person = companyServices()
                        person.c_id = data["c_id"]?.int ?? 0
                        person.c_name = data["c_name"]?.string ?? ""
                        person.ms_id = data["ms_id"]?.int ?? 0
                        person.ms_name = data["ms_name"]?.string ?? ""
                        person.s_name = data["s_name"]?.string ?? ""
                        person.s_image = data["s_image"]?.string ?? ""
                         person.s_id = data["s_id"]?.int ?? 0
                        service_list.append(person)
                        
                    }
                    completion(nil, service_list)
                    
                }
        }
    }
    class func getCompanyClients (c_id:Int,completion: @escaping (_ error : Error?, _ client_list: [companyClients])->Void) {
        
        
        
        //        guard let service_id = helper.getSelectedSubServies() else {
        //            completion ( nil , [] )
        //            return
        //        }
        //         let lang = "ar"
        let url = "https://tripleaevent.com/api/companyClients"
        let parameters = ["c_id" :  c_id] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["companyClients"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var client_list = [companyClients]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let person = companyClients()
                        person.c_id = data["c_id"]?.int ?? 0
                        person.c_name = data["c_name"]?.string ?? ""
                        person.client_id = data["client_id"]?.int ?? 0
                        person.client_name = data["client_name"]?.string ?? ""
                        person.client_image = data["client_image"]?.string ?? ""
                        person.client_description = data["client_description"]?.string ?? ""
                    
                        client_list.append(person)
                        
                    }
                    completion(nil, client_list)
                    
                }
        }
    }
    class func getCompanyDetails (c_id:Int,completion: @escaping (_ error : Error?, _ details_list: [companyDetails])->Void) {
        
        
        
        //        guard let service_id = helper.getSelectedSubServies() else {
        //            completion ( nil , [] )
        //            return
        //        }
        //         let lang = "ar"
        let url = "https://tripleaevent.com/api/companyDetails"
        let parameters = ["c_id" :  c_id] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["companyDetails"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var details_list = [companyDetails]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let company = companyDetails()
                        company.c_id = data["c_id"]?.int ?? 0
                        company.c_name = data["c_name"]?.string ?? ""
                        company.c_image = data["c_image"]?.string ?? ""
                        company.c_location = data["c_location"]?.string ?? ""
                        company.c_type = data["c_type"]?.string ?? ""
                        company.c_work_started_at = data["c_work_started_at"]?.string ?? ""
                        company.c_work_ended_at = data["c_work_ended_at"]?.string ?? ""
                        company.c_guaranteed = data["c_guaranteed"]?.string ?? ""
                        company.c_base_price = data["c_base_price"]?.string ?? ""
                        company.c_description = data["c_description"]?.string ?? ""
                        company.service_id = data["service_id"]?.int ?? 0
                        company.c_phone = data["c_phone"]?.string ?? ""
                        company.c_mail = data["c_mail"]?.string ?? ""
                        company.c_facebook = data["c_facebook"]?.string ?? ""
                        company.c_instagram = data["c_instagram"]?.string ?? ""
                        company.c_twitter = data["c_twitter"]?.string ?? ""
                        
                        company.deleted_at = data["deleted_at"]?.string ?? ""
                        company.created_at = data["created_at"]?.string ?? ""
                        company.updated_at = data["updated_at"]?.string ?? ""
                        company.c_longitude = data["c_longitude"]?.double ?? 0
                        
                        company.c_lattitude = data["c_lattitude"]?.double ?? 0
                        company.c_address = data["c_address"]?.string ?? ""
                      
                        details_list.append(company)
                        
                    }
                    completion(nil, details_list)
                    
                }
        }
    }
    class func getCities (completion: @escaping (_ error : Error?, _ cities_list: [cities])->Void) {
        
        
        
        //        guard let service_id = helper.getSelectedSubServies() else {
        //            completion ( nil , [] )
        //            return
        //        }
        //         let lang = "ar"
        let url = "https://tripleaevent.com/api/cities"
        let parameters = [:] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["cities"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var cities_list = [cities]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let city = cities()
                        city.city_id = data["city_id"]?.int ?? 0
                        city.city_name = data["city_name"]?.string ?? ""
                       
                        cities_list.append(city)
                        
                    }
                    completion(nil, cities_list)
                    
                }
        }
    }
    class func getAllPhotoGallaries (completion: @escaping (_ error : Error?, _ gallaris_list: [photoGallery])->Void) {
        
        
        
      
        let url = "https://tripleaevent.com/api/getAllPhotoGallery"
        
         let parameters = [:] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["photoGallery"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var gallaris_list = [photoGallery]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let person = photoGallery()
                        person.g_id = data["g_id"]?.int ?? 0
                        person.g_name = data["g_name"]?.string ?? ""
                      
                        person.g_image = data["g_image"]?.string ?? ""
                      
                        gallaris_list.append(person)
                        
                    }
                    completion(nil, gallaris_list)
                    
                }
        }
    }
}
