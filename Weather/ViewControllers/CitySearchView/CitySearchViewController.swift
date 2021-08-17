//
//  CitySearchViewController.swift
//  Weather
//
//  Created by Артур Кононович on 8.06.21.
//

import UIKit
import RxSwift
import RxCocoa

class CitySearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    let disposeBag = DisposeBag()
    let citySearchViewModel = CitySearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.citySearchViewModel.setup()
        self.configureSearchBar()
        self.configureSearchResultsTableView()
    }
    
    func configureSearchBar() {
        self.searchBar.becomeFirstResponder()
        self.searchBar.prompt = "Location search".localized
        
        self.searchBar
            .rx
            .text
            .orEmpty
            .subscribe { [weak self] text in
                self?.citySearchViewModel.addQuery(query: text)
            }.disposed(by: disposeBag)
        
        self.searchBar
            .rx
            .cancelButtonClicked
            .subscribe { [weak self] event in
                self?.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
    
    func configureSearchResultsTableView() {
        self.citySearchViewModel.searchResults.bind(to: searchResultsTableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
            cell.textLabel?.text = element.title
            cell.detailTextLabel?.text = element.subtitle
        }.disposed(by: disposeBag)
        
        self.searchResultsTableView
            .rx
            .itemSelected
            .subscribe { [weak self] indexPath in
                self?.citySearchViewModel.searchLocation(completion: (self?.citySearchViewModel.searchResults.value[indexPath.element?.row ?? 0])!)
                self?.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
}
