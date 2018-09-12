//
//  iTunesSearchTableViewController.swift
//  iTunes Search
//
//  Created by Jason Modisett on 9/11/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    
    private func performSearchUsing(searchText: String, searchCountry: SearchCountry) {
        results = []
        tableView.reloadData()
        searchResultsController.performSearch(with: searchText, resultType: resultType, searchCountry: searchCountry) { (error) in
            self.results = self.searchResultsController.searchResults
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let result = results?[indexPath.row],
              let image = URL(string: result.imageUrl ?? "") else { return UITableViewCell() }
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            tableView.rowHeight = 300
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultCellsReuseIdentifiers.appCell.rawValue, for: indexPath) as? AppCell,
                let screenshotUrlStrings = result.screenshotUrls,
                let appImage = URL(string: result.appImageUrl ?? "") else { return UITableViewCell() }
            
            cell.result = result
            let screenshotUrls = screenshotUrlStrings.map { URL(string: $0) }
            
            DispatchQueue.main.async {
                cell.appIconImageView.image = nil
                cell.screenshotImageView.image = nil
                cell.screenshotImageView2.image = nil
                cell.screenshotImageView3.image = nil
                
                self.imageManager.fetchImage(url: appImage) { image in
                    if let image = image { cell.appIconImageView.image = image }
                }
                self.imageManager.fetchImage(url: screenshotUrls[0]!, completion: { image in
                    if let image = image { cell.screenshotImageView.image = image }
                })
                self.imageManager.fetchImage(url: screenshotUrls[1]!, completion: { image in
                    if let image = image { cell.screenshotImageView2.image = image }
                })
                self.imageManager.fetchImage(url: screenshotUrls[2]!, completion: { image in
                    if let image = image { cell.screenshotImageView3.image = image }
                })
            }
            
            return cell
        case 1:
            tableView.rowHeight = 90
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultCellsReuseIdentifiers.musicCell.rawValue, for: indexPath) as? MusicCell else { return UITableViewCell() }
            
            cell.result = result
            
            DispatchQueue.main.async {
                cell.albumArtworkView.image = nil
                
                self.imageManager.fetchImage(url: image) { image in
                    if let image = image { cell.albumArtworkView.image = image }
                }
            }
            
            return cell
        case 2:
            tableView.rowHeight = 130
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultCellsReuseIdentifiers.movieCell.rawValue, for: indexPath) as? MovieCell else { return UITableViewCell() }
            
            cell.result = result
            
            DispatchQueue.main.async {
                cell.moviePosterImageView.image = nil
                
                self.imageManager.fetchImage(url: image) { image in
                    if let image = image { cell.moviePosterImageView.image = image }
                }
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let result = results?[indexPath.row],
              let url = URL(string: result.itunesUrl) else { return }
        UIApplication.shared.open(url)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { return UIView() }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        performSearchUsing(searchText: searchBar.text ?? "", searchCountry: searchCountry)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" { performSearchUsing(searchText: searchText, searchCountry: searchCountry) }
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        results = []
        performSearchUsing(searchText: searchBar.text ?? "", searchCountry: searchCountry)
    }
    
    
    let searchResultsController = SearchResultController()
    let imageManager = ImageCacheManager()
    
    var results: [SearchResult]? = []
    var searchCountry = SearchCountry.USA
    
    var resultType: ResultType {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return ResultType.software
        case 1:
            return ResultType.music
        case 2:
            return ResultType.movie
        default:
            return ResultType.software
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
}
