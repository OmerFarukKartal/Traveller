import UIKit

class FlightViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: - Properties
    var viewModel = FlightViewModel.shared
    var tableView = UITableView()
    let departurePickerView = UIPickerView()
    let landingPickerView = UIPickerView()
    let departureAirPortList = ["...","Esenboğa", "Şakir Paşam", "Adnan Menderes", "Sabiha Gökçen", "Çardak"]
    let landingAirPortList = ["...","Çardak", "Sabiha Gökçen", "Adnan Menderes", "Şakir Paşam", "Esenboğa"]

    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    let departureTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Havaalanı Seçiniz"
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    let landingTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Havaalanı Seçiniz"
        textField.borderStyle = .roundedRect
        return textField
    }()

    let landingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nereye:"
        return label
    }()
    
    let tarihLabel: UILabel = {
        let label = UILabel()
        label.text = "Tarih:"
        label.textColor = UIColor.black
        return label
    }()
    
    let populerUcuslarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popüler Uçuşlar"
        return label
    }()
    
    let departureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nereden:"
        return label
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ara", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(flightSearch), for: .touchUpInside)
        return button
    }()
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePicker.date = Date()
        return datePicker
    }()
    
    let departureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = -1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let landingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = -1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let tarihStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = -1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        pickerToolBar()
        view.backgroundColor = .white
        viewModel.getPopularFlights {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    private func setupUI() {
        view.backgroundColor = .white
 
        // Title StackView
        let titleStackView = UIStackView()
        titleStackView.backgroundColor = .red
        titleStackView.axis = .vertical
        titleStackView.distribution = .fill
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleStackView)

        titleStackView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor,right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.15)
        
        
        let titleLabel = UILabel()
        titleLabel.text = "TRAVELLER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.addSubview(titleLabel)
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        departureStackView.addArrangedSubview(departureLabel)
        departureTextField.anchor(width: screenWidth * 0.5)
        departureStackView.addArrangedSubview(departureTextField)
        view.addSubview(departureStackView)
        departureStackView.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.25)
        
        landingStackView.addArrangedSubview(landingLabel)
        landingTextField.anchor(width: screenWidth * 0.5)
        landingStackView.addArrangedSubview(landingTextField)
        view.addSubview(landingStackView)
        landingStackView.anchor(top: departureStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.25)
        
        tarihStackView.addArrangedSubview(tarihLabel)
        tarihStackView.addArrangedSubview(datePicker)
        view.addSubview(tarihStackView)
        tarihStackView.anchor(top: landingStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.44)
        
        
        
        view.addSubview(searchButton)
        searchButton.anchor(top: tarihStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.24, paddingRight: screenWidth * 0.3)

        
        view.addSubview(populerUcuslarLabel)
        populerUcuslarLabel.anchor(top: searchButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.34, paddingRight: screenWidth * 0.34)
        
        // Table View
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchor(top: populerUcuslarLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenWidth * 0.02, paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.82)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FlightTableViewCell.self, forCellReuseIdentifier: "FlightTableViewCell")
        tableView.rowHeight = screenHeight * 0.1

        // Setup Departure Picker View
        departurePickerView.delegate = self
        departurePickerView.dataSource = self
        departureTextField.inputView = departurePickerView
        
        landingPickerView.delegate = self
        landingPickerView.dataSource = self
        landingTextField.inputView = landingPickerView
        
        
    }
    
    @objc func flightSearch() {
        
    }
    
    @objc func datePickerValueChanged (_ sender: UIDatePicker) {
        
    }
    
    func pickerToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        landingTextField.inputAccessoryView = toolBar
        departureTextField.inputAccessoryView = toolBar
        
        let doneButton = UIBarButtonItem(title: "Seç", style: UIBarButtonItem.Style.done, target: self, action: #selector(dissmissPicker))
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true

    }
    
    @objc func dissmissPicker() {
        view.endEditing(true)
    }

    // MARK: - UIPickerViewDataSource & UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == landingPickerView {
            return landingAirPortList.count
        } else{
            return departureAirPortList.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == landingPickerView {
            return landingAirPortList[row]
        }else{
            return departureAirPortList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == landingPickerView {
            landingTextField.text = landingAirPortList[row]
        }else{
            departureTextField.text = departureAirPortList[row]
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension FlightViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.popularFlights.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightTableViewCell", for: indexPath) as! FlightTableViewCell
        
        let flight = viewModel.popularFlights[indexPath.row]
        cell.departureCityLabel.text = flight.departureCity
        cell.landingCityLabel.text = flight.landingCity
        cell.airlaneNameLabel.text = flight.airlineName
        cell.durationTimeLabel.text = "\(flight.duration) hour"
        cell.setImage(flight.airlineImage)
        return cell
    }
}
