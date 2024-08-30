//
//  popularStocks.swift
//  News-Snap
//
//  Created by 선가연 on 8/17/24.
//

struct Stock: Decodable {
    let stock: String
    let rank: Int
}

struct PopularStocksResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ResultData

    struct ResultData: Decodable {
        let popularStocks: [Stock]
    }
}
