//
//  HotelTableViewCell.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 11.05.2024.
//

import UIKit

class HotelTableViewCell: UITableViewCell {

    let hotelNameLabel = UILabel()
    let locationLabel = UILabel()
    let priceLabel = UILabel()
    let descriptionLabel = UILabel()
    
    var hotelImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
