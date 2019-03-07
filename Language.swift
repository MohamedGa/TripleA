//
//  Language.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 9/2/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import Foundation

class Language {
    class func currentLanguage() -> String {
         let def = UserDefaults.standard
        let langs = def.object(forKey: "AppleLanguages") as! NSArray
        let firstLang = langs.firstObject as! String
        return firstLang
}
    class func setAppLanguage(lang: String) {
        let def = UserDefaults.standard
        def.set([lang, currentLanguage()], forKey: "AppleLanguages")
        def.synchronize()
       
}
}
