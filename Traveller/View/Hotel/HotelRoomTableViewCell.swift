import UIKit

class HotelRoomTableViewCell: UITableViewCell {
    
    var containerView = UIView()
    var hotelRoomImage = UIImageView()
    var priceLabel = UILabel()
    var roomTypeLabel = UILabel()

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
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor.lightGray.cgColor // Çerçeve rengi
        contentView.addSubview(containerView)
        
        containerView.anchor(top: contentView.topAnchor,left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        hotelRoomImage.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(hotelRoomImage)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(priceLabel)
        
        roomTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(roomTypeLabel)
        
        hotelRoomImage.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, paddingTop: 10, paddingLeft: 10, width: 180, height: 130)
        
        roomTypeLabel.anchor(top: containerView.topAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingRight: 10)
        
        priceLabel.anchor(bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingBottom: 10, paddingRight: 10)
    }
    
    func setImage(_ url: String?) {
        guard let url = url, let imageUrl = URL(string: url) else {
            hotelRoomImage.image = UIImage(named: "placeholder")
            return
        }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.hotelRoomImage.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    self.hotelRoomImage.image = UIImage(named: "placeholder")
                }
            }
        }.resume()
    }
}
