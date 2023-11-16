//
//  NetworkingController.swift
//  StatefulMovieDatabase
//
//  Created by Briana Bayne on 6/22/23.
//

import Foundation
import UIKit.UIImage

@available(iOS 16.0, *)
struct NetworkingController {
    
    func fetch(endpoint: String, with searchTerm: String, completion: @escaping (Result<TopLevelDictonary, ResultError>) -> Void) {
        guard let baseurl = URL(string:"https://api.themoviedb.org/3/search") else {completion(.failure(.invalidURL)); return}
        
        var urlRequest = URLRequest(url: baseurl)
        urlRequest.url?.append(path: endpoint)
        let apiKeyQueryItem = URLQueryItem(name:"api_key", value: "1622677c9c625ef4e4e27c015befec5f")
        let searchQueryItem = URLQueryItem(name: "query", value: searchTerm)
        urlRequest.url?.append(queryItems: [apiKeyQueryItem, searchQueryItem])
        print(urlRequest.url)
        
        URLSession.shared.dataTask(with: urlRequest) {movieData, movieResponse, error in
            
            if let error {
                completion(.failure(.thrownError(error))); return
            }
            if movieResponse == nil {
                completion(.failure(.noResponse)); return
            }
            guard let movieData else {completion(.failure(.noData)); return}
            do {
                
                let topLevelDictonary = try JSONDecoder().decode(TopLevelDictonary.self, from: movieData)
                completion(.success(topLevelDictonary))
                print("Lets, go!")
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
        
    }
    
    func fetchImage(with movie: Movie, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
        guard let baseurl = URL(string: "https://image.tmdb.org/t/p/w500") else {return}
        var urlRequest = URLRequest(url: baseurl) //
        guard let movie = movie.posterPath else {return}
        urlRequest.url?.append(path: movie)
        
        
        URLSession.shared.dataTask(with: urlRequest) { imageData, _, error in
            if let error {
                completion(.failure(.invalidURL)); return
                
            }
            guard let imageData else {completion(.failure(.noData)); return }
            guard let moviePoster = UIImage(data: imageData) else {completion(.failure(.unableToDecode)); return }
            completion(.success(moviePoster))
            
        }.resume()
    }
    
    func fetchMovieDetail(for id: Int, callback: @escaping(Result<MovieDetailDict, ResultError>) -> Void) {
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/movie") else {callback(.failure(.invalidURL)); return}
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.url?.append(path:"\(id)")
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "1622677c9c625ef4e4e27c015befec5f")
        urlRequest.url?.append(queryItems: [apiKeyQueryItem])
        
        URLSession.shared.dataTask(with: urlRequest) { movieDetailData, _, movieDetailError in
            
            if let movieDetailError {
                callback(.failure(.thrownError(movieDetailError))); return
            }
            guard let movieDetailData else { callback(.failure(.noData)); return }
            
            do {
                let movieDetailDict =  try JSONDecoder().decode(MovieDetailDict.self, from: movieDetailData)
                callback(.success(movieDetailDict))
            } catch {
                callback(.failure(.unableToDecode)); return
            }
            
        }.resume()
    }
}
