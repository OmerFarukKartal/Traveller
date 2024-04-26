import UIKit
import Kingfisher

class FlightTableViewCell: UITableViewCell {
    
    let departureCityLabel = UILabel()
    let landingCityLabel = UILabel()
    let durationTimeLabel = UILabel()
    let priceLabel = UILabel()
    let logoImageView = UIImageView()
    let airlaneNameLabel = UILabel()
    
    let durationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "timer"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLabels()
        setupFlightImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupLabels() {
        // StackView'i oluşturma ve ayarlama işlemleri
        
        departureCityLabel.textColor = .black // veya istediğiniz renk
        departureCityLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        landingCityLabel.textColor = .black // veya istediğiniz renk
        landingCityLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.spacing = 30
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .center
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.bounds.width * 0.05),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        let stackViewLeft = UIStackView()
        stackViewLeft.axis = .vertical
        stackViewLeft.spacing = 15
        stackViewLeft.distribution = .equalSpacing
        stackViewLeft.alignment = .center
        stackViewLeft.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(stackViewLeft)
        
        
        let cityStackView = UIStackView()
        cityStackView.axis = .vertical
        cityStackView.spacing = 10
        cityStackView.distribution = .fillEqually
        cityStackView.alignment = .center
        cityStackView.translatesAutoresizingMaskIntoConstraints = false
        stackViewLeft.addArrangedSubview(cityStackView)
        
        
        cityStackView.addArrangedSubview(departureCityLabel)
        cityStackView.addArrangedSubview(landingCityLabel)
        
        let stackViewCenter = UIStackView()
        stackViewCenter.axis = .horizontal
        stackViewCenter.spacing = 0
        stackViewCenter.distribution = .fillEqually
        stackViewCenter.alignment = .center
        stackViewCenter.translatesAutoresizingMaskIntoConstraints = false
        stackViewCenter.addArrangedSubview(durationImageView)
        stackViewCenter.addArrangedSubview(durationTimeLabel)
        
        mainStackView.addArrangedSubview(stackViewCenter)
        
        let stackViewRight = UIStackView()
        stackViewRight.axis = .vertical
        stackViewRight.distribution = .fillEqually
        stackViewRight.alignment = .center
        stackViewRight.translatesAutoresizingMaskIntoConstraints = false
        stackViewRight.addArrangedSubview(airlaneNameLabel)
        stackViewRight.addArrangedSubview(logoImageView)
        
        mainStackView.addArrangedSubview(stackViewRight)
        
    }
    
    func setupdurationImage() {
        durationImageView.frame = CGRect(x: 150, y: 5, width: 30, height: 30)
        durationImageView.contentMode = .scaleAspectFit
    }

    
    func setupFlightImage() {
        logoImageView.frame = CGRect(x: 150, y: 5, width: 30, height: 30)
        logoImageView.image = UIImage(systemName: "airplane")
        logoImageView.contentMode = .scaleAspectFit
    }
    
    func setImage(_ url: String?) {
        guard let urlStr = url else {
            self.logoImageView.image = UIImage(named: "notFound")
            return
        }
        
        if url == "notFound" {
            self.logoImageView.image = UIImage(named: "notFound")
        } else {
            let logoImage = URL(string: urlStr)
            self.logoImageView.kf.setImage(with: logoImage)
        }
    }
}
