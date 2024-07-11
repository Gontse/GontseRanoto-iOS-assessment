//
//  APIService.swift
//  About-You
//
//  Created by Gontse on 2024/07/11.
//

protocol APIService {

  func fetchEngineers() async throws -> [Engineer]
  
}
