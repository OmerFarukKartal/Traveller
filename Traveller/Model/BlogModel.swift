//
//  BlogModel.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 3.06.2024.
//

import Foundation

struct BlogList: Decodable {
    let id: Int?
    let image: String?
    let title, date, desc: String?
    let blogCategoryID: Int?
    let blogCategoryName: String?

}
