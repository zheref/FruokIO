//
//  FKDocument.swift
//  FruokIO
//
//  Created by Sergio Daniel L. García on 3/5/17.
//  Copyright © 2017 Sergio Daniel L. García. All rights reserved.
//

import AppKit
import AEXML

/// Represents an actual document in Fruok with IO capabilities
public class Document : NSDocument {
    
    // MARK: - CONSTANTS
    
    private static let ExtensionPLKey = "FileExtension"
    
    // MARK: - PROPERTIES
    
    var content: AEXMLDocument
    
    // MARK: - INITIALIZERS
    
    convenience init(withContent content: AEXMLDocument, andUrl url: URL) {
        self.init()
        
        let propertyList = PropertyList(withFilename: K.InfoPLName)
        
        self.fileURL = url
        self.content = content
        
        guard let ext = propertyList[Document.ExtensionPLKey] as? String else {
            return
        }
        
        self.fileType = ext
    }
    
    override init() {
        self.content = AEXMLDocument()
        super.init()
    }
    
    // MARK: - NSDOCUMENT OVERRIDES
    
    public override class func autosavesInPlace() -> Bool {
        return true
    }
    
    public override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
//        let storyboard = NSStoryboard(name: "Main", bundle: nil)
//        let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
//        self.addWindowController(windowController)
    }
    
    
    public override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    
    public override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
}
