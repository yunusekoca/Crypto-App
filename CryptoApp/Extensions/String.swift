//
//  String.swift
//  CryptoApp
//
//  Created by Yunus Emre Koca on 6.09.2022.
//

import Foundation

extension String {
    func removeHTMLTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
