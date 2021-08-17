//
//  CollectionViewCell.swift
//  Weather
//
//  Created by Артур Кононович on 8.06.21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    static let identifier = "CollectionViewCell"
    
    func configure(with object: HourlyWeather) {
        self.timeLabel.text = object.time
        self.imageView.image = UIImage(named: object.iconName)
        self.tempLabel.text = "\(object.temp)°"
    }
}
