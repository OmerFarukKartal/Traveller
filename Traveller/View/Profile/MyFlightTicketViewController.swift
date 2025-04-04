//
//  MyFlightTicketViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 6.06.2024.
//

import UIKit

class MyFlightTicketViewController: UIViewController {
    
    var tableView = UITableView()
    var viewModel = FlightViewModel.shared
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    let ucakBiletlerimLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.getFlightTicket {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupUI () {
        view.backgroundColor = .white
        
        let titleStackView = UIStackView()
        titleStackView.backgroundColor = .red
        titleStackView.axis = .vertical
        titleStackView.distribution = .fill
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleStackView)
        
        titleStackView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.15)
        
        let titleLabel = UILabel()
        titleLabel.text = "TRAVELLER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        titleLabel.textAlignment = .center
        titleStackView.addSubview(titleLabel)
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        view.addSubview(ucakBiletlerimLabel)
        ucakBiletlerimLabel.textColor = .black
        ucakBiletlerimLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        ucakBiletlerimLabel.textAlignment = .center
        ucakBiletlerimLabel.text = "Uçak Biletlerim"
        ucakBiletlerimLabel.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.3)
        
        let cizgi = UIView()
        cizgi.backgroundColor = .black
        cizgi.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cizgi)
        cizgi.anchor(top: ucakBiletlerimLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 2, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1, height: 1)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.anchor(top: cizgi.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.rowHeight = screenHeight * 0.2
        tableView.register(MyFlightTicketTableViewCell.self, forCellReuseIdentifier: "MyFlightTicketTableViewCell")
        
    }
    
}

extension MyFlightTicketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.flightTicket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFlightTicketTableViewCell", for: indexPath) as! MyFlightTicketTableViewCell
        
        let ticket = viewModel.flightTicket[indexPath.row]
        
        cell.departureCityLabel.text = ticket.departureCity
        cell.landingCityLabel.text = ticket.landingCity
        cell.nameLabel.text = "\(ticket.name) \(ticket.surname)"
        cell.emailLabel.text = ticket.email
        cell.priceLabel.text = "\(ticket.totalPrice)$"
        cell.phoneLabel.text = ticket.phone
        return cell
    }
    
    
}
