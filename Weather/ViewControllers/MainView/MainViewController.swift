//
//  ViewController.swift
//  Weather
//
//  Created by Артур Кононович on 8.06.21.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.shared.locations.bind(to: mainCollectionView.rx.items(cellIdentifier: "MainCollectionViewCell", cellType: MainCollectionViewCell.self)) { (row, element, cell) in
            cell.configure(with: element)
        }.disposed(by: disposeBag)
        
        self.mainCollectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        LocationManager.shared.locations
            .asObservable()
            .distinctUntilChanged{ $0.count == $1.count}
            .subscribe { locations in
                self.pageControl.numberOfPages = locations.element?.count ?? 1
            }.disposed(by: disposeBag)
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "CitySearchViewController") as? CitySearchViewController else {
            return
        }
        self.present(controller, animated: true, completion: nil)
    }

    @IBAction func locationsButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "LocationsViewController") as? LocationsViewController else {
            return
        }
        self.present(controller, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / scrollView.bounds.width
        pageControl.currentPage = Int(scrollPos)
    }

}

