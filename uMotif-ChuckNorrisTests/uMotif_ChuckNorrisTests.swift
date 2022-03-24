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
        Task {
            let contentViewVM = await ContentView.ContentViewVM()
            let jokes = await contentViewVM.jokes
            XCTAssert(jokes != nil)
            XCTAssert(jokes?.count == 55)
        } 
    }
}
