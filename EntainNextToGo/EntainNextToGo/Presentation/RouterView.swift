//
//  RouterView.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import SwiftUI

/// The RouterView is a warpper for the view to manage the navigation and view heirarchy and loosly couple views from each other.
struct RouterView<Content: View>: View {

    /// Observes updates to the route.
    @ObservedObject var router: Router
    /// The View Content.
    private let content: Content

    init(router: Router, @ViewBuilder content: @escaping () -> Content) {
        self.router = router
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Router.Route.self) { route in
                    router.view(for: route)
                }
        }
        .environmentObject(router)
    }
    
}
