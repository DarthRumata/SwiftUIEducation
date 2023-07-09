//
//  ButtonViewModel.swift
//  SwiftUIEducation
//
//  Created by Stas Kirichok on 12.05.2023.
//

import Foundation

class SecondViewModel: ObservableObject {
    private let router: AnyRouter<SecondViewRoute>
    
    init(router: AnyRouter<SecondViewRoute>) {
        self.router = router
    }
    
    func trigger(route: SecondViewRoute) {
        router.trigger(navigation: .push(route))
    }
}
