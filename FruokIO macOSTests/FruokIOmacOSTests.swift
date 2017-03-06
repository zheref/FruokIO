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
    
    var xmldocument = AEXMLDocument()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupDocumentWithProject()
    }
    
    func setupDocumentWithProject() {
        let attributes = ["xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
                          "xmlns:xsd": "http://www.w3.org/2001/XMLSchema"]
        let project = xmldocument.addChild(name: "frk:project", attributes: attributes)
        project.addChild(name: "frk:freelance", value: "Sergio Daniel Lozano Garcia",
                         attributes: ["frk:title": "Software Engineer"])
        project.addChild(name: "frk:client", value: "Universidad de Ibague",
                         attributes: ["frk:socialid": "988717254-2"])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let document = Document(withContent: xmldocument,
                                andUrl: URL(fileURLWithPath: "/Users/zheref/test-project"))
        document.save() {
            // do something
        }
        
        XCTAssert(true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
