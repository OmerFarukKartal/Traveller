//
//  BlogViewModel.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 3.06.2024.
//

import Foundation

class BlogViewModel {
    let networkManager = NetworkManager.shared
    static let shared = BlogViewModel()
    var errorMessage : String = ""
    var blogList: [BlogList] = []
    
    func getAllBlogList(completion: @escaping () -> Void) {
        networkManager.getAllBlogList { result in
            switch result {
            case .success(let blogList):
                self.blogList = blogList
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func getSelectedBlog(blogId: Int, completion: @escaping (Result<BlogList, Error>) -> Void) {
        networkManager.getBlogWithId(blogId: blogId) { result in
            switch result {
            case .success(let blogDetail):
                completion(.success(blogDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
