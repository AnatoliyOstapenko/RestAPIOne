//
//  ApiService.swift
//  RestAPIOne
//
//  Created by MacBook on 22.10.2021.
//

import Foundation

struct ApiService {
    
    
    private var dataTask: URLSessionDataTask?
    
    
    mutating func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=ec525aa05dd1cada9b2013d7edff1363"
        guard let url = URL(string: popularMoviesURL) else { return }
        
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil, let data = data else { return }
            
            do {
                // Parse data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
                
                
            } catch { print(error.localizedDescription)}
        }
        dataTask?.resume()
    }
}
