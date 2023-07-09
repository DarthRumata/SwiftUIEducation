//
//  NavigationService.swift
//  SwiftUIEducation
//
//  Created by Stas Kirichok on 12.05.2023.
//

import Combine
import SwiftUI

protocol Route: Hashable {}

enum Navigation<RouteType: Route> {
    case push(RouteType)
    case pop
    case popToRoot
    
    func eraseToAnyNavigation() -> AnyNavigation {
        let anyNavigation: AnyNavigation
        switch self {
        case .push(let route):
            anyNavigation = .push(route)
        case .pop:
            anyNavigation = .pop
        case .popToRoot:
            anyNavigation = .popToRoot
        }
        
        return anyNavigation
    }
}

enum AnyNavigation {
    case push(any Route)
    case pop
    case popToRoot
}

protocol PathBinder {
    var path: NavigationPath { get }
    var pathPublisher: Published<NavigationPath>.Publisher { get }
    
    func setPath(_ path: NavigationPath)
}

protocol RouterProtocol: ObservableObject {
    func trigger(navigation: AnyNavigation)
}

class Router: RouterProtocol, PathBinder {
    var path: NavigationPath {
        _path
    }
    var pathPublisher: Published<NavigationPath>.Publisher {
        $_path
    }
    
    @Published private var _path = NavigationPath()
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        $_path
            .sink(receiveValue: { path in
                print(path.count)
            })
            .store(in: &cancelables)
    }
    
    func setPath(_ path: NavigationPath) {
        _path = path
    }
    
    func trigger(navigation: AnyNavigation) {
        switch navigation {
        case .push(let route):
            print("route added: \(String(describing: route))")
            _path.append(route)
            
        case .pop:
            _path.removeLast()
            
        case .popToRoot:
            _path.removeLast(_path.count)
        }
    }
    
    func mapToRouter<RouteType: Route>() -> AnyRouter<RouteType> {
        return AnyRouter<RouteType> { [weak self] navigation in
            let anyNavigation: AnyNavigation = navigation.eraseToAnyNavigation()
            self?.trigger(navigation: anyNavigation)
        }
    }
}

struct NavigationStackCoordinator<Content: View, RouteType: Route>: View {
    private let router = Router()
    let content: (AnyRouter<RouteType>) -> Content
    let destinations: (RouteType) -> any View
    
    private var path: Binding<NavigationPath> {
        Binding(
            get: {
                router.path
            },
            set: { value in
                print(value)
                router.setPath(value)
            }
        )
    }
    
    var body: some View {
        NavigationStack(path: path) {
            content(router.mapToRouter())
                .navigationDestination(for: RouteType.self) { [destinations] route in
                    let _ = print("stack route: \(route)")
                    AnyView(destinations(route).environmentObject(router)
                    )
                }
        }
    }
    
    init(content: @escaping (AnyRouter<RouteType>) -> Content, destinations: @escaping (RouteType) -> any View) {
        self.content = content
        self.destinations = destinations
        
        print("refresh stack")
    }
}

struct ViewCoordinator<Content: View, RouteType: Route>: View {
    let content: () -> Content
    let destinations: (RouteType) -> any View
    
    var body: some View {
        content()
            .navigationDestination(for: RouteType.self) { [destinations] route in
                AnyView(destinations(route))
            }
    }
}

struct AnyRouter<RouteType: Route> {
    private let triggerHandler: (Navigation<RouteType>) -> Void
    
    init(triggerHandler: @escaping (Navigation<RouteType>) -> Void) {
        self.triggerHandler = triggerHandler
    }
    
    func trigger(navigation: Navigation<RouteType>) {
        triggerHandler(navigation)
    }
}


