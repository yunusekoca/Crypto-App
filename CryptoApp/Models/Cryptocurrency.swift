//
//  Cryptocurrency.swift
//  CryptoApp
//
//  Created by Yunus Emre Koca on 5.09.2022.
//

import Foundation

struct Cryptocurrency: Codable {
    let id: String
    let currentPrice: Double
    let symbol: String
    let name: String
    let image: String
    let highestLast24h: Double
    let lowestLast24h: Double
    let priceChangeLast24h: Double
    let priceChangePercentageLast24h: Double
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case highestLast24h = "high_24h"
        case lowestLast24h = "low_24h"
        case priceChangeLast24h = "price_change_24h"
        case priceChangePercentageLast24h = "price_change_percentage_24h"
    }
}
