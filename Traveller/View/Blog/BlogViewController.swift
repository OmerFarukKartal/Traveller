//
//  BlogViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 2.06.2024.
//

import UIKit

class BlogViewController: UIViewController {
    
    var viewModel = BlogViewModel.shared
    var tableView = UITableView()
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width

    let blogListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rehber Yazıları"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.getAllBlogList {
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
        
        view.addSubview(blogListLabel)
        blogListLabel.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.35, paddingRight: screenWidth * 0.35)
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BlogTableViewCell.self, forCellReuseIdentifier: "BlogTableViewCell")
        tableView.rowHeight = screenHeight * 0.3
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchor(top: blogListLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: 0, paddingRight: 0)
    }

}
extension BlogViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.blogList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogTableViewCell", for: indexPath) as! BlogTableViewCell
        
        let blogs = viewModel.blogList[indexPath.row]
        cell.setImage(blogs.image)
        cell.countryLabel.text = blogs.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let blog = viewModel.blogList[indexPath.row]
        guard let id = blog.id else { return }
        
        let blogDetailVc = BlogDetailViewController()
        blogDetailVc.blogId = id
        navigationController?.pushViewController(blogDetailVc, animated: true)
    }
    
}
