//
//  NetworkServiceConstants.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 07/08/2022.
//

import Foundation

enum NetworkRequestMethod: String {
	case get = "GET"
	case post = "POST"
}

class NetworkServiceConstants {
	static let BASE_URL: String = "https://connect-demo.mobile1.io/square1/connect/v1/city"
}

