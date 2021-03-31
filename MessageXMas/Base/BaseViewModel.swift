//
//  BaseViewModel.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 31/3/21.
//

import Foundation

enum ViewModelState {
    case success
    case error
    case loading
    case empty
}

class BaseViewModel: ObservableObject {
    @Published var state: ViewModelState = .empty
}
