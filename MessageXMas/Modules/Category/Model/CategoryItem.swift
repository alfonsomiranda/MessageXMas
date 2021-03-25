//
//  CategoryItem.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 23/3/21.
//

import Foundation

struct CategoryItem: Codable, Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
}
