//
//  MovieDetail.swift
//  StatefulMovieDatabase
//
//  Created by Briana Bayne on 6/23/23.
//

import Foundation

struct MovieDetailDict: Decodable {
    
    let budget: Int
    let revenue: Int
    let tagline: String
    let title: String
    let popularity: Double
    let runtime: Int
    let overview: String
    
}
