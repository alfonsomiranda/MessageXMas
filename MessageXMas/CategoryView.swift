//
//  CategoryCellUIView.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 26/2/21.
//

import SwiftUI

struct CategoryView: View {
    @State var selectedClaim: CategoryItem?
    
    var body: some View {
        NavigationView {
            List(items) { item in
                CategoryRow(categoryItem: item, selectedCategory: self.$selectedClaim)
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
