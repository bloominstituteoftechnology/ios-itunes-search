import Foundation
struct SearchResult: Codable {
    let title: String?
    let creator: String

    struct SearchResults: Codable {
        let results: [SearchResult]
    }
    
    enum CodingKeys: String, CodingKey {
        // Give it a raw value of "trackName"
        case title = "trackName"
        case creator = "artistName"
    }
}

    

