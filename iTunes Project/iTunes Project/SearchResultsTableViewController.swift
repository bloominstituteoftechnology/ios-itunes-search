import UIKit


class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    let reuseIdentifier = "cell"
    
    let searchResultsController = SearchResultController()
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        var resultType: ResultType!
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return resultType = ResultType.apps
        } else if segmentedControl.selectedSegmentIndex == 1 {
            return resultType = ResultType.music
        } else if segmentedControl.selectedSegmentIndex == 2 {
            return resultType = ResultType.movies
        }
        searchResultsController.performSearch(with: searchTerm, resultType: resultType) { (NSError?) in
            
        }
    }
    
//        switch segmentedControl.selectedSegmentIndex{
//        case 0:
//            resultType = .software
//        case 1:
//            resultType = .musicTrack
//        case 2:
//            resultType = .movie
//        }
        
//        searchResultsController.performSearch(with: searchTerm, resultType: <#ResultType#>) { searchResults, error in
//            if let error = error {
//                NSLog("error fetching search results: \(error)")
//            }
//
//        SWAPI.searchForPeople(with: string) { people, error in
//            if let error = error {
//                NSLog("Error fetching people: \(error)")
//                return
//            }
//            self.people = people ?? []
//        Model.shared.search(for: searchTerm)
  
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       return searchResultsController.searchResults.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
       //how to configure???
        let searchResult = searchResultsController.searchResults[indexPath.row]
        
    
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }
}
