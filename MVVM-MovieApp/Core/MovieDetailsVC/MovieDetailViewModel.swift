//
//  MovieDetailViewModel.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 28.12.2023.
//

import Foundation

protocol MovieDetailsViewModelInterface {
    var view: MovieDetailsVCInterface? { get set }
    
    func viewDidload()
    func getMovieDetail(movie: MovieResult)
    func addMovie(favorite: MovieResult)
}


final class MovieDetailViewModel {
    weak var view: MovieDetailsVCInterface?
    let movieService = MovieService()
}


extension MovieDetailViewModel: MovieDetailsViewModelInterface {
    
    func viewDidload() {
        view?.configureVC()
        view?.configureMovieImageView()
        view?.configureTitleLabel()
        view?.configureDateLabel()
        view?.configureTaglineLabel()
        view?.configureOverviewLabel()
    }
    
    
    func getMovieDetail(movie: MovieResult) {
        view?.showLoadingView()
        movieService.downloadDetail(id: movie._id) { [weak self] movie in
            guard let self = self else { return }
            self.view?.dismissLoadingView()
            guard let movie = movie else { return }
            addMovie(favorite: movie)
        }
    }
    
    
    func addMovie(favorite: MovieResult) {
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.view?.alertOnMainThread(title: "Succes", message: "You have succesfully favorited this movie 🎉", buttonTitle: "Ok")
                return
            }
            self.view?.alertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
