//
//  CryptoDetails.swift
//  CryptoApp
//
//  Created by Yunus Emre Koca on 6.09.2022.
//

import Foundation

struct CryptoDetails: Codable {
    var description: Description?
    let links: Links?
}

struct Links: Codable {
    let homepage: [String]?
}

struct Description: Codable {
    var en: String?
}
