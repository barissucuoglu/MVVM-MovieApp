//
//  FavoritesListVC.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 29.12.2023.
//

import UIKit

protocol FavoritesListVCInterface: AnyObject{
    func configureVC()
    func configureTableView()
    func reloadTableView()
    func alertOnMainThread(title: String, message: String, buttonTitle: String)
    func showEmptyStateView(with message: String)
}

class FavoritesListVC: DataLoadingVC {
    
    private let viewModel = FavoriteViewModel()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavorites()
    }
}


extension FavoritesListVC: FavoritesListVCInterface {
    
    func configureVC() {
        view.backgroundColor = .systemRed
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    func reloadTableView() {
        tableView.reloadData()
        view.bringSubviewToFront(tableView)
    }
    
    func alertOnMainThread(title: String, message: String, buttonTitle: String) {
        presentAlertOnMainThread(title: title, message: message, buttonTitle: buttonTitle)
    }
}


extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        let favorite = viewModel.favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = viewModel.favorites[indexPath.row]
        let destVC = MovieDetailsVC(movie: favorite)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = viewModel.favorites[indexPath.row]
        viewModel.favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        viewModel.removeFavorite(favorite: favorite)
    }
}
