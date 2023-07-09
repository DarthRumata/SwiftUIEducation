//
//  MainViewModel.swift
//  SwiftUIEducation
//
//  Created by Stas Kirichok on 12.05.2023.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    private let router: AnyRouter<MainViewRoute>
    private var cancellables = Set<AnyCancellable>()
    
    init(router: AnyRouter<MainViewRoute>) {
        self.router = router
    }
    
    func trigger(_ navigation: Navigation<MainViewRoute>) {
        router.trigger(navigation: navigation)
    }
}


