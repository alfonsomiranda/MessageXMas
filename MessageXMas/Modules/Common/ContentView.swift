//
//  EmptyView.swift
//  MessageXMas
//
//  Created by Alfonso Miranda Castro on 31/3/21.
//

import SwiftUI

struct ContentView<T: View>: View {
    var state: ViewModelState
    var listView: T
    
    var body: some View {
        GeometryReader { geometry in
            switch state {
            case .error:
                Text("Error")
            case .loading:
                VStack {
                    Text("Loading")
                    ProgressView()
                }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            case .empty:
                Text("Empty")
            case .success:
                listView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(state: .success, listView: ListView(categories: []))
    }
}
