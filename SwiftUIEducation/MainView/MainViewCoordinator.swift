//
//  MainViewCoordinator.swift
//  SwiftUINavigation
//
//  Created by Stas Kirichok on 09.06.2023.
//

import SwiftUI

struct MainViewCoordinator: View {
    var body: some View {
        NavigationStackCoordinator { router in
            MainView(viewModel: MainViewModel(router: router))
        } destinations: { (route: MainViewRoute) in
            switch route {
            case .secondary:
                return SecondViewCoordinator()
            }
        }
    }
}
