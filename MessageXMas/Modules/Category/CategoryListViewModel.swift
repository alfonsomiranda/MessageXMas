//
//  CategoryListViewModel.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 23/3/21.
//

import Foundation

class CategoryListViewModel: BaseViewModel {
    @Published var categoryList: [CategoryItem] = []
    private let provider: CategoryProviderProtocol = CategoryProvider()
    
    func fetchCategoryList() {
        self.state = .loading
        
        self.provider.fetchCategoryList {[weak self] (categoryList) in
            self?.state = (categoryList.isEmpty) ? .empty : .success
            self?.categoryList = categoryList
        } failure: {[weak self] (error) in
            self?.state = .error
            debugPrint("Error: \(error)")
        }
    }
}
