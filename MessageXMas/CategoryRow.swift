//
//  CategoryUIView.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 26/2/21.
//

import SwiftUI

struct CategoryRow: View {
    var categoryItem: CategoryItem
    @Binding var selectedCategory: CategoryItem?
    
    var body: some View {
        VStack {
            Text(categoryItem.title)
            Text(categoryItem.subtitle)
        }.onTapGesture {
            self.selectedCategory = categoryItem
        }
    }
}

//struct CategoryUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryRow(categoryItem: CategoryItem(id: UUID(), title: "Prueba 1", subtitle: "Subtitulo 1"), selectedCategory: <#T##Binding<CategoryItem?>#>)
//    }
//}
