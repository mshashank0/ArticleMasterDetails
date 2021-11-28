//
//  NetworkService.swift
//  FXArticle
//
//  Created by Shashank Mishra on 28/11/21.
//

import Foundation

class NetworkManager: NetworkService {
    
    // MARK: - Network Service
    
    func fetchData(with url: URL, completionHandler: @escaping NetworkService.FetchDataCompletion) {
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }
    
}
