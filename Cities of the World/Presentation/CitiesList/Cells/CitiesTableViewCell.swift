//
//  CitiesTableViewCell.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 07/08/2022.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {
	
	static let identifier = "CitiesTableViewCell"
	
	
	
	static func toNib() -> UINib {
		UINib(nibName: identifier, bundle: nil)
	}

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
