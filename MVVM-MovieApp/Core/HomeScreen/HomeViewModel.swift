//
//  HomeViewModel.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 25.12.2023.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeScreenInterface? { get set }
    
    func viewDidLoad()
    func getMovies()
}

final class HomeViewModel {
    weak var view: HomeScreenInterface?
    private let service = MovieService()
    var movies: [MovieResult] = []
    var page: Int = 1
}


extension HomeViewModel: HomeViewModelInterface {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
        getMovies()
    }
    
    
    func getMovies() {
        view?.showLoadingView()
        service.downloadMovies(page: page) { [weak self] movies in
            guard let self = self else { return }
            self.view?.dismissLoadingView()
            
            guard let movies = movies else { return }
            self.movies.append(contentsOf: movies)
            self.view?.reloadCollectionView()
        }
    }
    
    
    func getMovieDetail(id: Int) {
        service.downloadDetail(id: id) { [weak self] movie in
            guard let self = self else { return }
            guard let movie = movie else { return }
            self.view?.navigateToDetailVC(movie: movie)
        }
    }
}
