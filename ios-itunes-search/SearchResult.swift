import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey { //enums have cases
        case title = "trackName"
        case creator = "artistName"
    }
}

//allow us to decode the JSON data into this object, access the actual search results through its results property
struct ResultsList: Codable {
    let results: [SearchResult]

}
