//
//  FXArticleResponse.swift
//  FXArticle
//
//  Created by Shashank Mishra on 27/11/21.
//

import Foundation

struct GroupedArticle {
    var category: [[GroupedTitle: [SpecialReport]]]
}

// MARK: - FXArticleResponse
struct FXArticleResponse: Codable {
    let breakingNews: [SpecialReport]?
    let topNews: [SpecialReport]?
    let dailyBriefings: DailyBriefings?
    let technicalAnalysis: [SpecialReport]?
    let specialReport: [SpecialReport]?
}

// MARK: - DailyBriefings
struct DailyBriefings: Codable {
    let eu, asia, us: [SpecialReport]?
}

// MARK: - SpecialReport
struct SpecialReport: Codable {
    let title: String
    let url: String
    let specialReportDescription: String
    let content, firstImageURL: String?
    let headlineImageURL: String?
    let articleImageURL, backgroundImageURL: String?
    let videoType, videoID: String?
    let videoURL: String?
    let videoThumbnail: String?
    let newsKeywords: String?
    let authors: [[String: String?]]
    let instruments: [String]?
    let tags: [String]?
    let categories: [String]
    let displayTimestamp, lastUpdatedTimestamp: Int

    enum CodingKeys: String, CodingKey {
        case title, url
        case specialReportDescription = "description"
        case content
        case firstImageURL = "firstImageUrl"
        case headlineImageURL = "headlineImageUrl"
        case articleImageURL = "articleImageUrl"
        case backgroundImageURL = "backgroundImageUrl"
        case videoType
        case videoID = "videoId"
        case videoURL = "videoUrl"
        case videoThumbnail, newsKeywords, authors, instruments, tags, categories, displayTimestamp, lastUpdatedTimestamp
    }
}
