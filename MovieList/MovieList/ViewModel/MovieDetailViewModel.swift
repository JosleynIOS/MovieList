//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Josleyn Santos on 2/5/24.
//

import Foundation

class MovieDetailsViewModel {
    
    var movie: Movie
    
    var movieTitle: String
    var movieDescription: String
    var movieImageURL: URL?
    
    init(movie: Movie) {
        self.movie = movie
        self.movieTitle = movie.title ?? ""
        self.movieDescription = movie.description ?? ""
        self.movieImageURL = fixSchemeFromURL(movie.imageURL ?? "")
    }
    
    func fixSchemeFromURL(_ urlString: String) -> URL? {
        guard let url = URL(string: urlString), let host = url.host else {
            return nil
        }

        let path = url.path.isEmpty ? "" : "/" + url.path
        let trimmedURLString = host + path
        let validURLString = "https://" + trimmedURLString
        
        return URL(string: validURLString)
    }
}
