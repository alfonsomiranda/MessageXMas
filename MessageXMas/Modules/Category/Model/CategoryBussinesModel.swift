//
//  CategoryBussinesModel.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 27/4/21.
//

import Foundation

struct CategoryBussinesModel: Codable {
    var id: Int
    var title: String
    var subtitle: String
    
    init(serverModel: CategoryServerModel) {
        self.id = serverModel.id
        self.title = serverModel.name
        self.subtitle = serverModel.subtitle
    }
}
