//
//  Model.swift
//  RestAPIOne
//
//  Created by MacBook on 22.10.2021.
//

import Foundation

struct MoviesData: Codable {
    
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Codable {
    
    let title: String?
    let rate: Double?
    let year: String?
    let posterImage: String?
    let overView: String?
    
    enum CodingKeys: String, CodingKey {
        case title, overView
        case rate = "vote_average"
        case year = "release_date"
        case posterImage = "poster_path"
    }
}


