//
//  Movie.swift
//  MovieList
//
//  Created by Josleyn Santos on 2/1/24.
//

import Foundation

struct MovieResponse: Codable {
    var movieData: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movieData = "data"
    }
}

struct Movie: Codable {
    var title: String?
    var description: String?
    var imageURL: String?
    var shouldShowDescription: Bool?
    private var isShowingDescription: Bool?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageURL = "image"
        case shouldShowDescription = "shouldShowDescription"
        case isShowingDescription = "isShowingDescription"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        print("titleError")
        description = try container.decode(String.self, forKey: .description)
        print("descriptionError")
        imageURL = try container.decode(String.self, forKey: .imageURL)
        print("imageError")
        
        
        
        if let boolString: String = try? (container.decodeIfPresent(String.self, forKey: .shouldShowDescription) ?? "") {
            self.shouldShowDescription = (boolString as NSString).boolValue
            print("boolStringError")
        } else if let boolInt: Int = try? (container.decodeIfPresent(Int.self, forKey: .shouldShowDescription) ?? 0) {
            self.shouldShowDescription = Bool(truncating: boolInt as NSNumber)
            print("boolIntError")
        } else {
            shouldShowDescription = try container.decode(Bool.self, forKey: .shouldShowDescription)
            print("boolError")
        }
        
        
        isShowingDescription = try container.decodeIfPresent(Bool.self, forKey: .isShowingDescription)
        if isShowingDescription ?? false {
            shouldShowDescription = true
        }
    }
}
