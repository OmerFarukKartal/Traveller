//
//  TourListViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 25.05.2024.
//

import UIKit

class TourListViewController: UIViewController {
    
    var kisiSayisi : Int?
    
    let tourListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tur Listesi"
        return label
    }()
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var tableView = UITableView()
    var tours: [TourWithId] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    let viewModel = ToursViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
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
        seferListLabelStackView.addArrangedSubview(tourListLabel)
        
        let titleLabel = UILabel()
        titleLabel.text = "TRAVELLER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        titleLabel.textAlignment = .center
        titleStackView.addSubview(titleLabel)
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        view.addSubview(tourListLabel)
        tourListLabel.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.35, paddingRight: screenWidth * 0.35)
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TourTableViewCell.self, forCellReuseIdentifier: "TourTableViewCell")
        tableView.rowHeight = screenHeight * 0.1
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchor(top: tourListLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: 0, paddingRight: 0)
    }
}


extension TourListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TourTableViewCell", for: indexPath) as! TourTableViewCell
        let tour = viewModel.searchResult[indexPath.row]
        cell.setImage(tour.image)
        cell.tourNameLabel.text = tour.name
        cell.priceLabel.text = "\(tour.tourAdultPrice) $"
        cell.ratingBar.rating = tour.stars
        cell.setRate(Double(tour.rating))
        cell.tourTypeLabel.text = tour.tourTypeName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tour = viewModel.searchResult[indexPath.row]
        guard let id = tour.id else { return }
        
        let tourDetailVc = TourDetailViewController()
        tourDetailVc.tourId = id
        tourDetailVc.kisiSayisi = kisiSayisi
        navigationController?.pushViewController(tourDetailVc, animated: true)
    }
}

