//
//  EngineersViewModel_Tests.swift
//  About-YouTests
//
//  Created by Gontse on 2024/07/11.
//

import XCTest
import Combine
@testable import About_You

final class EngineersViewModel_Tests: XCTestCase {
  private var subscriptions: Set<AnyCancellable> = []
  private var viewModelTest: EngineersViewModel!
  private var interactor: MockEngineersIneteractor!
  
  override func setUp() {
    interactor = MockEngineersIneteractor()
    viewModelTest = EngineersViewModel(interactor: interactor)
  }
  
  override func tearDown() {
    viewModelTest = nil
    interactor = nil
  }
  
  func test_dataFetchSuccess() {
    let expectation = XCTestExpectation(description: "failure")
    viewModelTest.$didFetchData.receive(on: DispatchQueue.main).dropFirst(1).sink { isFetched in
      XCTAssertTrue(isFetched!)
      expectation.fulfill()
    }.store(in: &subscriptions)
    
    viewModelTest.fetchEngineers()
    wait(for: [expectation], timeout: 1)
  }
  
  func test_dataFetchFailure() {
    interactor.shouldsucceed = false
    let expectation = XCTestExpectation(description: "failure")
    viewModelTest.fetchEngineers()
    
    viewModelTest.$error.receive(on: DispatchQueue.main).sink{ error in
      guard let error else { return }
      XCTAssertEqual(error.localizedDescription, "unknown")
      expectation.fulfill()
    }.store(in: &subscriptions)
    
    wait(for: [expectation], timeout: 1)
  }
}

fileprivate final class MockEngineersIneteractor: EngineersBoundary {
 
  var shouldsucceed = true
  
  func fetchEngineers() async throws -> [Engineer] {
    guard shouldsucceed else {
      throw APIError.unknown
    }
   return TestData.fetchEngineers()
  }
}

fileprivate enum TestData {
  static func fetchEngineers() -> [Engineer] {
    return [
      Engineer(name: "Reenen",
               role: "Dev manager",
               defaultImageName: "",
               quickStats: QuickStats(years: 6, coffees: 5400, bugs: 1800),
               questions: [
                MainQuestions.questionOne(answer: Answer(text: "6am", index: 0)),
                MainQuestions.questionTwo(answer: Answer(text: "10 to 15 years old", index: 1)),
                MainQuestions.questionThree(answer: Answer(text: "Python", index: 0)),
                MainQuestions.questionFour(answer: Answer(text: "Every few months", index: 0)),
                MainQuestions.questionFive(answer: Answer(text: "Watch or read a tutorial", index: 3))
               ]),
      Engineer(name: "Wilmar",
               role: "Head of Engineering",
               defaultImageName: "",
               quickStats: QuickStats(years: 15, coffees: 4000, bugs: 4000),
               questions: [
                MainQuestions.questionOne(answer: Answer(text: "midnight", index: 3)),
                MainQuestions.questionTwo(answer: Answer(text: "10 to 15 years old", index: 1)),
                MainQuestions.questionThree(answer: Answer(text: "Python", index: 0)),
                MainQuestions.questionFour(answer: Answer(text: "Every few months", index: 0)),
                MainQuestions.questionFive(answer: Answer(text: "Call a coworker or friend", index: 2))
               ])
    ]
  }
}
