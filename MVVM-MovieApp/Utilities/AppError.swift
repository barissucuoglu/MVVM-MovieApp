//
//  AppError.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 29.12.2023.
//

import Foundation

enum AppError: String, Error {
    
    case unableToComplete        	= "Unable to complete your request. Please check your internet connection."
    case invalidResponse         	= "Invalid response from the server. Please try again."
    case invalidData         		= "The data received from the server was invalid. Please try again."
    case unableToFavorite        	= "There was an error favoriting this movie. Please try again."
    case aldreadyInFavorites     	= "You've already favorited this movie. You must REALLY like them!"
}
