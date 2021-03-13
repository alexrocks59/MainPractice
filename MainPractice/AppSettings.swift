//
//  AppSettings.swift
//  MainPractice
//
//  Created by Alexander Castillo on 3/13/21.
//

import Foundation

class AppSettings {
    static let shared = AppSettings()
    
    enum appsetting {
        case userid
        case password
    }
    
    var settings = [String :String]()
    
    private init() {
    
    }
    
    
}
