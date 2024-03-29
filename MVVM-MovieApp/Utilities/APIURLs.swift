//
//  APIURLs.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 25.12.2023.
//

import Foundation

enum APIURLs {
    
    static func movies(page: Int) -> String {
    "https://api.themoviedb.org/3/movie/popular?api_key=4409523e2d82ac980519cd19219a6567&language=en-US&page=\(page)"
    }
 
    
    static func imageURL(posterPath: String) -> String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
    
    
    static func detail(id: Int) -> String{
        "https://api.themoviedb.org/3/movie/\(id)?api_key=4409523e2d82ac980519cd19219a6567&language=en-US"
    }
}
