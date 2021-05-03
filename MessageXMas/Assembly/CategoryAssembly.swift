//
//  CategoryAssembly.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 29/4/21.
//

import Foundation
import SwiftUI

class CategoryAssembly: BaseAssembly {
    static func assembly() -> CategortyListView {
        let viewModel = CategoryListViewModel()
        let view = CategortyListView(viewModel: viewModel)
        return view
    }
}
