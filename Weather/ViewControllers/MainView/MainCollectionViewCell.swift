//
//  MainCollectionViewCell.swift
//  Weather
//
//  Created by Артур Кононович on 30.07.21.
//

import UIKit
import RxSwift
import RxCocoa

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var weatherTableView: UITableView!
    
    let model = MainCollectionViewCellModel()
    let disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.weatherCollectionView.delegate = nil
        self.weatherTableView.delegate = nil
        self.weatherCollectionView.dataSource = nil
        self.weatherTableView.dataSource = nil
    }
    
    func configure(with object: Location) {
        self.cityNameLabel.text = object.title
        
        self.model.description
            .bind(to: self.weatherDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.model.temp
            .bind(to: self.tempLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.model.image
            .bind(to: self.weatherImageView.rx.image)
            .disposed(by: disposeBag)
        
        self.model.humidity
            .bind(to: self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.model.wind
            .bind(to: self.windLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.model.hourly
            .bind(to: weatherCollectionView.rx.items(cellIdentifier: "CollectionViewCell", cellType: CollectionViewCell.self)) { (row, element, cell) in
            cell.configure(with: element)
        }.disposed(by: disposeBag)
        
        self.weatherCollectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        self.model.daily
            .bind(to: weatherTableView.rx.items(cellIdentifier: "TableViewCell", cellType: TableViewCell.self)) { (row, element, cell) in
            cell.configure(with: element)
        }.disposed(by: disposeBag)
        
        self.model.loadWeatherForecast(location: object)
    }
    
}

extension MainCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = collectionView.frame.width / 5
        return CGSize(width: side, height: collectionView.bounds.height)
    }
}
