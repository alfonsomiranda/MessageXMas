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
            ContentView<ListView>(state: self.viewModel.state, listView: ListView(categories: self.viewModel.categoryList))
        }.onAppear() {
            self.viewModel.fetchCategoryList()
        }
    }
}

struct CategortyListView_Previews: PreviewProvider {
    static var previews: some View {
        CategortyListView()
    }
}

struct ListView: View {
    var categories: [CategoryItem] = []
    var body: some View {
        List(self.categories) { item in
            NavigationLink(destination: CategoryDetailView(category: item.title)) {
                Text(item.title)
            }
        }.navigationTitle("Categorías")
    }
}
