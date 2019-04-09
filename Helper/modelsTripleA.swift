//
//  models.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/28/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import Foundation

class subServices: NSObject {
    
  var  ms_id: Int = 0
   var ms_name: String = ""
  var  ms_description: String = ""
   var deleted_at: String = ""
   var created_at:String = ""
  var  updated_at: String = ""
  var  s_id: Int = 0
  var  s_name: String = ""
  var  s_image: String = ""
  var  mainservice_id: Int = 0
 
}
class companies: NSObject {
    
    var  c_id: Int = 0
    var c_name: String = ""
    var  c_image: String = ""
    var c_type: String = ""
    var c_location: String = ""
    
    var  c_work_started_at: String = ""
    var  c_work_ended_at: String = ""
    var  c_base_price: String = ""
     var  c_guaranteed: String = ""
    var  c_description: String = ""
    var  service_id: Int = 0
    var  c_phone: String = ""
    var  c_mail: String = ""
    var  c_facebook: String = ""
    var c_instagram:String = ""
    var c_twitter: String = ""
    var deleted_at: String = ""
    var  created_at: String = ""
    var updated_at: String = ""
    var ms_id: Int = 0
    var ms_name: String = ""
    var ms_description: String = ""
    var c_address: String = ""
    var c_coverimage: String = ""
 
    
}
class groups: NSObject {
    
    var  c_id: Int = 0
    var c_name: String = ""
    var  c_image: String = ""
    var c_type: String = ""
    var c_location: String = ""
    
    var  c_work_started_at: String = ""
    var  c_work_ended_at: String = ""
    var  c_base_price: String = ""
    var  c_guaranteed: String = ""
    var  c_description: String = ""
    var  service_id: Int = 0
    var  c_phone: String = ""
    var  c_mail: String = ""
    var  c_facebook: String = ""
    var c_instagram:String = ""
    var c_twitter: String = ""
    var deleted_at: String = ""
    var  created_at: String = ""
    var updated_at: String = ""
    var ms_id: Int = 0
    var ms_name: String = ""
    var ms_description: String = ""
    var c_address: String = ""
    var c_coverimage: String = ""
    
    
}
class persons: NSObject {
    
    var  c_id: Int = 0
    var c_name: String = ""
    var  c_image: String = ""
    var c_type: String = ""
    var c_location: String = ""
    
    var  c_work_started_at: String = ""
    var  c_work_ended_at: String = ""
    var  c_base_price: String = ""
    var  c_guaranteed: String = ""
    var  c_description: String = ""
    var  service_id: Int = 0
    var  c_phone: String = ""
    var  c_mail: String = ""
    var  c_facebook: String = ""
    var c_instagram:String = ""
    var c_twitter: String = ""
    var deleted_at: String = ""
    var  created_at: String = ""
    var updated_at: String = ""
    var ms_id: Int = 0
    var ms_name: String = ""
    var ms_description: String = ""
    var c_address: String = ""
    var c_coverimage: String = ""
   
    
}
class companyOffers: NSObject {
    
    var  c_id: Int = 0
    var c_name: String = ""
    var  o_id: Int = 0
    var o_name: String = ""
    var o_price: String = ""
    var  o_description: String = ""
}
class companyClients: NSObject {
    
    var  c_id: Int = 0
    var c_name: String = ""
    var  client_id: Int = 0
    var client_name: String = ""
    var client_image: String = ""
    var  client_description: String = ""
}
class companyWorkgallaries: NSObject {
    
    var  c_id: Int = 0
    var c_name: String = ""
    var  wg_id: Int = 0
    var wg_name: String = ""
    var wg_image: String = ""
    var  wg_description: String = ""
}
class companyServices: NSObject {
    
    var  c_id: Int = 0
    var c_name: String = ""
    var  ms_id: Int = 0
    var ms_name: String = ""
    var s_id: Int = 0
    var  s_name: String = ""
    var  s_image: String = ""
}
class companyDetails: NSObject {
    
    var  c_id: Int = 0
    var c_name: String = ""
    var  c_image: String = ""
    var c_type: String = ""
    var c_location: String = ""
    
    var  c_work_started_at: String = ""
    var  c_work_ended_at: String = ""
    var  c_base_price: String = ""
    var  c_guaranteed: String = ""
    var  c_description: String = ""
    var  service_id: Int = 0
    var  c_phone: String = ""
    var  c_mail: String = ""
    var  c_facebook: String = ""
    var c_instagram:String = ""
    var c_twitter: String = ""
    var deleted_at: String = ""
    var  created_at: String = ""
    var updated_at: String = ""
   var c_longitude: Double = 0
    var c_lattitude: Double = 0
    var c_address: String = ""
   
    
}

class cities: NSObject {
    
    var  city_id: Int = 0
    var city_name: String = ""
    
}

class photoGallery: NSObject {
    
    var  g_id: Int = 0
    var g_name: String = ""
    var  g_image:  String = ""
   
}
