import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

//This will allow us to decode the JSON data into this object, then access the actual search results through its results property
struct SearchResults: Codable {
    let results: [SearchResult]
}
