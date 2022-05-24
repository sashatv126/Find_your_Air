//
//  ViewController.swift
//  RxSwiftApp
//
//  Created by Владимир on 18.05.2022.
//

import UIKit
import RxSwift
import RxDataSources

class MainViewController: UIViewController, Storyboardable {
    
    @IBOutlet weak var viewAdd: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func text(_ sender: Any) {
        if searchText.text != "" {
            viewAdd.isHidden = true
        } else {
            viewAdd.isHidden = false
        }
    }
    
    private static let cellId = "AirportID"
    
    private var bag = DisposeBag()
    
    private lazy var datasource = RxTableViewSectionedReloadDataSource<CityItemsSection>(configureCell: { _,tableView,indexPth,item  in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewController.cellId, for: indexPth) as? AirportCells
        cell?.configure(usingViewModel: item)
        return cell ?? UITableViewCell()
    } )
     
    private var viewModel : MainVIewModelProtocol?
    var viewModelBuilder : MainVIewModelProtocol.ViewModelBuilder?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = viewModelBuilder?((
            
            searchText : searchText.rx.text.orEmpty.asDriver(), ()
        ))
       
        setupUI()
        setupBinding()
    }
}

private extension MainViewController {
    
    func setupUI() -> Void {
        
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: "AirportCells", bundle: nil), forCellReuseIdentifier: MainViewController.cellId)
        self.title = "Airports"
    }
    
    func setupBinding() -> Void {
        
        self.viewModel?
            .output
            .cities
            .drive(tableView.rx.items(dataSource : self.datasource))
            .disposed(by: bag)
    }
}

