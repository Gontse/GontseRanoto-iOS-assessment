//
//  APIError.swift
//  About-You
//
//  Created by Gontse on 2024/07/11.
//

import Foundation

enum APIError: Error {
  
  case unknown
  case unreachable
  case failedRequest
  case invalidResponse
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("unknown", comment: "")
        case .unreachable:
            return NSLocalizedString("unreachable", comment: "")
        case .failedRequest:
            return NSLocalizedString("failedRequest", comment: "")
        case .invalidResponse:
            return NSLocalizedString("invalidResponse", comment: "")
        }
    }
}
