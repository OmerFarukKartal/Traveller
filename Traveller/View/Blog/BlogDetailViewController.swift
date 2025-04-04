//
//  BlogDetailViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 9.06.2024.
//

import UIKit
import Kingfisher

class BlogDetailViewController: UIViewController {
    var blogId: Int?
    var countryImageView = UIImageView()
    var descriptionLabel = UILabel()
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    var ViewModel = BlogViewModel()
    var imageUrl: String = ""
    var imageContainerView = UIView()
    let scrollView = UIScrollView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchBlogDetails()

    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        let titleStackView = UIStackView()
        titleStackView.backgroundColor = .red
        titleStackView.axis = .vertical
        titleStackView.distribution = .fill
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleStackView)
        
        titleStackView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.15)
        
        let titleLabel = UILabel()
        titleLabel.text = "TRAVELLER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        titleLabel.textAlignment = .center
        titleStackView.addSubview(titleLabel)
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        let rateStackView = UIStackView()
        rateStackView.axis = .horizontal
        rateStackView.spacing = 30
        rateStackView.backgroundColor = UIColor.systemGreen
        rateStackView.layer.cornerRadius = 2
        rateStackView.distribution = .equalCentering
        rateStackView.alignment = .center
        rateStackView.translatesAutoresizingMaskIntoConstraints = false
        rateStackView.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        rateStackView.isLayoutMarginsRelativeArrangement = true
        
        
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.backgroundColor = .white
        imageContainerView.layer.cornerRadius = 10
        imageContainerView.layer.shadowColor = UIColor.black.cgColor
        imageContainerView.layer.shadowOpacity = 0.8
        imageContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageContainerView.layer.shadowRadius = 4
        imageContainerView.layer.masksToBounds = false
        view.addSubview(imageContainerView)
        imageContainerView.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenHeight * 0.02, paddingRight: screenHeight * 0.02, height: screenHeight * 0.3)
        
        countryImageView.translatesAutoresizingMaskIntoConstraints = false
        countryImageView.contentMode = .scaleAspectFill
        countryImageView.clipsToBounds = true
        countryImageView.image = UIImage(named: "placeholderImage")
        imageContainerView.addSubview(countryImageView)
        countryImageView.anchor(top: imageContainerView.topAnchor, left: imageContainerView.leftAnchor, bottom: imageContainerView.bottomAnchor, right: imageContainerView.rightAnchor)
        
        view.addSubview(scrollView)
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.anchor(top: imageContainerView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)

            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.numberOfLines = 0
            descriptionLabel.lineBreakMode = .byWordWrapping
            scrollView.addSubview(descriptionLabel)
            descriptionLabel.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: screenHeight * 0.05, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.05)

            // ScrollView ve descriptionLabel arasında genişlik ve yükseklik constraint'leri eklemeyi deneyelim.
            NSLayoutConstraint.activate([
                descriptionLabel.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -screenWidth * 0.1), // ScrollView'ın içinde tam olarak sığması için genişlik constraint'i ekleyelim.
                descriptionLabel.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, constant: screenHeight * 0.1) // ScrollView'a göre minimum yükseklik constraint'i ekleyelim.
            ])
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: descriptionLabel.frame.maxY)
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
        }
    
    func fetchBlogDetails() {
        guard let id = blogId else { return }
        ViewModel.getSelectedBlog(blogId: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let blog):
                    self.updateUI(with: blog)
                case .failure(let error):
                    print("Error fetching flight details: \(error.localizedDescription)")
                }
            }
        }
    }
    func setImage(_ url: String?, size: CGSize? = nil) {
        guard let urlStr = url else {
            self.countryImageView.image = UIImage(named: "notFound")
            return
        }
        if url == "notFound" {
            self.countryImageView.image = UIImage(named: "notFound")
        } else {
            let countryImage = URL(string: urlStr)
            var options: KingfisherOptionsInfo = [.transition(.fade(0.2))]
            
            if let size = size {
                let processor = ResizingImageProcessor(referenceSize: size, mode: .aspectFill)
                options.append(.processor(processor))
            }
            
            self.countryImageView.kf.setImage(with: countryImage, placeholder: UIImage(named: "notFound"), options: options)
        }
    }
    
    func updateUI(with blog: BlogList){
        if let imageUrl = blog.image {
            setImage(imageUrl, size: CGSize(width: screenWidth, height: screenHeight * 0.3))
            self.imageUrl = imageUrl
            
        } else {
            self.countryImageView.image = UIImage(named: "notFound")
        }
        descriptionLabel.text = blog.desc
        
    }


}
