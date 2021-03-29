//
//  CategoryListViewModel.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 23/3/21.
//

import Foundation

class CategoryListViewModel: ObservableObject {
    @Published var categoryList: [CategoryItem] = []
    private let provider: CategoryProviderProtocol = CategoryProvider()
    
    func fetchCategoryList() {
        self.provider.fetchCategoryList { [weak self] (categoryList) in
            self?.categoryList = categoryList
        } failure: { (error) in
            debugPrint("Error: \(error)")
        }
    }
}
