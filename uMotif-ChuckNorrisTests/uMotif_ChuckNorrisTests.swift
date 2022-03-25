//
//  uMotif_ChuckNorrisTests.swift
//  uMotif-ChuckNorrisTests
//
//  Created by Colin Fry on 22/03/2022.
//

import XCTest
@testable import uMotif_ChuckNorris

class uMotif_ChuckNorrisTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCNService() async {
        let cnJokesURL = "https://api.icndb.com/jokes/random/55?exclude=[explicit]"
        let cnService = CNService()
        
        var response: CNJokeResponse?
        var responseError: Error?
        
        do {
            response = try await cnService.fetchJokes(urlString: cnJokesURL)
        } catch {
            responseError = error
        }
        
        XCTAssert(response != nil)
        XCTAssert(response?.jokes?.count == 55)
        XCTAssert(responseError == nil)
    }
    
    func testContentViewVM() async {
        let contentViewVM = await ContentView.ContentViewVM()
        var state = await contentViewVM.vmState
        let error = await contentViewVM.hasError
        
        switch state {
        case .na:
            print("pass")
        case .loading:
            XCTFail()
        case .success(_):
            XCTFail()
        case .fail(_):
            XCTFail()
        }
        
        XCTAssert(error == false)
        
        await contentViewVM.loadModelData()
        state = await contentViewVM.vmState
        
        switch state {
        case .na:
            XCTFail()
        case .loading:
            XCTFail()
        case .success(let data):
            XCTAssertTrue(data?.count == 55)
        case .fail(_):
            XCTFail()
        }
        
        XCTAssert(error == false)
    }
}
