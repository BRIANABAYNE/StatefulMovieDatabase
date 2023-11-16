//
//  MovieTableViewCell.swift
//  StatefulMovieDatabase
//
// Created by Briana Bayne on 6/23/23.
//

import UIKit

@available(iOS 16.0, *)
class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    
    // MARK: - Properties
    var movieToSendInSegu: Movie?
    var moviePosterToSendInSegu: UIImage?
    
    // MARK: - Lifecycles
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = nil
    }
// MARK: - Methods
    func updateView(movie: Movie) {
        movieToSendInSegu = movie
        fetchImage(movie: movie)
    }
    
    func fetchImage(movie:Movie) {
        guard let posterPath = movie.posterPath else { return }
        
        NetworkingController().fetchImage(with: movie) { [weak self] result in
            switch result {
            case.success(let poster):
                DispatchQueue.main.async {
                    self?.moviePosterToSendInSegu = poster
                    self?.movieImage.image = poster
                    self?.movieSynopsisLabel.text = movie.synopsis
                    self?.movieTitleLabel.text = movie.title
                }
                
            case.failure(let failure):
                print(failure.errorDescription!)
            }
        }
    }
}
