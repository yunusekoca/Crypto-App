//
//  ServiceError.swift
//  CryptoApp
//
//  Created by Yunus Emre Koca on 5.09.2022.
//

import Foundation

enum ServiceError: Error {
    case connectionError
    case urlError
}

extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .connectionError:
            return "Connection Error"
        case .urlError:
            return "URL Error"
        }
    }
}
