//
//  DeatilMovieViewController.swift
//  StatefulMovieDatabase
//
//  Created by Briana Bayne on 6/23/23.
//


import UIKit

class MovieDetailViewController: UIViewController {

// MARK: - Outlets 
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var taglineMovieLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieBudgetLabel: UILabel!
    @IBOutlet weak var movieRevLabel: UILabel!
    @IBOutlet weak var movieRunTimeLabel: UILabel!
    @IBOutlet weak var moviePopularityLabel: UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    
    // MARK: - Properties
    var movieDetailSendViaSegue: MovieDetailDict? {
        didSet {
            updateView()
        }
    }
    var moviePosterSentViaSegue: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
// MARK: - Methods
    func updateView() {
        guard let unwrapedMovieDetailDict = movieDetailSendViaSegue,
              let unwrapedMoviePoster = moviePosterSentViaSegue else { return }
        
        DispatchQueue.main.sync {
            self.movieTitleLabel.text = unwrapedMovieDetailDict.title
            self.taglineMovieLabel.text = unwrapedMovieDetailDict.tagline
            self.movieImage.image = unwrapedMoviePoster
            self.movieBudgetLabel.text = "\(unwrapedMovieDetailDict.budget)"
            self.movieRevLabel.text = "\(unwrapedMovieDetailDict.revenue)"
            self.movieRunTimeLabel.text = "\(unwrapedMovieDetailDict.runtime)"
            self.moviePopularityLabel.text = "\(unwrapedMovieDetailDict.popularity)"
            self.movieOverView.text = unwrapedMovieDetailDict.overview
            
        }
    }
}
