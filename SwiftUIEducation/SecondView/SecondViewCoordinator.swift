//
//  SecondViewCoordinator.swift
//  SwiftUINavigation
//
//  Created by Stas Kirichok on 09.06.2023.
//

import SwiftUI

enum SecondViewRoute: Route {
    case details(String)
}

struct SecondViewCoordinator: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ViewCoordinator {
            SecondView(viewModel: SecondViewModel(router: router.mapToRouter()))
        } destinations: { (route: SecondViewRoute) in
            switch route {
            case .details(let detail):
                return DetailsView(viewModel: DetailsViewModel(router: router.mapToRouter(), argumentPassedFromRoute: detail))
            }
        }
    }
}
