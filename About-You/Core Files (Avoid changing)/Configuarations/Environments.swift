//
//  Environments.swift
//  About-You
//
//  Created by Gontse on 2024/07/11.
//

import Foundation

struct Environment { var baseUrl: URL }

extension Environment {
  static let localHost = Environment(baseUrl: URL(string: "https://localhost/api")!) 
  static let QA = Environment(baseUrl: URL(string: "https://GlucodeQAServer/api")!)
  static let stub = Environment(baseUrl: URL(string: "stub")!)
}


extension Environment: Equatable { }
