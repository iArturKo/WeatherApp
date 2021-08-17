//
//  LocationsViewController.swift
//  Weather
//
//  Created by Артур Кононович on 12.08.21.
//

import UIKit
import RxSwift
import RxCocoa

class LocationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.label.text = "Locations".localized
        
        LocationManager.shared.locations
            .bind(to: tableView.rx.items(cellIdentifier: "LocationCell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.title
        }.disposed(by: disposeBag)
        
        tableView
            .rx
            .itemDeleted
            .bind { IndexPath in
                LocationManager.shared.removeLocation(indexPath: IndexPath)
            }
            .disposed(by: disposeBag)
    }

}
