import Foundation

struct SearchResult: Codable {

    let title: String
    let artist: String
    
    enum CodingKeys: String, CodingKey {
        typealias RawValue = String
        
        case title = "trackName"
        case artist = "artistName"
    }
    
}

struct SearchResults: Codable {
        
    let results: [SearchResult]
}
    

