//
//  CategoryInteractor.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 27/4/21.
//

import Foundation

protocol CategoryInteractorProtocol {
    func fetchCategoryList(success: @escaping([CategoryBussinesModel]) -> (), failure: @escaping(Error) -> ())
}

class CategoryInteractor: CategoryInteractorProtocol {
    private let provider: CategoryProviderProtocol = CategoryProvider()
    
    func fetchCategoryList(success: @escaping([CategoryBussinesModel]) -> (), failure: @escaping(Error) -> ()) {
        self.provider.fetchCategoryList {(categoryList) in
            let bussinesModel = categoryList.map {CategoryBussinesModel(serverModel: $0)}
            success(bussinesModel)
        } failure: {(error) in
            failure(error)
        }
    }
}
