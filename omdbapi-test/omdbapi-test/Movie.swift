//
//  Movie.swift
//  omdbapi-test
//
//  Created by Joel Sene on 06/04/17.
//  Copyright © 2017 Rafael Meyer. All rights reserved.
//

import Foundation

class Movie {
    
    let name:String
    let type:String
    let year:String
    let poster:String
    
    init(name:String, type:String, year:String, poster:String) {
        self.name = name
        self.type = type
        self.year = year
        self.poster = poster
    }
    
}
