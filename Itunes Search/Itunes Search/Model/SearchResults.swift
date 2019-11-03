//
//  SearchResults.swift
//  Itunes Search
//
//  Created by Nicolas Rios on 11/2/19.
//  Copyright © 2019 Nicolas Rios. All rights reserved.
//

import Foundation

struct SearchResult {
    var title: String
    var creator: String

    enum CodingKeys: String, CodingKey {
        typealias RawValue = <#type#>
        

    }

}
