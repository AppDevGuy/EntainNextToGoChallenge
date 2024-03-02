//
//  RouterView.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import SwiftUI

struct RouterView<Content: View>: View {

    @ObservedObject var router: Router
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
