//
//  CategoryDetailView.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 31/3/21.
//

import SwiftUI

struct CategoryDetailView: View {
    var category: String
    
    var body: some View {
        Text(category).navigationTitle("Detalle")
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(category: "")
    }
}
