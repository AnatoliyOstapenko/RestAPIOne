//
//  MovieViewModel.swift
//  RestAPIOne
//
//  Created by MacBook on 22.10.2021.
//

import Foundation

class MovieViewModel {
   
    private var apiService = ApiService()
    private var popularMovies = [Movie]()
    
    func fetchPopularMoviesData(completion: @escaping () -> ()) {
        
        apiService.getPopularMoviesData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
            self?.popularMovies = listOf.movies
            completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRowsInSection(indexPath: IndexPath) -> Int {
        return popularMovies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Movie {
        
        return popularMovies[indexPath.row]
    }
    
    
}





