//
//  Scrap.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 7/18/24.
//

import Foundation

struct Scrap {
    var id : Int
    var link : String
    var contents : String
    var keywords : [String]
    var date : Date
    var attachmentFile : String
    var refereceLink : [String]
    
    init(id: Int, link: String, contents: String, keywords: [String], date : Date, attachmentFile : String, referenceLink : [String]) {
        self.id = id
        self.link = link
        self.contents = contents
        self.keywords = keywords
        self.date = date
        self.attachmentFile = attachmentFile
        self.refereceLink = referenceLink
    }
}

