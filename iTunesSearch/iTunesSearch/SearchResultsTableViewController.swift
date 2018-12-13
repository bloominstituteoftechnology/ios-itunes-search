import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchResultsController = SearchResultController()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        var resultType: ResultType!
        let index = segmentedControl.selectedSegmentIndex
        
        let index == 0 {
            resultType = .software
            
        } else if index == 1 {
            resultType = .musicTrack
            
        } else {
            resultType = .movie
        }
        SearchResultController.shared.performSearch(with: searchTerm, resultType: resultType) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    //tableview funcs
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
}

