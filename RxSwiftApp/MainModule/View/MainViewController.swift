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
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel : MainVIewModelProtocol?
    var viewModelBuilder : MainVIewModelProtocol.ViewModelBuilder?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = viewModelBuilder?((
            searchText : searchText.rx.text.orEmpty.asDriver(), ()
        ))
        self.title = "Airports"
    }

}

