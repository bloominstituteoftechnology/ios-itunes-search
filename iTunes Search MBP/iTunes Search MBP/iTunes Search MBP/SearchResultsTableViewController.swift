import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!

    let searchResultsController = SearchResultController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    @IBAction func segmentedAction(_ sender: Any) {
        var resultType: ResultType!
        guard let search = searchBar.text, search.count > 0 else {return}
        let index = segmented.selectedSegmentIndex
        if index == 0 {
            resultType = ResultType.software
        } else if index == 1 {
            resultType = .musicTrack
        } else {
            resultType = .movie
        }
        searchResultsController.performSearch(with: search, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error performing search: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        var resultType: ResultType!
        guard let search = searchBar.text, search.count > 0 else {return}
        let index = segmented.selectedSegmentIndex
        if index == 0 {
            resultType = ResultType.software
        } else if index == 1 {
            resultType = .musicTrack
        } else {
            resultType = .movie
        }
        searchResultsController.performSearch(with: search, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error performing search: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let searchResult = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.crator
        // Configure the cell...

        return cell
    }
   
}



