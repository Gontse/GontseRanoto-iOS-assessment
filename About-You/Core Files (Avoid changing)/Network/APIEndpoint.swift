//
//  APIEndpoint.swift
//  About-You
//
//  Created by Gontse on 2024/07/11.
//

import Foundation

typealias Headers = [String: String]

enum APIEndpoint {
  
  // TODO: revise endpoint name once service is ready
  case getEngineers
  
  private var headers: Headers {
    let headers = ["Content-Type" : "application/json"]
    return headers
  }
  
  var request: URLRequest {
    var request = URLRequest(url: url)
    request.addHeaders(headers)
    request.httpMethod = action.rawValue
    
    return request
  }
  
  var environmentSet: Environment {
    return Environment.stub
  }
  
  private var url: URL {
    return environmentSet.baseUrl.appendingPathComponent(path)
  }
  
  private var path: String {
    switch self {
    case .getEngineers:
      return "getEngineers"
    }
  }
  
  private var action: HTTPAction {
    switch self {
    case .getEngineers:
      return .get
    }
  }
}

// MARK: - URLRequest

fileprivate extension URLRequest {
  
  mutating func addHeaders(_ headers: Headers) {
    headers.forEach { header, value in
      addValue(value, forHTTPHeaderField: header)
    }
  }
}

