//
//  ViewController.swift
//  Cities of the World
//
//  Created by Usman.Kulaha on 05/08/2022.
//

import UIKit
import RxSwift

class CitiesViewController: UIViewController {
	
	@IBOutlet weak var citySearchBar: UISearchBar!
	@IBOutlet weak var citiesTableView: UITableView!
	
	private let disposeBag = DisposeBag()
	
	var viewModel: ViewModel?
	var cities: [City]? = [City]()
	var cordinates: [[Double]]? = [[Double]]()
	var cityNames: [String]? = [String]()
	
	var total = 0
	var currentPage = 0
	var isLoading = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCitiesTableView()
		setupView()
		setupObservers()
	}

	func setupObservers() {
		viewModel?.cities.subscribe { [weak self] res in
			guard let self = self else { return }
			if let data = res.element?.data {
				print(data.items)
				DispatchQueue.main.async {
					for item in data.items {
						if let latitude = item.latitude, let longitude = item.longitude, let cityName = item.name {
							let cordinate: [Double] = [latitude, longitude]
							self.cordinates?.append(cordinate)
							self.cityNames?.append(cityName)
						}
					}
					if let totalPages = data.pagination.total, let currentPage = data.pagination.currentPage {
						self.total = totalPages
						self.currentPage = currentPage
					}
					self.isLoading = false
					self.cities = data.items
					self.citiesTableView.reloadData()
					self.citiesTableView.layoutIfNeeded()
				}
			}
		}.disposed(by: disposeBag)
	}
	
	func setupView() {
		let repository: Repository = Repository(remoteDataSource: NetworkService())
		viewModel = ViewModel(repository: repository)
//		dismissKeyboardOnTap()
		citySearchBar.delegate = self
		viewModel?.fetchCities(page: 1)
	}
	
	func setupCitiesTableView() {
		citiesTableView.register(CitiesTableViewCell.toNib(), forCellReuseIdentifier: CitiesTableViewCell.identifier)
		citiesTableView.delegate = self
		citiesTableView.dataSource = self
	}
}

// MARK: - UISearchBarDelegate
extension CitiesViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		viewModel?.filterCities(cityName: searchText, page: 1)
	}
}

// MARK: - UITableViewDelegate
extension CitiesViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		cities?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: CitiesTableViewCell.identifier, for: indexPath) as? CitiesTableViewCell else {
			return UITableViewCell()
		}
		if let city = cities?[indexPath.row] {
			cell.populateCell(with: city)
		}
		return cell
	}
}


// MARK: - UITableViewDelegate
extension CitiesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		90
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		if let vc = UIStoryboard(name: "MapStoryboard", bundle: .main).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
			if let cordinate = cordinates?[indexPath.row], let cityName = cityNames?[indexPath.row] {
				vc.latitude = cordinate[0]
				vc.longitude = cordinate[1]
				vc.cityName = cityName
			}
			navigationController?.pushViewController(vc, animated: true)
		}
	}
}

// MARK: - UIScrollViewDelegate
extension CitiesViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let position = scrollView.contentOffset.y

		if position > (citiesTableView.contentSize.height - 100 - scrollView.frame.height) {
			if currentPage < total {
				if !isLoading {
					viewModel?.fetchCities(page: currentPage + 1)
				}
				isLoading = true
			}
		}

		if position < 10 {
			if currentPage > 1 {
				if !isLoading {
					viewModel?.fetchCities(page: currentPage - 1)
				}
				isLoading = true
			}
		}
	}
}


