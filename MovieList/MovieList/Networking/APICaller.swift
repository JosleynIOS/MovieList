//
//  APICaller.swift
//  MovieList
//
//  Created by Josleyn Santos on 2/2/24.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {
    
    static func getMovies(completionHandler: @escaping (_ result: Result<[Movie], NetworkError>) -> Void) {
        
        let urlString = NetworkConstant.shared.serverAddress
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            
            if error == nil,
               let data = dataResponse {
                
                let jsonString = String(data: data, encoding: .utf8)?.replacingOccurrences(of: ": “", with: ": \"")
                    .replacingOccurrences(of: "”,", with: "\",")
                    .replacingOccurrences(of: "“description”", with: "\"description\"")
                
                if let jsonData = jsonString?.data(using: .utf8),
                   let resultData = try? JSONDecoder().decode(MovieResponse.self, from: jsonData) {
                    
                    completionHandler(.success(resultData.movieData))
                } else {
                    
                    completionHandler(.failure(.canNotParseData))
                }
                completionHandler(.failure(.canNotParseData))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
            
            
            
        }.resume()
    }
}
