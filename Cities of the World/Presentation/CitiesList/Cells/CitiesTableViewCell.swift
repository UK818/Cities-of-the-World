//
//  CitiesTableViewCell.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 07/08/2022.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {
	
	static let identifier = "CitiesTableViewCell"
	
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var cityName: UILabel!
	@IBOutlet weak var cityLocalName: UILabel!
	
	static func toNib() -> UINib {
		UINib(nibName: identifier, bundle: nil)
	}

    override func awakeFromNib() {
        super.awakeFromNib()
		containerView.addDropShadow()
    }
	
	func populateCell(with data: CityModel) {
		cityName.text = data.name
		cityLocalName.text = data.localName
	}

}
