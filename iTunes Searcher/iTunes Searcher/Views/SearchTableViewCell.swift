//
//	SearchTableViewCell
//  iTunes Searcher
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
	var dataGetter: MahDataGetter?
	var searchResult: SearchResult? {
		didSet {
			updateViews()
		}
	}

	private func updateViews() {
		textLabel?.text = searchResult?.title
		detailTextLabel?.text = searchResult?.creator
		imageView?.image = nil

		setImage()
	}

	private func setImage() {
		guard let artworkURL = searchResult?.artworkURL,
			let url = URL(string: artworkURL) else { return }
		let request = URLRequest(url: url)

		dataGetter?.fetchMahDatas(with: request, requestID: searchResult?.artworkURL) { [weak self] (requestID, data, error) in
			guard error == nil else { return }
			guard requestID == self?.searchResult?.artworkURL else { return }
			guard let data = data else { return }

			let image = UIImage(data: data)

			DispatchQueue.main.async {
				self?.imageView?.image = image
				//FIXME: Is this the right call to update the cell, or is this hacky and there's a better way?
				self?.layoutSubviews()
			}
		}
	}
}
