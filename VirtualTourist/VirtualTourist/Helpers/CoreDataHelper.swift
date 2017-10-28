//
//  CoreDataHelper.swift
//  VirtualTourist
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 27/10/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import Foundation

enum EntitiesNames: String {
    case locationPin = "LocationPin"
    case photo = "Photo"
}

class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    
    private init() {}
    
    var stack: CoreDataStack!
    
    public func setupDatabase() {
        stack = CoreDataStack(modelName: "VirtualTourist")!
        stack.autoSave(1)
    }
}
