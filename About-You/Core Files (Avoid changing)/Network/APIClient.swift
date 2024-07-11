//
//  APIClient.swift
//  About-You
//
//  Created by Gontse on 2024/07/11.
//

import Foundation

class APIClient: APIService {
  func fetchEngineers() async throws -> [Engineer] {
    try await request(.getEngineers)
  }
  
  // MARK: Private Generic Network Request
  private func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
    guard endpoint.environmentSet != .stub else {
     return switch endpoint {
      case .getEngineers:
       Engineer.loadEngineers() as! T
      }
    }
    
    let (data, response) = try await URLSession.shared.data(for: endpoint.request)
    guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else { throw APIError.failedRequest }
    
    do {
      let results = try JSONDecoder().decode(T.self, from: data)
      return results
    } catch {
      throw switch error {
      case let apiError as APIError: apiError
      case URLError.notConnectedToInternet: APIError.unreachable
      default: APIError.invalidResponse
      }
    }
  }
}
