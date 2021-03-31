//
//  CategoryProvider.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 25/3/21.
//

import Foundation
import Combine

protocol CategoryProviderProtocol: BaseProviderProtocol {
    func fetchCategoryList(success: @escaping([CategoryItem]) -> (), failure: @escaping(Error) -> ())
}

class CategoryProvider: BaseProvider, CategoryProviderProtocol {
    var cancellable: Set<AnyCancellable> = []
    
    func fetchCategoryList(success: @escaping([CategoryItem]) -> (), failure: @escaping(Error) -> ()) {
        let dto = ProviderDTO(endpoint: "http://demo8628160.mockable.io/categories", method: .GET, body: nil)
        requestGeneric([CategoryItem].self, dto: dto)
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
