//
//  EngineersViewModel.swift
//  About-You
//
//  Created by Gontse on 2024/07/11.
//

import Foundation

final class EngineersViewModel {
  
  private var interactor: EngineersBoundary!
  private(set) var engineers: [Engineer] = []
  @Published private(set) var didFetchData: Bool!
  @Published private(set) var error: Error?
  
  init(interactor: EngineersBoundary = EngineersInteractor()) {
    self.interactor = interactor
  }
  
  func fetchEngineers() {
    Task {
        do {
          engineers = try await interactor.fetchEngineers()
          didFetchData = (engineers.count > 0)
        } catch {
          didFetchData = false
          self.error = error
        }
    }
  }
  
  func getEngineer(for row: Int) -> (name: String, role: String)? {
    guard row <= engineers.count else { return nil }
    let selectedEngineer = engineers[row]
    
    return (selectedEngineer.name, selectedEngineer.role)
  }
  
  func getEngineerQuestions(for row: Int) -> [Question] {
    guard row <= engineers.count else { return [] }
    return engineers[row].questions
  }
  
  func sortEngineers(By filterValue: OrderByFilter) {
    engineers = switch filterValue {
    case .years:
      engineers.sorted(using: KeyPathComparator(\.quickStats.years))
    case .coffee:
      engineers.sorted(using: KeyPathComparator(\.quickStats.coffees))
    case .bugs:
      engineers.sorted(using: KeyPathComparator(\.quickStats.bugs))
    }
  }
  
}
