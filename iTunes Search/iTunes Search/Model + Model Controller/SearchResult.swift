//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Jason Modisett on 9/11/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation
import UIKit

protocol Searchable { var results: [SearchableResults] { get set }}
protocol SearchableResults: Codable {}

enum CodingKeys: String, CodingKey {
    case songTitle, movieTitle, appName = "trackName"
    case artist, director, developer = "artistName"
    case appIconUrl, moviePosterUrl, albumArtworkUrl = "arworkUrl100"
    case category = "primaryGenreName"
    case appPrice = "formattedPrice"
    case songPrice, moviePrice = "trackPrice"
    case itunesUrl = "trackViewUrl"
}

// MARK:- App
struct AppSearchResults: Codable {
    var results: [App]
}

struct App: Codable, SearchableResults {
    let appName: String
    let developer: String
    let category: String
    let appPrice: String
    let screenshotUrls: [String]
    let itunesUrl: String
}

// MARK:- Movie
struct MovieSearchResults: Codable {
    var results: [Movie]
}

struct Movie: Codable, SearchableResults {
    let movieTitle: String
    let director: String
    let moviePosterUrl: String
    let shortDescription: String
    let moviePrice: CGFloat
    let itunesUrl: String
}

// MARK:- Music
struct MusicSearchResults: Codable {
    var results: [Music]
}

struct Music: Codable, SearchableResults {
    let songTitle: String
    let artist: String
    let albumArtworkUrl: String
    let songPrice: CGFloat
    let itunesUrl: String
}
