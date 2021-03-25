//
//  CategortyListView.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 23/3/21.
//

import SwiftUI

struct CategortyListView: View {
    @ObservedObject var viewModel = CategoryListViewModel()
        
    var body: some View {
        NavigationView {
            List(self.viewModel.categoryList) { item in
                Text(item.title)
            }.onAppear(perform: {
                self.viewModel.fetchCategoryList()
            }).navigationTitle("Categorías")
        }
    }
}

struct CategortyListView_Previews: PreviewProvider {
    static var previews: some View {
        CategortyListView()
    }
}
