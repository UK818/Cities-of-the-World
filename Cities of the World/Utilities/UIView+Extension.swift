//
//  UIView+Extension.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 07/08/2022.
//

import Foundation
import UIKit

extension UIView {
	func addDropShadow(cornerRadius: CGFloat = 10, color: UIColor = .black, opacity: Float = 0.3, offSet: CGSize =  CGSize(width: -1, height: 1), radius: CGFloat = 5, scale: Bool = true) {
		layer.shadowColor = color.cgColor
		layer.shadowOpacity = opacity
		layer.shadowOffset = offSet
		layer.shadowRadius = radius
		layer.cornerRadius = cornerRadius
	}
}
