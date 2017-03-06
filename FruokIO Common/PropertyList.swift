//
//  PropertyList.swift
//  FruokIO
//
//  Created by Sergio Daniel L. García on 3/5/17.
//  Copyright © 2017 Sergio Daniel L. García. All rights reserved.
//

import Cocoa

public class PropertyList {
    
    private static let Extension = "plist"

    private var dict: [String: Any]?
    
    init(withFilename name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: PropertyList.Extension),
            let data = try? Data(contentsOf: url) {
            
            if let result = try? PropertyListSerialization.propertyList(from: data,
                                                                        options: [],
                                                                        format: nil),
                let dictionary = result as? [String: Any]
            {
                dict = dictionary
            }
        }
    }
    
    subscript(key: String) -> Any? {
        return dict?[key]
    }
    
}
