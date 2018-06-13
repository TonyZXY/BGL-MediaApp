//
//  LanguagePackage.swift
//  BGL-MediaApp
//
//  Created by Bruce Feng on 12/6/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    var bundal:Bundle{
        get{
            let path = Bundle.main.path(forResource: "en", ofType: "lproj")
            let bundals = Bundle.init(path: path!)
            return bundals!
        }
    }
    
    func textValue(name:String)->String{
        return bundal.localizedString(forKey:name,value:nil,table:nil)
    }
}
