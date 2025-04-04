//
//  RaitingBar.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 13.05.2024.
//

import UIKit

class RatingBar: UIView {
    private let emptyStar = "☆"
    private let filledStar = "★"
    private let filledStarColor = UIColor.systemGreen
    
    private var stackView: UIStackView!
    
    var rating: Int = 0 {
        didSet {
            updateRating()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        updateRating()
    }
    
    private func updateRating() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for _ in 0..<rating {
            let label = UILabel()
            label.text = filledStar
            label.textColor = filledStarColor
            stackView.addArrangedSubview(label)
        }
        
        for _ in rating..<5 {
            let label = UILabel()
            label.text = emptyStar
            stackView.addArrangedSubview(label)
        }
    }
}
