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
open class Document : NSDocument {
    
    // MARK: - SUBTYPES
    
    public typealias DocumentWindowMakerOperation = (Document) -> NSWindowController
    
    // MARK: - CONSTANTS
    
    private static let ExtensionPLKey = "FileExtension"
    
    // MARK: - PROPERTIES
    
    var content: AEXMLDocument
    var windowMakerOperation: DocumentWindowMakerOperation
    
    // MARK: - INITIALIZERS
    
    convenience init(withStringUrl stringUrl: String) {
        let url = URL(fileURLWithPath: stringUrl)
        
        self.init(withContent: AEXMLDocument(), url: url) { (document) in
            return NSWindowController()
        }
    }
    
    public convenience init(withContent content: AEXMLDocument,
                            url: URL,
                            windowMaker: DocumentWindowMakerOperation) {
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
        
        self.windowMakerOperation = { (document) in
            return NSWindowController()
        }
        
        super.init()
    }
    
    // MARK: - NSDOCUMENT OVERRIDES
    
    open override class func autosavesInPlace() -> Bool {
        return true
    }
    
    open override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
//        let storyboard = NSStoryboard(name: "Main", bundle: nil)
//        let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
//        self.addWindowController(windowController)
        
        addWindowController(windowMakerOperation(self))
    }
    
    open override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        if let data = content.xml.data(using: .utf8) {
            return data
        } else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
    }
    
    
    open override func writableTypes(for saveOperation: NSSaveOperationType) -> [String] {
        let propertyList = PropertyList(withFilename: K.InfoPLName)
        
        guard let ext = propertyList[Document.ExtensionPLKey] as? String else {
            return [""]
        }
        
        return [ext]
    }
    
    
    open override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    // MARK: - CUSTOM OPERATIONS
    
    public var mainWindowController: NSWindowController? {
        return self[0]
    }
    
    public subscript(index: Int) -> NSWindowController? {
        return windowControllers[index]
    }
    
    public func persist(completionHandler: @escaping (Error?) -> Void) {
        guard let url = fileURL, let type = fileType else {
            save(self)
            return
        }
        
        save(to: url, ofType: type, for: .saveOperation,
             completionHandler: completionHandler)
    }
    
}
