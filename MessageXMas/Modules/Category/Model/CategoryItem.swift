//
//  CategoryItem.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 23/3/21.
//

import Foundation

struct CategoryItem: Codable, Identifiable {
    var id: Int
    var title: String
    var subtitle: String
    
    init(bussinesModel: CategoryBussinesModel) {
        self.id = bussinesModel.id
        self.title = bussinesModel.title
        self.subtitle = bussinesModel.subtitle
    }
}
