//
//  FruokIO_macOS_UI_Tests.swift
//  FruokIO macOS UI Tests
//
//  Created by Sergio Daniel L. García on 3/7/17.
//  Copyright © 2017 Sergio Daniel L. García. All rights reserved.
//

import XCTest

import FruokIOmacOS
import AEXML

class FruokIOmacOSUITests: XCTestCase {
    
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
                            url: URL(fileURLWithPath: FruokIOmacOSUITests.UrlString))
        { (document) in
            return NSWindowController()
        }
        
        document?.makeWindowControllers()
        window = document?.mainWindowController
        
        continueAfterFailure = false
        
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - 
        // required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func exampleTest() {
        // Use recording to get started writing UI tests.
    }
    
    // MARK: - TEST CASES
    
    /// Test of writing a document with the Document created class
    func testWrite() {
        var existence: Bool = false
        let semaphore = DispatchSemaphore(value: 0)
        
        document?.persist() { (error: Error?) in
            existence = FileManager.default.fileExists(atPath: FruokIOmacOSUITests.UrlString)
            semaphore.signal()
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        XCTAssert(existence)
    }
    
}
