import UIKit

class HotelListTableViewCell: UITableViewCell {
    
    let hotelImageView = UIImageView()
    let hotelNameLabel = UILabel()
    let locationLabel = UILabel()
    let priceLabel = UILabel()
    let descriptionLabel = UILabel()
    let ratingBar = RatingBar()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        hotelImageView.translatesAutoresizingMaskIntoConstraints = false
        hotelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingBar.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(hotelImageView)
        contentView.addSubview(hotelNameLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(ratingBar)
        
        hotelImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 10, paddingLeft: 10, width: 80, height: 80)
        hotelNameLabel.anchor(top: contentView.topAnchor, left: hotelImageView.rightAnchor, paddingTop: 10, paddingLeft: 10)
        locationLabel.anchor(top: hotelNameLabel.bottomAnchor, left: hotelImageView.rightAnchor, paddingTop: 5, paddingLeft: 10)
        priceLabel.anchor(top: locationLabel.bottomAnchor, left: hotelImageView.rightAnchor, paddingTop: 5, paddingLeft: 10)
        descriptionLabel.anchor(top: priceLabel.bottomAnchor, left: hotelImageView.rightAnchor, paddingTop: 5, paddingLeft: 10)
        ratingBar.anchor(top: descriptionLabel.bottomAnchor, left: hotelImageView.rightAnchor, bottom: contentView.bottomAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10)
    }
    
    func setImage(_ url: String?) {
        guard let url = url, let imageUrl = URL(string: url) else {
            hotelImageView.image = UIImage(named: "placeholder")
            return
        }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.hotelImageView.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    self.hotelImageView.image = UIImage(named: "placeholder")
                }
            }
        }.resume()
    }
    
}
