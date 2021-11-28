//
//  MockNetworkService.swift
//  FXArticleTests
//
//  Created by Shashank Mishra on 28/11/21.
//

import Foundation
@testable import FXArticle

class MockNetworkService: NetworkService {
    
    // MARK: - Properties
    
    var data: Data?
    var error: Error?
    var statusCode: Int = 200
 
    // MARK: - Network Service
    
    func fetchData(with url: URL, completionHandler: @escaping NetworkService.FetchDataCompletion) {
        // Create Response
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        
        // Invoke Handler
        completionHandler(data, response, error)
    }
    
}
