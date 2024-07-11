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


extension APIError :LocalizedError {
  var localizedDescription: String {
   return switch self {
    case .unknown:
     NSLocalizedString("unknown", comment: "")
    case .unreachable:
     NSLocalizedString("unreachable", comment: "")
    case .invalidResponse:
     NSLocalizedString("invalidResponse", comment: "")
   case .failedRequest:
     NSLocalizedString("failedRequest", comment: "")
   }
  }
}
