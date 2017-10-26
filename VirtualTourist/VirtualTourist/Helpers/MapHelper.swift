//
//  MapHelper.swift
//  VirtualTourist
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 26/10/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import Foundation

struct MapHelper {
    
    static private let defaultVal = -500.0
    
    static var latitude: Double {
        get {
            return UserDefaults.standard.object(forKey: "latitude") as? Double ?? defaultVal
        }
        
        set {
            UserDefaults.standard.set(latitude, forKey: "latitude")
        }
    }
    
    static var longitude: Double {
        get {
            return UserDefaults.standard.object(forKey: "longitude") as? Double ?? defaultVal
        }
        
        set {
            UserDefaults.standard.set(longitude, forKey: "longitude")
        }
    }
    
    static var latitudeDelta: Double {
        get {
            return UserDefaults.standard.object(forKey: "latitudeDelta") as? Double ?? defaultVal
        }
        
        set {
            UserDefaults.standard.set(latitudeDelta, forKey: "latitudeDelta")
        }
    }
    
    static var longitudeDelta: Double {
        get {
            return UserDefaults.standard.object(forKey: "longitudeDelta") as? Double ?? defaultVal
        }
        
        set {
            UserDefaults.standard.set(longitudeDelta, forKey: "longitudeDelta")
        }
    }
}
