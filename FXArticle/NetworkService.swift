//
//  NetworkService.swift
//  FXArticle
//
//  Created by Shashank Mishra on 28/11/21.
//

import Foundation

protocol NetworkService {
    
    // MARK: - Type Aliases
    
    typealias FetchDataCompletion = (Data?, URLResponse?, Error?) -> Void
    
    // MARK: - Methods
    
    func fetchData(with url: URL, completionHandler: @escaping FetchDataCompletion)
    
}
