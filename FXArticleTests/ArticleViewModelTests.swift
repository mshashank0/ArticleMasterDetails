//
//  ArticleViewModelTests.swift
//  ArticleViewModelTests
//
//  Created by Shashank Mishra on 27/11/21.
//

import XCTest
@testable import FXArticle

class ArticleViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: ArticleViewModel!
    var networkService: MockNetworkService!

    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        
        // Initialize Mock Network Service
        networkService = MockNetworkService()
        
        // Configure Mock Network Service
        networkService.data = loadStub(name: "articles", extension: "json")

        // Initialize Root View Model
        viewModel = ArticleViewModel(networkService: networkService)
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Tests for Fetch Article
    
    func test_FetchArticle_success() {
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch article")
        viewModel.didFetchArticleData = { (data, error) in
            if let groupedData = data {
                XCTAssertEqual(groupedData.category.count, 4)
                XCTAssertEqual(groupedData.category[0].values.first?.count, 3)
                XCTAssertEqual(groupedData.category[0].values.first?[0].title ?? "", "Engulfing Candle Patterns & How to Trade Them   ")
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
    
        // Invoke Method Under Test
        viewModel.fetchArticleData()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
 
    func test_FetchArticle_RequestFailed() {
        // Configure Network Service
        networkService.error = NSError(domain: "com.interview.ig", code: 1, userInfo: nil)

        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch article")
        
        viewModel.didFetchArticleData = { (data, error) in
            if let error = error {
                XCTAssertEqual(error, .noData)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.fetchArticleData()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_FetchArticle_InvalidResponse() {
        // Configure Network Service
        networkService.data = "data".data(using: .utf8)

        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Article")
        
        // Install Handler
        viewModel.didFetchArticleData = { (data, error) in
            if let error = error {
                XCTAssertEqual(error, .noData)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.fetchArticleData()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_FetchArticle_NoErrorNoResponse() {
        // Configure Network Service
        networkService.data = nil
        
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Article")
        
        // Install Handler
        viewModel.didFetchArticleData = { (data, error) in
            if let error = error {
                XCTAssertEqual(error, .noData)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.fetchArticleData()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
 
}
