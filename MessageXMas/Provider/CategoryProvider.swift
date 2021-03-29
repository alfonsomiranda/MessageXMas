//
//  CategoryProvider.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 25/3/21.
//

import Foundation
import Combine

protocol CategoryProviderProtocol: BaseProviderProtocol {
    func fetchCategoryList(success: @escaping([CategoryItem]) -> (), failure: @escaping(NetworkingError) -> ())
}

class CategoryProvider: BaseProvider, CategoryProviderProtocol {
    
    var cancellable = Set<AnyCancellable>()
    
    func fetchCategoryList(success: @escaping([CategoryItem]) -> (), failure: @escaping(NetworkingError) -> ()) {
        requestGeneric(Endpoint.categories().url, entityClass: [CategoryItem].self)
            .sink { (resultCombine) in
              switch resultCombine{
              case let .failure(error):
                  failure(error)
              case .finished: break
              }
            } receiveValue: { (resultCategoryEntity) in
              success(resultCategoryEntity)
            }.store(in: &cancellable)

        }
}
