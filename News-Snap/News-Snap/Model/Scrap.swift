//
//  Scrap.swift
//  News-Snap
//
//  Created by Jinyoung Leem on 7/18/24.
//

import Foundation

struct Scrap {
    let id : Int
    var link : String
    var contents : String
    var keywords : [String]
    
    var attachmentFile : FileManager?
    var referenceFile : FileManager?
    
    init(id: Int, link: String, contents: String, keywords: [String]) {
        self.id = id
        self.link = link
        self.contents = contents
        self.keywords = keywords
    }
    
    
    
}

