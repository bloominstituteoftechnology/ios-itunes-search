//
//  SearchResult.swift
//  Itunes Search 2
//
//  Created by Michael Flowers on 1/29/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    //codingkeys allow us to and map the keys from the JSON to the properties we want their values to be stored in. meaning that if our struct property's name don't match what is on the JSON then we use codingkeys to help codable keep track of what it's parsing.
    
    enum CodingKeys: String, CodingKey {
        
        //When the decoder is going through JSON it will now look for a key called "trackName", but instead of trying to put that value in a property called "trackName" ( which in this struct does not exist, thus making the decoding fail), it knows to put the value in a property called title because that is the name of the raw value's case.
        
        case title = "trackName"
        case creator = "artistName"
    }
}

//The JSON object that represent each SearchResult are nested in the JSON. We need to create an object that represents the JSON at the HIGHEST level.

struct SearchResults: Codable {
    var results: [SearchResult] //this will allow us to decode the JSON data into this object, then access the actual search results through its' results property
}
