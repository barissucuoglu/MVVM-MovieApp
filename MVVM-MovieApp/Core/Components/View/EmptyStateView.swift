//
//  EmptyStateView.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 31.12.2023.
//

import UIKit

class EmptyStateView: UIView {

    let messageTitle = TitleLabel(textAlignment: .center, fontSize: 24)
    let logoImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(text: String) {
        self.init(frame: .zero)
        messageTitle.text = text
    }
    
    
    private func configure() {
        addSubviews(messageTitle, logoImageView)
        configureMessageTitLe()
        configureLogoImageView()
    }
    
    
    private func configureMessageTitLe() {
        messageTitle.numberOfLines = 3
        messageTitle.textColor = .secondaryLabel
        
        let padding: CGFloat = 40
        
        NSLayoutConstraint.activate([
            messageTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            messageTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            messageTitle.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureLogoImageView() {
        logoImageView.image = UIImage(systemName: "popcorn")
        logoImageView.tintColor = .secondaryLabel
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 100),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ])
    }
}
