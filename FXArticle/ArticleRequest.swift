//
//  ArticleRequest.swift
//  FXArticle
//
//  Created by Shashank Mishra on 27/11/21.
//

import Foundation

struct ArticleRequest {
    
    // MARK: - Properties
    let baseUrl: URL
    let api: String
    
    var url: URL {
        return baseUrl.appendingPathComponent(api)
    }
}
