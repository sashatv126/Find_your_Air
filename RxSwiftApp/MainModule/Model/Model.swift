import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let modelResponse = try? newJSONDecoder().decode(ModelResponse.self, from: jsonData)

import Foundation

// MARK: - ModelResponseElement
struct ModelResponseElement : Codable {
    let code: String
    let lat: String
    let lon: String
    let name: String
    let city: String
    let state: String?
    let country: String
    let woeid: String
    let tz: String
    let phone: String
    let type: String
    let email: String
    let url: String
    let runwayLength: String?
    let elev: String?
    let icao: String
    let carriers: String
}



extension ModelResponseElement : Equatable {
    
    static func == (lhs : ModelResponseElement, rhs : ModelResponseElement) -> Bool {
        return lhs.code == rhs.code
    }
}

extension ModelResponseElement : Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }
}

