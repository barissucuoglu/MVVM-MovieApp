//
//  TitleLabel.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 28.12.2023.
//

import UIKit

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        minimumScaleFactor = 0.9
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
