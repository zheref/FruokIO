//
//  FKWriter.swift
//  FruokIO
//
//  Created by Sergio Daniel L. García on 3/5/17.
//  Copyright © 2017 Sergio Daniel L. García. All rights reserved.
//

import Foundation


protocol WriterProtocol {
    
    func execute(withString string: String, andFileName filename: String)
    
    #if os(macOS)
    func execute(document: Document)
    #endif
    
}


class Writer : WriterProtocol {
    
    
    func execute(withString string: String, andFileName filename: String) {
        #if os(macOS)
            
        #endif
    }
    
    
    #if os(macOS)
    func execute(document: Document) {
        
    }
    #endif
    
}
