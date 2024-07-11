//
//  EngineersInteractor.swift
//  About-You
//
//  Created by Gontse on 2024/07/11.
//

class EngineersInteractor: EngineersBoundary {
  private let client = APIClient()
  
  func fetchEngineers() async throws -> [Engineer] {
   return try await client.fetchEngineers()
  }
}
