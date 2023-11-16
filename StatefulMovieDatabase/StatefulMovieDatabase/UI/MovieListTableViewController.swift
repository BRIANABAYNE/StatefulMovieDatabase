//
//  MovieListTableViewController.swift
//  StatefulMovieDatabase
//
//   Created by Briana Bayne on 6/23/23.

import UIKit


@available(iOS 16.0, *)
class MovieListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Property
    
    var tld: TopLevelDictonary?
    
    // MARK: - Lifecyles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tld?.movies.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        guard let movie = tld?.movies[indexPath.row] else {return UITableViewCell()}
        cell.updateView(movie: movie)
        return cell
    }
    
    // MARK: -  Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "toDetailVC",
              let indexPath = tableView.indexPathForSelectedRow,
              let cell = tableView.cellForRow(at: indexPath) as? MovieTableViewCell,
              let destination = segue.destination as? MovieDetailViewController,
              let movie = cell.movieToSendInSegu  else {return}
        
        let movieImage = cell.moviePosterToSendInSegu
        
        NetworkingController().fetchMovieDetail(for: movie.id) { result in
            switch result {
            case .success(let movieDetailDict):
                destination.moviePosterSentViaSegue = movieImage
                destination.movieDetailSendViaSegue = movieDetailDict
            case.failure(let error):
                print("Shit!", error.errorDescription!)
            }
        }
            
        }
    }

// MARK: - Extension
@available(iOS 16.0, *)
extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        
        NetworkingController().fetch(endpoint: "movie", with: searchTerm) {[weak self] result in
            switch result {
            case.success(let tld):
                DispatchQueue.main.async {
                    self?.tld = tld
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print(error.errorDescription!)
            }
        }
        searchBar.resignFirstResponder()
    }
}
