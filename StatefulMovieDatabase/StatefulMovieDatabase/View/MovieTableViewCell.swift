//
//  MovieTableViewCell.swift
//  StatefulMovieDatabase
//
//  Created by Karl Pfister on 2/9/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    
    
    func updateView(movie: Movie) {
        fetchImage(movie: movie)
    }
    
    
    func fetchImage(movie:Movie) {
        if #available(iOS 16.0, *) {
            NetworkingController().fetchImage(with: movie) { [weak self] result in
                switch result {
                case.success(let poster):
                    DispatchQueue.main.async {
                        self?.movieImage.image = poster
                        self?.movieSynopsisLabel.text = movie.synopsis
                        self?.movieTitleLabel.text = movie.title
                        
                        
                    }
                case.failure(let failure):
                    print(failure.errorDescription!)
                }
                
                
                
                
                // MARK: - Functions
                
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
