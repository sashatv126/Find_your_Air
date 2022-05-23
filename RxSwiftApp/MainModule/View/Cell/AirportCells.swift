//
//  AirportCells.swift
//  RxSwiftApp
//
//  Created by Владимир on 23.05.2022.
//

import UIKit

class AirportCells: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(usingViewModel viewModel : CityViewModelProtocol) {
        
        self.cityLabel.text = viewModel.city
        self.stateLabel.text = viewModel.location
    }

}
