import Foundation

struct SearchResult: Codable {
    
    let title: String
    let creator: String
}

enum CodingKeys: String, CodingKey {
    
    case title = "trackName"
    case creater = "artistName"
    }

struct SearchResults: Codable {
    
    let results: [SearchResult]
}


    

