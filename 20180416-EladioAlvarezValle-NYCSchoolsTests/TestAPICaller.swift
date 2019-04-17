//
//  TestAPICaller.swift
//  20180416-EladioAlvarezValle-NYCSchoolsTests
//
//  Created by Eladio Alvarez Valle on 4/16/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import XCTest
@testable import _0180416_EladioAlvarezValle_NYCSchools

class TestAPICaller: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAPICallSchools() {
        
        let exp = expectation(description: "Wait for api response")
        var statusResponse : String = ""
        var data_ : AnyObject?
        var schools : [School]?
        
        let apiCaller = API_Caller(URL: URLS.highSchool.url(), httpMethodType: .GET, authenticationType: .None)
        
        apiCaller.callAPI(dataParameter: nil, customHeaders: ["X-App-Token": "RhI2r08uFStqJgImLGthsuLhu"]) {
            
            status, data, response in
        
            statusResponse = status
            data_ = data
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 15, handler: nil)
        
        if let data = data_ as? Data {
        
            do {
            
                schools = try JSONDecoder().decode([School].self, from: data)
            } catch {
                print("Error Data \(error)")
            }
        }
        
        XCTAssertEqual(statusResponse, "200")
        XCTAssertNotNil(schools)
        
    }
    
    func testAPISAT() {
        
        let exp = expectation(description: "Wait for api response")
        var statusResponse : String = ""
        var data_ : AnyObject?
        var sats : [Sat]?
        
        let apiCaller = API_Caller(URL: URLS.sat.url(), httpMethodType: .GET, authenticationType: .None)
        
        apiCaller.callAPI(dataParameter: nil, customHeaders: ["X-App-Token": "RhI2r08uFStqJgImLGthsuLhu"]) {
            
            status, data, response in
        
                statusResponse = status
                data_ = data
                exp.fulfill()
        }
        
        waitForExpectations(timeout: 15, handler: nil)
        
        if let data = data_ as? Data {
            
            do {
                
                sats = try JSONDecoder().decode([Sat].self, from: data)
            } catch {
                print("Error Data \(error)")
            }
        }
        
        XCTAssertEqual(statusResponse, "200")
        XCTAssertNotNil(sats)
       
    }
    
    func testViewModel() {
        
        let exp = expectation(description: "Wait for api response")
        let tc = testClass()
        
        var apiResult : Bool = false
        
        let viewModel : SchoolViewModel = SchoolViewModel(delegate: tc)
        viewModel.getData {
            
            result in
            
                apiResult = result
                exp.fulfill()
        }
        
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertEqual(apiResult, true)
    }
    
    class testClass : SchoolProtocol {
        
        func refreshData() {
            
            print("Refresh data")
            
        }
    }

}
