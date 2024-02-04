//
//  Observable.swift
//  MovieList
//
//  Created by Josleyn Santos on 2/2/24.
//

import Foundation

class Observable<T> {
    
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    private var listener: ((T?) -> Void)?
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
