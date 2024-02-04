//
//  NetworkConstants.swift
//  MovieList
//
//  Created by Josleyn Santos on 2/2/24.
//

import Foundation

class NetworkConstant {
    public static var shared: NetworkConstant = NetworkConstant()
    
    private init() {
        
    }
    
    public var serverAddress: String {
        get {
            return "https://trackerteer.com/exam/exam.php"
        }
    }
}
