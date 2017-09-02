//
//  Device.swift
//
//  Created by Batuhan Saka on 2.09.2017.
//  Copyright © 2017 Batuhan Saka. All rights reserved.
//

import UIKit

public extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
    var batteryStatus: UIDeviceBatteryState {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryState
    }
}

open class Device {
    // MARK: Device name
    // The name of personal device, like "Batuhan's iPhone"
    static public var name: String {
        return UIDevice.current.name
    }
    
    // MARK: System name
    // The name of running OS in the device, such as iOS, tvOS and much more.
    static public var systemName: String {
        return UIDevice.current.systemName
    }
    
    // MARK: System version
    // The version of running OS in the device. (e.g. 9.0, 10.0.)
    static public var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    // MARK: Device model
    // The model of device
    static public var model: String {
        return UIDevice.current.model
    }
    
    // MARK: Determined device model
    static public var determinedModel: String {
        return UIDevice.current.modelName
    }
    
    // MARK: Device UUID
    static public var uuid: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    // MARK: Device is retina or not
    // You can determine if device is retina or not.
    static public var isRetina: Bool {
        return UIScreen.main.scale > 1.0
    }
    
    // MARK: Device is simulator or not
    static public var isSimulator: Bool {
        return determinedModel == "Simulator"
    }
    
    // MARK: Device is iPhone or not
    static public var isiPhone: Bool {
        return determinedModel.contains("iPhone")
    }
    
    // MARK: Device is iPad or not
    static public var isiPad: Bool {
        return determinedModel.contains("iPad")
    }
    
    // MARK: Device is iPod or not
    static public var isiPod: Bool {
        return determinedModel.contains("iPod")
    }
    
    // MARK: Device is Apple TV or not
    static public var isTV: Bool {
        return determinedModel.contains("TV")
    }
    
    // MARK: Device is jailbroken or not
    static public var isJailBroken: Bool {
        var isJailBroken = false;
        
        let cydiaPath = "/Applications/Cydia.app";
        let aptPath = "/private/var/lib/apt/";
        
        if FileManager.default.fileExists(atPath: cydiaPath) {
            isJailBroken = true;
        }
        
        if FileManager.default.fileExists(atPath: aptPath) {
            isJailBroken = true;
        }
        
        let url = URL.init(string:"cydia://package/com.example.package")
        let cydiaJailBroken = UIApplication.shared.canOpenURL(url!)
        
        return isJailBroken || cydiaJailBroken;
    }
    
    // MARK: Battery state
    static public var batteryState: UIDeviceBatteryState {
        return UIDevice.current.batteryStatus
    }
    
    // MARK: Battery level
    static public var batteryLevel: Int {
        return Int(UIDevice.current.batteryLevel * 100)
    }
    
    // MARK: The current region code of users device
    static public var regionCode: String {
        return Locale.current.regionCode!
    }
    
    // MARK: The current language of users device
    static public var languageCode: String {
        return Locale.current.languageCode!
    }
    
    // MARK: Screen bounds of current device
    static public var screenBounds: CGRect {
        return UIScreen.main.bounds
    }

}
