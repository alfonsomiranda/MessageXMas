//
//  CategoryListViewModel.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 23/3/21.
//

import Foundation

class CategoryListViewModel: ObservableObject {
    @Published var categoryList: [CategoryItem] = []
    private let provider: BaseProviderProtocol = BaseProvider()
    
    func fetchCategoryList() {
        categoryList = [
            CategoryItem(id: UUID(), title: "Categoria 1", subtitle: "Subcategoria 1"),
            CategoryItem(id: UUID(), title: "Categoria 2", subtitle: "Subcategoria 2"),
            CategoryItem(id: UUID(), title: "Categoria 3", subtitle: "Subcategoria 3"),
            CategoryItem(id: UUID(), title: "Categoria 4", subtitle: "Subcategoria 4"),
            CategoryItem(id: UUID(), title: "Categoria 5", subtitle: "Subcategoria 5"),
            CategoryItem(id: UUID(), title: "Categoria 6", subtitle: "Subcategoria 6"),
            CategoryItem(id: UUID(), title: "Categoria 7", subtitle: "Subcategoria 7"),
            CategoryItem(id: UUID(), title: "Categoria 8", subtitle: "Subcategoria 8"),
            CategoryItem(id: UUID(), title: "Categoria 9", subtitle: "Subcategoria 9")
        ]
    }
}
