//
//  Keywords.swift
//  News-Snap
//
//  Created by 선가연 on 8/30/24.
//

struct Keyword: Decodable {
    let keyword: String
}

struct KeywordsResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [Keyword]
}
