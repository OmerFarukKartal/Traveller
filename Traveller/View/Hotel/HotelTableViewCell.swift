import UIKit
import Kingfisher

class HotelTableViewCell: UITableViewCell {

    let hotelNameLabel = UILabel()
    let locationLabel = UILabel()
    let priceLabel = UILabel()
    var hotelImageView = UIImageView()
    var ratingBar = RatingBar()
    var rateLabel = UILabel()
    let imageStackView = UIStackView()
    let systemImage1 = UIImageView(image: UIImage(systemName: "21.circle"))
    let systemImage2 = UIImageView(image: UIImage(systemName: "fork.knife.circle"))
    let systemImage3 = UIImageView(image: UIImage(systemName: "wifi"))
    let systemImage4 = UIImageView(image: UIImage(systemName: "parkingsign.circle"))

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
        
        contentView.addSubview(hotelImageView)
        hotelImageView.translatesAutoresizingMaskIntoConstraints = false
        hotelImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 0, paddingLeft: 3, width: 80, height: 80)
        
        contentView.addSubview(hotelNameLabel)
        hotelNameLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 1, paddingLeft: 100)
        
        contentView.addSubview(locationLabel)
        locationLabel.anchor(top: hotelNameLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 5, paddingLeft: 100)
        
        contentView.addSubview(ratingBar)
        ratingBar.anchor(top: locationLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 5, paddingLeft: 100, width: 100, height: 20)
        
        stackView.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingRight: 10)
        
        contentView.addSubview(priceLabel)
        priceLabel.anchor(bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingBottom: 5, paddingRight: 2)
        
        
    }
    
    func setImage(_ url: String?) {
        guard let urlStr = url else {
            self.hotelImageView.image = UIImage(named: "notFound")
            return
        }
        
        if url == "notFound" {
            self.hotelImageView.image = UIImage(named: "notFound")
        } else {
            let hotelImageView = URL(string: urlStr)
            self.hotelImageView.kf.setImage(with: hotelImageView)
        }
    }
    
    func setRate(_ rate: Double) {
          rateLabel.text = String(format: "%.1f", rate)
      }
}
