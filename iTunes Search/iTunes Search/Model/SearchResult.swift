import Foundation

struct SearchResult: Codable {

    let title: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        typealias RawValue = String
        
        case title = "trackName"
        case artist = "artistName"
    }
    
    struct SearchResults {
        
        let results: [SearchResult]
    }
    
}
