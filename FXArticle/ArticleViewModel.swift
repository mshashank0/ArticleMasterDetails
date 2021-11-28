//
//  ArticleViewModel.swift
//  FXArticle
//
//  Created by Shashank Mishra on 27/11/21.
//

import Foundation

enum GroupedTitle: String {
    case breakingNews = "Breaking News"
    case topNews = "Top News"
    case localDailyBriefings = "Local Daily Briefings"
    case technicalAnalysis = "Technical Analysis"
    case specialReport = "Special Report"
}

enum LaguageCode: String {
    case aisa = "aisa"
    case eu = "eu"
    case us = "us"
}

class ArticleViewModel {
    
    // MARK: - Types

    enum ArticleDataError: Error {
        case noData
    }
    
    // MARK: - Properties
    var didFetchArticleData: ((GroupedArticle?, ArticleDataError?)-> Void)?
    private let networkService: NetworkService

    // MARK: - Initialization
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Helper Methods
    // Fetch Article Data
    func fetchArticleData() {
        
        // Initialize FX Article request
        let articleRequest = ArticleRequest(baseUrl: ArticleService.baseUrl, api: ArticleService.dashboardApi)
        
        // Create data task
        networkService.fetchData(with: articleRequest.url) { [weak self] (data, response, error) in
            if let _ = error {
                self?.didFetchArticleData?(nil, .noData)
            } else if let data = data {
                // Initialize JSON Decoder
                let decoder = JSONDecoder()
                do {
                    // Decode json response
                    let response = try decoder.decode(FXArticleResponse.self, from: data)
                   
                    // Create presentable data
                    let groupedData = self?.createGroupedData(response)
                    
                    // Invoke completion handler
                    self?.didFetchArticleData?(groupedData, nil)
                }
                catch {
                    // Invoke completion handler
                    self?.didFetchArticleData?(nil, .noData)
                }
            } else {
                self?.didFetchArticleData?(nil, .noData)
            }
        }
    }

    func createGroupedData(_ articleData: FXArticleResponse) -> GroupedArticle {
        var groupedData: [[GroupedTitle: [SpecialReport]]] = []
        if let breakingNews = articleData.breakingNews {
            groupedData.append([GroupedTitle.breakingNews: breakingNews])
        }
        if let topNews = articleData.topNews {
            groupedData.append([GroupedTitle.topNews: topNews])
        }
        if let dailyBriefing = articleData.dailyBriefings,
           let localDailyBriefings = getLocalBriefings(dailyBriefing) {
            groupedData.append([GroupedTitle.localDailyBriefings: localDailyBriefings])
        }
        if let techAnalysis = articleData.technicalAnalysis {
            groupedData.append([GroupedTitle.technicalAnalysis: techAnalysis])
        }
        if let specialReport = articleData.specialReport {
            groupedData.append([GroupedTitle.specialReport: specialReport])
        }
        return GroupedArticle(category: groupedData)
    }
    
    func getLocalBriefings(_ dailyBriefing: DailyBriefings) -> [SpecialReport]? {
        var localDailyBriefings: [SpecialReport]?
        switch NSLocale.current.languageCode {
        case LaguageCode.eu.rawValue:
            localDailyBriefings = dailyBriefing.eu ?? []
        case LaguageCode.us.rawValue:
            localDailyBriefings = dailyBriefing.us ?? []
        default:
            localDailyBriefings = dailyBriefing.asia ?? []
        }
        return localDailyBriefings
    }
}
