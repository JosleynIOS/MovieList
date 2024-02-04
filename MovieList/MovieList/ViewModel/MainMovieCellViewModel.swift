//
//  MainMovieCellViewModel.swift
//  MovieList
//
//  Created by Josleyn Santos on 2/5/24.
//

import Foundation

class MainMovieCellViewModel {
    
    var movieTitle: String
    var movieDescription: String
    var shouldShowDescription: Bool
    
    init(movie: Movie) {
        self.movieTitle = movie.title ?? ""
        self.movieDescription = movie.description ?? ""
        self.shouldShowDescription = movie.shouldShowDescription ?? false
    }
}
