//
//  CryptoCellViewModel.swift
//  CryptoApp
//
//  Created by Yunus Emre Koca on 5.09.2022.
//

import Foundation

final class CryptoCellViewModel {
    
    private let responseModel: Cryptocurrency
    
    init(model: Cryptocurrency) {
        self.responseModel = model
    }
    
    var name: String {
        return responseModel.name + " (\(responseModel.symbol.uppercased()))"
    }
    
    var currentPriceUSD: String {
        return "\(responseModel.currentPrice) $"
    }
    
    var imageURL: URL? {
        guard let url = URL(string: responseModel.image) else { return nil }
        return url
    }
}
