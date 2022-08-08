//
//  NetworkService.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 07/08/2022.
//

import Foundation
import Alamofire


protocol RemoteDataSource {
	func fetch<T>(relativeUrl urlString: String, method: HTTPMethod, type: T.Type, payload: [String: Any]?, completionHandler completion: @escaping (Result<T, ErrorModel>) -> Void) where T : Decodable, T : Encodable
}

class NetworkService: RemoteDataSource {
	
	func fetch<T>(relativeUrl urlString: String, method: HTTPMethod, type: T.Type, payload: [String: Any]? = [:], completionHandler completion: @escaping (Result<T, ErrorModel>) -> Void) where T : Decodable, T : Encodable {

		guard let url = URL(string: NetworkServiceConstants.BASE_URL + urlString) else {
			return
		}
		debugPrint("full url is \(NetworkServiceConstants.BASE_URL + urlString)")

		var makeRequest = URLRequest(url: url)
		makeRequest.httpMethod = method.rawValue

		if !(payload?.isEmpty ?? true) {
			let jsonData = try? JSONSerialization.data(withJSONObject: payload!)
			debugPrint("full \(payload!)")
			makeRequest.httpBody = jsonData
		}
		

		AF.request(makeRequest).responseDecodable(of: type.self) { response in
			switch response.result {
			case .success:
				if let data = response.data {
					if let decodedResponse = try? JSONDecoder().decode(type.self, from: data) {
						completion(.success(decodedResponse))
					}
					else {
						if let decodedResponse = try? JSONDecoder().decode(ErrorModel.self, from: data) {
							completion(.failure(decodedResponse))
						}
						else {
							let error = ErrorModel(message: "Unable to parse JSON")
							completion(.failure(error))
						}
					}
				}
			case let .failure(error):
				if let data = response.data {
					if let decodedResponse = try? JSONDecoder().decode(ErrorModel.self, from: data) {
						completion(.failure(decodedResponse))
					}
				}
				else {
					let error = ErrorModel(message: error.errorDescription)
					completion(.failure(error))
				}
			}
		}
	}
	
}
