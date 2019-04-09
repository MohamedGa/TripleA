//
//  helper.swift
//  Budgets
//
//  Created by Mohammed Gamal on 5/27/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit

class helper: NSObject {
    
    class func saveEmail(token: String){
        let def = UserDefaults.standard
        def.setValue(token, forKey: "email")
        def.synchronize()
    }
    class func getEmail() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "email") as? String
        
    }
    class func getMS_ID() -> Int? {
        let def = UserDefaults.standard
        return def.object(forKey: "ms_id") as? Int
        
    }
    class func getcompany_Id() -> Int? {
        let def = UserDefaults.standard
        return def.object(forKey: "c_id") as? Int
        
    }
    class func getphoneNumber() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "c_phone") as? String
        
    }
    class func getcontactEmail() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "c_mail") as? String
        
    }
    
    class func getFaceBook() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "c_facebook") as? String
        
    }
    class func getInstagram() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "c_instagram") as? String
        
    }
    class func getTwitter() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "c_twitter") as? String
        
    }
    class func getc_longitude() -> Double? {
        let def = UserDefaults.standard
        return def.object(forKey: "c_longitude") as? Double
        
    }
    class func getc_lattitude() -> Double? {
        let def = UserDefaults.standard
        return def.object(forKey: "c_lattitude") as? Double
        
    }
    class func getBL_name() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "bl_name") as? String
        
    }
    class func getS_ID() -> Int? {
        let def = UserDefaults.standard
        return def.object(forKey: "s_id") as? Int
        
    }
    class func getcityID() -> Int? {
        let def = UserDefaults.standard
        return def.object(forKey: "cityID") as? Int
        
    }
    class func getNameRegister() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "name") as? String

}
    class func getUserNameRegister() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "username") as? String
        
}
    class func getPasswordRegister() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "password") as? String
        
}
}
