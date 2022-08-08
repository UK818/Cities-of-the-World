//
//  UIViewController+Extension.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 08/08/2022.
//

import UIKit

extension UIViewController {
	
	static var reuseIdentifier: String {
		return String(describing: self)
	}
	
	func dismissKeyboardOnTap() {
		view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
	}
}
