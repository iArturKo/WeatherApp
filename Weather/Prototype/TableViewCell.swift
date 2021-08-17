//
//  TableViewCell.swift
//  Weather
//
//  Created by Артур Кононович on 8.06.21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    
    static let identifier = "TableViewCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.dayLabel.text = nil
        self.imageView?.image = nil
        self.tempMaxLabel.text = nil
        self.tempMinLabel.text = nil
    }
    
    func configure(with object: DailyWeather) {
        self.dayLabel.text = object.day.localized
        self.iconImageView?.image = UIImage(named: object.iconName)
        self.tempMaxLabel.text = "\(object.tempMax)"
        self.tempMinLabel.text = "\(object.tempMin)"
    }
    
}
