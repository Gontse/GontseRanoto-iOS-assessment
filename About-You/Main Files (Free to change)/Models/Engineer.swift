import UIKit

struct EngineerResponseModel: Codable {
    let engineers: [Engineer]
}

struct Engineer: Codable {
    var name: String
    var role: String
    var defaultImageName: String?
    var quickStats: QuickStats
    var questions: [Question]
}

struct QuickStats: Codable {
    var years: Int
    var coffees: Int
    var bugs: Int
}

extension Engineer {
  static func loadEngineers() -> [Engineer] {
      guard let url = Bundle.main.url(forResource: "Engineers", withExtension: "json") else {
        fatalError("Failed to locate file in bundle.")
      }
      
      do {
        let data = try Data(contentsOf: url)
        let response = try JSONDecoder().decode(EngineerResponseModel.self, from: data)
        return response.engineers
      } catch {
        fatalError("Failed to load and decode file: \(error)")
      }
    }
}
