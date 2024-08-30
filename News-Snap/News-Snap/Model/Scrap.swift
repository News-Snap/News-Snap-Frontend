//
//  Scrap.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 7/18/24.
//

import Foundation

struct Scrap : Codable {
    var title : String
    var link : String
    var contents : String
    var keywords : [String]
    var date : Date
    var attachmentFile : String
    var referenceLink : [String]
    
    init(title: String, link: String, contents: String, keywords: [String], date : Date, attachmentFile : String, referenceLink : [String]) {
        self.title = title
        self.link = link
        self.contents = contents
        self.keywords = keywords
        self.date = date
        self.attachmentFile = attachmentFile
        self.referenceLink = referenceLink
    }
}

struct APIResponse: Codable {
    let result: ScrapResult
}

struct ScrapResult: Codable {
    let title: String
    let content: String
    let articleUrl: String
    let keywords: [String]
    let modifiedAt: String
    let fileUrl: String?
    let relatedUrlList: [String]
}

struct APIScrapDataResponse: Codable {
    let result: [SearchNewsItemResult]
}

struct SearchNewsItemResult: Codable {
    let scrapId: Int
    let title: String
    var keywords : [String]
    let updatedAt: String
}
