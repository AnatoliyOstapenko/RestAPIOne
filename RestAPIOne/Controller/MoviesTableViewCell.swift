//
//  MoviesTableViewCell.swift
//  RestAPIOne
//
//  Created by MacBook on 23.10.2021.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieReview: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    
    private var urlString: String = ""
    
    // Set up movies values (next step after Update UI, Get Image, Convert methodes created)
    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
        
    }
    
    // Update UI Views
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?) {
        
        movieTitle.text = title
        movieYear.text = convertDateFormatter(releaseDate)
        movieReview.text = overview
        
        guard let rate = rating else { return }
        movieRate.text = String(rate)
        
        guard let posterString = poster else { return }
        urlString = "https://image.tmdb.org/t/p/w300/" + posterString
        
        guard let urlPosterImage = URL(string: urlString) else { return }
        
        //Before download a new image, clear out the old one
        movieImage.image = nil
        
        getImageDataFrom(url: urlPosterImage)
    }
    // MARK: - Get Image Data
    
    private func getImageDataFrom(url: URL) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else { return }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.movieImage.image = image
                }
            }
        }.resume()
    }
    
    // MARK: - Convert Date Format
    
    func convertDateFormatter(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = date else { return "date unrwraping false" }
        
        if let newDate = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "dd.MM.yyyy"
            fixDate = dateFormatter.string(from: newDate)        }
        return fixDate
    }


    
}
