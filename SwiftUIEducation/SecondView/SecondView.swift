//
//  ButtonView.swift
//  SwiftUIEducation
//
//  Created by Stas Kirichok on 10.05.2023.
//

import SwiftUI

struct SecondView: View {
    var viewModel: SecondViewModel
    
    var body: some View {
        let _ = print
        VStack {
            Image(systemName: "2.lane")
                .resizable()
                .frame(width: 100, height: 100)
            NavigationLink(value: SecondViewRoute.details("Opened from SecondView")) {
                Label("Go to Details", systemImage: "info.square")
            }
        }
        .navigationTitle("Second screen")
    }
}


//VStack {
//    NavigationLink(value: "details") {
//        EmptyView()
//    }
//    .navigationDestination(for: SecondViewRoute.self) { value in
//        DetailsView()
//    }
//    Button("Tap to show detail") {
//        viewModel.trigger(route: .details)
//    }
//}



struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SecondView(viewModel: SecondViewModel(router: Router().mapToRouter()))
        }
    }
}
