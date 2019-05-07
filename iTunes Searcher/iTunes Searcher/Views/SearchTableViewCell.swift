//
//	SearchTableViewCell
//  iTunes Searcher
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
	var searchResultController: SearchResultController?
	var searchResult: SearchResult? {
		didSet {
			
		}
	}
}
