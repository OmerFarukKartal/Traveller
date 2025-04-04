//
//  TourViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 29.04.2024.
//

import UIKit

class TourViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var turTipiPickerView = UIPickerView()
    var selectedTourTypeId: Int?
    var tableView = UITableView()
    var tourList: [[String]] = []
    var viewModel = ToursViewModel.shared
    var tourTypesList: [[String]] = []
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    let nereyeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Tur Tipini Seçiniz"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let nereyeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tur Tipi:"
        return label
    }()
    
    let tarihLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tarih:"
        return label
    }()
    
    let populerTurlarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popüler Turlar"
        return label
    }()
    
    let kisiSayisiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kişi Sayısı:"
        return label
    }()
    
    let kisiSayisiTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Kişi Sayısı Giriniz"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ara", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tourSearch), for: .touchUpInside)
        return button
    }()
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePicker.date = Date()
        return datePicker
    }()
    
    let nereyeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let kisiSayisiStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let tarihStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchTourTypeList()
        pickerToolBar()
        viewModel.getPopularTours {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.navigationItem.title = ""
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
            view.endEditing(true)
        }
    
    
    func setupUI() {
        
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.addSubview(titleLabel)
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        tarihStackView.addArrangedSubview(tarihLabel)
        tarihStackView.addArrangedSubview(datePicker)
        view.addSubview(tarihStackView)
        tarihStackView.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.38)
        
        nereyeStackView.addArrangedSubview(nereyeLabel)
        nereyeTextField.anchor(width: screenWidth * 0.5)
        nereyeStackView.addArrangedSubview(nereyeTextField)
        view.addSubview(nereyeStackView)
        nereyeStackView.anchor(top: tarihStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.20)

        kisiSayisiStackView.addArrangedSubview(kisiSayisiLabel)
        kisiSayisiTextField.anchor(width: screenWidth * 0.5)
        kisiSayisiStackView.addArrangedSubview(kisiSayisiTextField)
        view.addSubview(kisiSayisiStackView)
        kisiSayisiStackView.anchor(top: nereyeStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.20)
        
        view.addSubview(searchButton)
        searchButton.anchor(top: kisiSayisiStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.3, paddingRight: screenWidth * 0.3)
        
        view.addSubview(populerTurlarLabel)
        populerTurlarLabel.anchor(top: searchButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.34, paddingRight: screenWidth * 0.34)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchor(top: populerTurlarLabel.bottomAnchor,left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor ,paddingTop: screenHeight * 0.02, paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.8)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TourTableViewCell.self, forCellReuseIdentifier: "TourTableViewCell")
        tableView.rowHeight = screenHeight * 0.097
        
        turTipiPickerView.delegate = self
        turTipiPickerView.dataSource = self
        nereyeTextField.inputView = turTipiPickerView
    }
    
    func fetchTourTypeList() {
        self.viewModel.getTourTypeList { [weak self] tourTypeData in
            DispatchQueue.main.async {
                self?.tourTypesList = tourTypeData
                self?.turTipiPickerView.reloadAllComponents()
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tourTypesList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tourTypesList[row].first
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nereyeTextField.text = tourTypesList[row][0]
        selectedTourTypeId = Int(tourTypesList[row][1])
    }
    
    func pickerToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        nereyeTextField.inputAccessoryView = toolBar
        
        let doneButton = UIBarButtonItem(title: "Seç", style: UIBarButtonItem.Style.done, target: self, action: #selector(dissmissPicker))
        doneButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
    }
    
    @objc func dissmissPicker() {
          view.endEditing(true)
      }
    
    
    @objc func datePickerValueChanged (_ sender: UIDatePicker) {
        
    }
    
    @objc func tourSearch() {
        guard let typeid = selectedTourTypeId else { return }
        guard let kisiSayisiText = kisiSayisiTextField.text,
                  let kisiSayisi = Int(kisiSayisiText) else {
                showAlert(message: "Lütfen kişi sayısı giriniz.")
                return
            }
        
        viewModel.searchTour(typeid: typeid) {
            DispatchQueue.main.async {
                let vc = TourListViewController()
                vc.kisiSayisi = kisiSayisi
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
extension TourViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.popularTours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TourTableViewCell", for: indexPath) as! TourTableViewCell
        let tour = viewModel.popularTours[indexPath.row]
        cell.setImage(tour.image)
        cell.tourNameLabel.text = tour.name
        cell.priceLabel.text = "\(tour.tourAdultPrice) $"
        cell.ratingBar.rating = tour.stars
        cell.setRate(Double(tour.rating))
        cell.tourTypeLabel.text = tour.tourTypeName
        return cell
    }
    
    
}
