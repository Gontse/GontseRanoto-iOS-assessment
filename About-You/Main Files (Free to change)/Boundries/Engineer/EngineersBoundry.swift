//
//  EngineersBoundary.swift
//  About-You
//
//  Created by Gontse on 2024/07/11.
//

protocol EngineersBoundary {
  func fetchEngineers() async throws -> [Engineer]
  
}
