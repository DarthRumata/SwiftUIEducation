//
//  ContentView.swift
//  SwiftUIEducation
//
//  Created by Stas Kirichok on 10.05.2023.
//

import SwiftUI

enum MainViewRoute: Route {
    case secondary
}

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        List {
            NavigationLink(value: MainViewRoute.secondary) {
                Label("Second View", systemImage: "square")
            }
            NavigationLink {
                Text("Here can be Third View")
            } label: {
                Label("Third View", systemImage: "compass.drawing")
            }
        }
        .navigationTitle("Main menu")
        .navigationBarTitleDisplayMode(.inline)
    }
}

                                
//            .navigationDestination(for: ContentViewRoute.self, destination: { value in
//                viewModel.destination(route: value)
//            })

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
////        MainView(viewModel: MainViewModel(navigation: NavigationService()))
// //       MainView()
//    }
//}
