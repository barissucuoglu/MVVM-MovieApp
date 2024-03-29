//
//  FavoriteViewModel.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 29.12.2023.
//

import Foundation

protocol FavoriteViewModelInterface {
    var view: FavoritesListVCInterface? { get set }
    
    func viewDidLoad()
    func getFavorites()
    func removeFavorite(favorite: MovieResult)
    func checkEmpty(favorites: [MovieResult])
}

class FavoriteViewModel {
    weak var view: FavoritesListVCInterface?
    let movieService = MovieService()
    var favorites: [MovieResult] = []
}


extension FavoriteViewModel: FavoriteViewModelInterface {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureTableView()
    }
    
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
            
                DispatchQueue.main.async {
                    self.checkEmpty(favorites: favorites)
                    self.favorites = favorites
                    self.view?.reloadTableView()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func removeFavorite(favorite: MovieResult) {
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
            checkEmpty(favorites: favorites)
                return
            }
            
            self.view?.alertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
    func checkEmpty(favorites: [MovieResult]) {
        if favorites.isEmpty {
            let message = "There is no favorite movie. You should consider add some."
            DispatchQueue.main.async { self.view?.showEmptyStateView(with: message) }
            return
        }
    }
}
