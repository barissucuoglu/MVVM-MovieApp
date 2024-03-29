//
//  Movie.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 25.12.2023.
//

import Foundation

struct Movie: Codable {
    let page: Int?
    let results: [MovieResult]
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieResult: Codable {
    let id: Int?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let title: String?
    let tagline: String?
    let genres: [Genre]?
    
    struct Genre: Codable {
        let name: String?
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case title
        case tagline
        case genres
    }
    
    var _id: Int {
        id ?? Int.min
    }
    
    var _posterPath: String {
        posterPath ?? ""
    }
    
    var _title: String {
        title ?? "N/A"
    }
    
    var _tagline: String {
        tagline ?? ""
    }
    
    var _releaseDate: String {
        releaseDate ?? "N/A"
    }
    
    var _overview: String {
        overview ?? "There is no overview."
    }
}
