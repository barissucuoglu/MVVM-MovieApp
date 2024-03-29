//
//  MovieDetailsVC.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 28.12.2023.
//

import UIKit

protocol MovieDetailsVCInterface: AnyObject {
    func configureVC()
    func configureMovieImageView()
    func configureTitleLabel()
    func configureTaglineLabel()
    func configureDateLabel()
    func configureOverviewLabel()
    func showLoadingView()
    func dismissLoadingView()
    func alertOnMainThread(title: String, message: String, buttonTitle: String)
}

final class MovieDetailsVC: DataLoadingVC {
    
    private let viewModel = MovieDetailViewModel()
    private var movie: MovieResult
    
    let padding: CGFloat = 16
    
    let movieImageView = MovieImageView(frame: .zero)
    let movieTitleLabel = TitleLabel(textAlignment: .left,fontSize: 22)
    let dateLabel = SecondaryTitleLabel(fontSize: 14)
    let taglineLabel = TitleLabel(textAlignment: .center, fontSize: 18)
    let overviewLabel = BodyLabel(textAlignment: .justified)
    
    
    init(movie: MovieResult) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidload()
    }
}


extension MovieDetailsVC: MovieDetailsVCInterface {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    @objc func addButtonTapped() {
        viewModel.getMovieDetail(movie: movie)
    }
    
    
    func alertOnMainThread(title: String, message: String, buttonTitle: String) {
        presentAlertOnMainThread(title: title, message: message, buttonTitle: buttonTitle)
    }
    
    
    func configureMovieImageView() {
        view.addSubview(movieImageView)
        
        movieImageView.downloadImage(movie: movie)
        
        let imageWidth: CGFloat = .deviceWidth * 0.4
        let imageHeight: CGFloat = imageWidth * 1.5
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            movieImageView.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
    }
    
    
    func configureTitleLabel() {
        view.addSubview(movieTitleLabel)
        movieTitleLabel.text = movie._title
        
        
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }
    
    
    func configureDateLabel() {
        view.addSubview(dateLabel)
        
        dateLabel.text = movie._releaseDate
        dateLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: movieTitleLabel.trailingAnchor)
        ])
    }
    
    
    func configureTaglineLabel() {
        view.addSubview(taglineLabel)
        taglineLabel.text = movie._tagline.uppercased()
         
         NSLayoutConstraint.activate([
             taglineLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 2 * padding),
             taglineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
             taglineLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
         ])
    }
    
    
    func configureOverviewLabel() {
        view.addSubview(overviewLabel)
        overviewLabel.text = movie._overview
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 2 * padding),
            overviewLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: movieTitleLabel.trailingAnchor)
        ])
    }
}
