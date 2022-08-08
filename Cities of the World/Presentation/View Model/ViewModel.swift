//
//  ViewModel.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 07/08/2022.
//

import Foundation
import RxSwift

class ViewModel {
	
	private let repository: Repository
	var errorHandler: PublishSubject<ErrorModel> = PublishSubject<ErrorModel>()
	var cities: PublishSubject<CityAPIResponse> = PublishSubject<CityAPIResponse>()
	
	
	init(repository: Repository) {
		self.repository = repository
	}
	
	func fetchCities(page: Int) {
		let payload = NetworkServicePayload.sharedInstance.fetchCitiesPayload(page: "\(page)")
		repository.fetchCitiesData(payload: payload) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let res):
					self.cities.onNext(res)
			case .failure(let error):
				self.errorHandler.onNext(error)
			}
		}
	}
	
	func filterCities(cityName: String, page: Int) {
		let payload = NetworkServicePayload.sharedInstance.filterCitiesPayload(name: cityName, page: "\(page)")
		repository.fetchCitiesData(payload: payload) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let res):
					self.cities.onNext(res)
			case .failure(let error):
				self.errorHandler.onNext(error)
			}
		}
	}
	
}
