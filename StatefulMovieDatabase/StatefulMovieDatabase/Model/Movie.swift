//
//  Movie.swift
//  StatefulMovieDatabase
//
//  Created by Briana Bayne on 6/22/23.
//

import Foundation

struct TopLevelDictonary: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
        
    }
    let currentPage: Int
    let movies: [Movie]
    let totalPages: Int
    let totalResults: Int
    
}

struct Movie: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title
        case synopsis = "overview"
        case posterPath = "poster_path"
        case id 
        
    }
    
    let title: String
    let synopsis: String
    let posterPath: String?
    let id: Int
    
    
}
