//
//  FlightListViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 21.05.2024.
//

import UIKit

class FlightListViewController: UIViewController {
    
    let viewModel = FlightViewModel.shared
    var tableView = UITableView()
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    var airportId: Int?
    var landingCity: String?
    
    let seferListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sefer Listesi"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
        self.navigationItem.title = ""
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        let titleStackView = UIStackView()
        titleStackView.backgroundColor = .red
        titleStackView.axis = .vertical
        titleStackView.distribution = .fill
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleStackView)
        
        titleStackView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.15)
        
        let seferListLabelStackView = UIStackView()
        seferListLabelStackView.backgroundColor = .white
        seferListLabelStackView.axis = .vertical
        seferListLabelStackView.distribution = .fill
        seferListLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(seferListLabelStackView)
        seferListLabelStackView.addArrangedSubview(seferListLabel)
        
        let titleLabel = UILabel()
        titleLabel.text = "TRAVELLER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        titleLabel.textAlignment = .center
        titleStackView.addSubview(titleLabel)
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        view.addSubview(seferListLabel)
        seferListLabel.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.35, paddingRight: screenWidth * 0.35)
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FlightTableViewCell.self, forCellReuseIdentifier: "FlightTableViewCell")
        tableView.rowHeight = screenHeight * 0.1
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchor(top: seferListLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: 0, paddingRight: 0)
    }
    
    func fetchData() {
        viewModel.searchFlight(airportid: airportId!, landingCity: landingCity!) {
            DispatchQueue.main.async {
                print(self.airportId!, self.landingCity!)
                self.tableView.reloadData()
            }
        }
    }
}
extension FlightListViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.searchResults.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlightTableViewCell", for: indexPath) as! FlightTableViewCell
            
            let flight = viewModel.searchResults[indexPath.row]
            cell.departureCityLabel.text = flight.departureCity
            cell.landingCityLabel.text = flight.landingCity
            cell.airlineNameLabel.text = flight.airlineName
            cell.durationTimeLabel.text = "\(flight.duration) hour"
            cell.setImage(flight.airlineImage)
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let flight = viewModel.searchResults[indexPath.row]
            guard let id = flight.flightId else { return }
            
            let flightDetailVC = FlightDetailViewController()
            flightDetailVC.flightID = id // Uçuş ID'sini ata
            navigationController?.pushViewController(flightDetailVC, animated: true)
        }
    }

