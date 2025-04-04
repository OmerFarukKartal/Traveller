import UIKit
import Kingfisher

class TourTableViewCell: UITableViewCell {
    
    var tourNameLabel = UILabel()
    var tourTypeLabel = UILabel()
    var locationLabel = UILabel()
    var tourImageView = UIImageView()
    var priceLabel = UILabel()
    var ratingBar = RatingBar()
    var kullaniciDegerlendirmeLabel = UILabel()
    var rateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.backgroundColor = UIColor.systemGreen
        stackView.layer.cornerRadius = 2
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(rateLabel)
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        stackView.isLayoutMarginsRelativeArrangement = true
        contentView.addSubview(stackView)
        rateLabel.textColor = .white

        tourImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tourImageView)
        tourImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 0, paddingLeft: 3, width: 80, height: 80)

        tourNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tourNameLabel)
        tourNameLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 1, paddingLeft: 100)

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationLabel)
        locationLabel.anchor(top: tourNameLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 5, paddingLeft: 100)
        
        tourTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tourTypeLabel)
        tourTypeLabel.anchor(top: locationLabel.bottomAnchor, left: tourImageView.rightAnchor, paddingTop: 5, paddingLeft: 20, width: 100, height: 20)

        ratingBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ratingBar)
        ratingBar.anchor(left: tourImageView.rightAnchor, bottom: contentView.bottomAnchor, paddingLeft: 10, paddingBottom: 5, width: 100, height: 20)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingRight: 10)

        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
        priceLabel.anchor(bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingBottom: 5, paddingRight: 2)
    }

    func setImage(_ url: String?) {
        guard let urlStr = url else {
            self.tourImageView.image = UIImage(named: "notFound")
            return
        }

        if url == "notFound" {
            self.tourImageView.image = UIImage(named: "notFound")
        } else {
            let tourImage = URL(string: urlStr)
            self.tourImageView.kf.setImage(with: tourImage)
        }
    }

    func setRate(_ rate: Double) {
        rateLabel.text = String(format: "%.1f", rate)
    }
}
