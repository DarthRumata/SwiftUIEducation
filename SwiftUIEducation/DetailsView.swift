//
//  DetailsView.swift
//  SwiftUINavigation
//
//  Created by Stas Kirichok on 07.06.2023.
//

import SwiftUI

enum DetailsRoute: Route {
    
}

struct DetailsViewModel {
    private let router: AnyRouter<DetailsRoute>
    let argumentPassedFromRoute: String
    
    init(router: AnyRouter<DetailsRoute>, argumentPassedFromRoute: String) {
        self.router = router
        self.argumentPassedFromRoute = argumentPassedFromRoute
    }
    
    func trigger(navigation: Navigation<DetailsRoute>) {
        router.trigger(navigation: navigation)
    }
}

struct DetailsView: View {
    let viewModel: DetailsViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "info.square")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Details View content: \(viewModel.argumentPassedFromRoute)")
                .navigationTitle("Details")
            Button("Pop to previous screen") {
                viewModel.trigger(navigation: .pop)
            }
            Button("Pop to root screen") {
                viewModel.trigger(navigation: .popToRoot)
            }
        }
    }
}
