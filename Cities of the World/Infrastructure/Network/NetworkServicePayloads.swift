//
//  NetworkServicePayloads.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 07/08/2022.
//

import Foundation

class NetworkServicePayload {
	
	static let sharedInstance = NetworkServicePayload()
	
	func fetchCitiesPayload(page: String) -> [String: Any] {
		return ["page": page]
	}
	
	func filterCitiesPayload(name: String, page: String) -> [String: Any] {
		return [
			"filter[0][name][contains]": name,
			"page": page
		]
	}
	
}
