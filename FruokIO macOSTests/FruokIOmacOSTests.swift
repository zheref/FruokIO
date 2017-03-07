//
//  FruokIO_macOSTests.swift
//  FruokIO macOSTests
//
//  Created by Sergio Daniel L. García on 3/4/17.
//  Copyright © 2017 Sergio Daniel L. García. All rights reserved.
//

import XCTest

import AEXML

@testable import FruokIOmacOS

class FruokIOmacOSTests: XCTestCase {
    
    // MARK: - CONSTANTS
    
    private static let UrlString = "/Users/zheref/test-project"
    
    // MARK: - PROPERTIES
    
    var document: Document?
    var xmldocument = AEXMLDocument()
    
    // MARK: - UI PROPERTIES
    
    var window: NSWindowController?
    
    
    // MARK: - SETUP METHODS
    
    override func setUp() {
        super.setUp()
        
        let attributes = ["xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
                          "xmlns:xsd": "http://www.w3.org/2001/XMLSchema"]
        
        let project = xmldocument.addChild(name: "frk:project", attributes: attributes)
        
        project.addChild(name: "frk:freelance", value: "Sergio Daniel Lozano Garcia",
                         attributes: ["frk:title": "Software Engineer"])
        
        project.addChild(name: "frk:client", value: "Universidad de Ibague",
                         attributes: ["frk:socialid": "988717254-2"])
        
        document = Document(withContent: xmldocument,
                            url: URL(fileURLWithPath: FruokIOmacOSTests.UrlString))
        { (document) in
            return NSWindowController()
        }
        
        document?.makeWindowControllers()
        window = document?.mainWindowController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method 
        // in the class.
        super.tearDown()
    }
    
    // MARK: - TEST CASES
    
    func testDocumentCreation() {
        XCTAssertNotNil(document)
    }
    
    func testWindowController() {
        XCTAssertNotNil(window)
    }
    
    /// Test of writing a document with the Document created class
    func testWrite() {
        var existence: Bool = false
        let semaphore = DispatchSemaphore(value: 0)
        
        document?.persist() { (error: Error?) in
            existence = FileManager.default.fileExists(atPath: FruokIOmacOSTests.UrlString)
            semaphore.signal()
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        XCTAssert(existence)
    }
    
}
