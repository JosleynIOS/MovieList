//
//  MainViewModel.swift
//  MovieList
//
//  Created by Josleyn Santos on 2/2/24.
//

import Foundation

class MainViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[Movie]> = Observable([])
    var movies: [Movie] = []
    
    func numberOfRows() -> Int {
        return movies.count
    }
    
    func getMovies() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        
        APICaller.getMovies { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.mapCellData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.movies
        print(movies)
    }
    
    func getCellViewModel(row: Int) -> MainMovieCellViewModel {
        let movie = movies[row]
        return MainMovieCellViewModel(movie: movie)
    }
    
    func getDetailsViewModel(row: Int) -> MovieDetailsViewModel {
        let movie = movies[row]
        return MovieDetailsViewModel(movie: movie)
    }
}
