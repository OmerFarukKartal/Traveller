//
//  BlogTableViewCell.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 3.06.2024.
//

import UIKit

class BlogTableViewCell: UITableViewCell {

    var containerView = UIView()
    var blogImageView = UIImageView()
    var countryLabel = UILabel()
    var desrciptionLabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()

    }
    
    func setupUI() {
        contentView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 8
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(containerView)
        containerView.anchor(top: contentView.topAnchor,left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        blogImageView.translatesAutoresizingMaskIntoConstraints = false
        blogImageView.layer.cornerRadius = 8
        blogImageView.layer.masksToBounds = true
        containerView.addSubview(blogImageView)
        
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.numberOfLines = 0
        countryLabel.lineBreakMode = .byWordWrapping // Ek olarak, lineBreakMode'u ayarladım.
        containerView.addSubview(countryLabel)
        
        desrciptionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(desrciptionLabel)
        
        blogImageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingRight: 10, width: 180, height: 170)
        
        countryLabel.anchor(top: blogImageView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10)
        desrciptionLabel.anchor(top: countryLabel.bottomAnchor, left: containerView.leftAnchor, paddingTop: 5, paddingLeft: 5)
    }
    func setImage(_ url: String?) {
        guard let url = url, let imageUrl = URL(string: url) else {
            blogImageView.image = UIImage(named: "placeholder")
            return
        }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.blogImageView.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    self.blogImageView.image = UIImage(named: "placeholder")
                }
            }
        }.resume()
    }

}
