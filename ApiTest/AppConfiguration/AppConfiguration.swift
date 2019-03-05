//
//  AppConfiguration.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 15/02/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import Foundation

var serverURL = ""


enum selectedScheme: String {
    case Undefined = "Undefined"
    case Debug = "Debug"
    case Dev = "Development"
    case Prod = "Production"
}

#if Debug
let isDebuggingOn = true
let appMode: selectedScheme = .Debug
#elseif Development
let appMode: selectedScheme = .Dev
let isDebuggingOn = false
#else
let appMode: selectedScheme = .Prod
let isDebuggingOn = false
#endif

struct ConfigEndPoints {
    
    internal enum AppEnvMode:String {
        case Undefined = "Undefined"
        case Debug = "Debug"
        case Dev = "Development"
        case Prod = "Production"
        
        func baseEndPoint()->String? {
            
            switch self {
            case .Debug, .Dev:
                return "<#DevelopmentServerURLPath>"
            case .Prod:
                return "<#ProductionServerURLPath>"
            default:
                return nil
            }
        }
    }
    
    private var mode: AppEnvMode?
    static var shared = ConfigEndPoints()
    static var serverURL:String?
    
    var appMode:AppEnvMode {
        get {
            return mode!
        }
    }
    
    mutating func initialize() {
        self.mode = .Undefined
        
        if let modeString = Bundle.main.infoDictionary?["EVN"] as? String,
            let modeType = AppEnvMode(rawValue: modeString) {
            self.mode = modeType
        }
        
        switch appMode {
            case .Debug:
                ConfigEndPoints.serverURL = "<#DevelopmentServerURLPath>"
            break
            case .Dev:
                ConfigEndPoints.serverURL = "<#DevelopmentServerURLPath>"
            break
            case .Prod:
                ConfigEndPoints.serverURL = "<#ProductionServerURLPath>"
            break
            
        default:
            break
        }
    }
}
