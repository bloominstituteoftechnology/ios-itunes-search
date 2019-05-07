//
//  SearchResult.swift
//  iTunesHW
//
//  Created by Michael Flowers on 5/7/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    //We can implement another part of codable that lets us override ths behavior called "CodingKeys".  CodingKeys allow us  to map the keys from the JSON to the properties we want their values to be stored in.
    
    enum CodingKeys: String, CodingKey {
        //When the decoder is going the the JSON it will now look for a key called trackName, but instead of trying to put that value n a property called trackName (which in ths struct doesn't exist, thus making the decoding fail), it knows to put the value in a property called title.
        case title = "trackName"
        case creator = "artistName"
    }
}

//We need to create an object that represents the JSON at the hghest level ( the object with resultCount and results keys).
struct SearchResults: Codable {
    let results: [SearchResult]  //the property name has to match exactly what the JSON is. 
}
