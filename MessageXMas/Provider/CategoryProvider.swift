//
//  CategoryProvider.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 25/3/21.
//

import Foundation
import Combine

protocol CategoryProviderProtocol: BaseProviderProtocol {
    func fetchCategoryList(success: @escaping([CategoryItem]) -> (), failure: @escaping(APIError) -> ())
}

class CategoryProvider: BaseProvider, CategoryProviderProtocol {
    var cancellable: Set<AnyCancellable> = []
    
    func fetchCategoryList(success: @escaping([CategoryItem]) -> (), failure: @escaping(APIError) -> ()) {
        requestGeneric([CategoryItem].self, endpoint: "https://605ca20d6d85de00170dac06.mockapi.io/msgxmas/v1/categories")
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    failure(error)
                }
            } receiveValue: { (categoryList) in
                success(categoryList)
            }.store(in: &cancellable)
        }
}
