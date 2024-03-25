//
// HomePageViewController.swift
// Traveller

//Created by Ömer Faruk KARTAL on 18.03.2024.
//

import UIKit

class HomePageViewController: UIViewController /*UITableViewDelegate*/ /*UITableViewDataSource*/  {
//
//    var tableView = UITableView()
//    var data: [String] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        UISetup()
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    func UISetup() {
//        
//        view.backgroundColor = UIColor.white
//        
//        let mainStackView = UIStackView()
//        mainStackView.backgroundColor = UIColor.blue
//        mainStackView.axis = .vertical
//        mainStackView.distribution = .fillEqually
//        mainStackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(mainStackView)
//        
//        let titleStackView = UIStackView()
//        titleStackView.backgroundColor = UIColor.red
//        titleStackView.axis = .vertical
//        titleStackView.distribution = .fillEqually
//        titleStackView.translatesAutoresizingMaskIntoConstraints = false
//        mainStackView.addSubview(titleStackView)
//        
//        // StackView Constraints for titleStackView
//        NSLayoutConstraint.activate([
//            titleStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0), // Top to safe area top
//            titleStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0), // Leading to safe area leading
//            titleStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0), // Trailing to safe area trailing
//            titleStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15) // Height: 15% of screen height
//        ])
//        
//        let choiceStackView = UIStackView()
//        choiceStackView.backgroundColor = UIColor.gray
//        choiceStackView.axis = .horizontal
//        choiceStackView.distribution = .equalSpacing  // Ensures equal spacing around controls
//        choiceStackView.translatesAutoresizingMaskIntoConstraints = false
//        mainStackView.addSubview(choiceStackView)
//        
//        // StackView Constraints for choiceStackView
//        NSLayoutConstraint.activate([
//            choiceStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 0),
//            choiceStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
//            choiceStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
//            choiceStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.225) // Adjust height as needed
//        ])
//        
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        mainStackView.addSubview(tableView)
//        
//        NSLayoutConstraint.activate([
//                    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//                    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//                    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//                    tableView.topAnchor.constraint(equalTo: choiceStackView.bottomAnchor)
//                ])
//        
//        let segmentedControlContainer = UIStackView()  // Create a new container for segmented control & labels
//        segmentedControlContainer.axis = .vertical
//        segmentedControlContainer.spacing = 10  // Adjust spacing between image and label
//        segmentedControlContainer.translatesAutoresizingMaskIntoConstraints = false
//        choiceStackView.addSubview(segmentedControlContainer)
//        
//        let choiceControl = UISegmentedControl(items: ["FLIGHTS", "HOTELS", "TOURS"])
//        choiceControl.selectedSegmentIndex = 0
//        choiceControl.addTarget(self, action: #selector(choiceControlValueChanged), for: .valueChanged)
//        choiceControl.translatesAutoresizingMaskIntoConstraints = false
//        segmentedControlContainer.addArrangedSubview(choiceControl)
//        
//        let labelsStackView = UIStackView()  // Create a stack to hold segment titles
//        labelsStackView.axis = .horizontal
//        labelsStackView.distribution = .fillEqually
//        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
//        segmentedControlContainer.addArrangedSubview(labelsStackView)
//        
//        let label1 = UILabel()
//        label1.text = "FLIGHTS"
//        label1.textAlignment = .center
//        // Increase font size by 1.5 times
//        label1.font = UIFont.systemFont(ofSize: 12 * 1.5)  // Adjust label font size
//        labelsStackView.addArrangedSubview(label1)
//        
//        let label2 = UILabel()
//        label2.text = "HOTELS"
//        label2.textAlignment = .center
//        // Increase font size by 1.5 times
//        label2.font = UIFont.systemFont(ofSize: 12 * 1.5)
//        labelsStackView.addArrangedSubview(label2)
//        
//        let label3 = UILabel()
//        label3.text = "TOURS"
//        label3.textAlignment = .center
//        // Increase font size by 1.5 times
//        label3.font = UIFont.systemFont(ofSize: 12 * 1.5)
//        labelsStackView.addArrangedSubview(label3)
//        
//        // Sembolleri Ekleme:
//        let symbol1 = UIImage(systemName: "airplane")
//        let symbol2 = UIImage(systemName: "bed.double")
//        let symbol3 = UIImage(systemName: "car")
//        
//        // Increase image size by 1.5 times
//        choiceControl.setImage(symbol1!.withConfiguration(UIImage.SymbolConfiguration(pointSize: 18 * 1.5)), forSegmentAt: 0)
//        choiceControl.setImage(symbol2!.withConfiguration(UIImage.SymbolConfiguration(pointSize: 18 * 1.5)), forSegmentAt: 1)
//        choiceControl.setImage(symbol3!.withConfiguration(UIImage.SymbolConfiguration(pointSize: 18 * 1.5)), forSegmentAt: 2)
//        
//        let initialSegmentIndex = 0
//        choiceControl.selectedSegmentIndex = initialSegmentIndex
//        
//        let titleLabel = UILabel()
//        titleLabel.text = "TRAVELLER"
//        titleLabel.textColor = UIColor.white
//        // Increase font size by 1.5 times
//        titleLabel.font = UIFont.systemFont(ofSize: 30 * 1.5, weight: .bold)
//        titleLabel.textAlignment = .center // Title is already horizontally centered
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleStackView.addSubview(titleLabel)
//        
//        // Constraints for titleLabel (unchanged)
//        NSLayoutConstraint.activate([
//            titleLabel.centerXAnchor.constraint(equalTo: titleStackView.centerXAnchor), // Center horizontally
//            titleLabel.bottomAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 0) // Bottom with slight padding
//        ])
//        
//        // Constraint for centering choiceControl horizontally:
//        NSLayoutConstraint.activate([
//            segmentedControlContainer.centerXAnchor.constraint(equalTo: choiceStackView.centerXAnchor)
//        ])
//        
//        
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//    
//    @objc func choiceControlValueChanged(_ sender: UISegmentedControl) {
//        
//    }
}
