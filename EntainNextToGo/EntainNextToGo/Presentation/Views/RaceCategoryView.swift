//
//  RaceCategoryView.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import SwiftUI

/// Race Category View is used to display the available filters to the user in the active and inactive states.
struct RaceCategoryView: View {

    private var viewModel: RaceCategoryViewModel

    init(viewModel: RaceCategoryViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("You can filter races by tapping on the icons below.")
                .bodyStyle()
            HStack {
                Spacer()
                ForEach(viewModel.categories, id: \.self) { category in
                    VStack(alignment: .center, spacing: Sizes.Space.regular) {
                        HStack(alignment: .center) {
                            Spacer()
                            Image(systemName: category.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: Sizes.Icon.large)
                                .foregroundStyle(viewModel.activeCategories.contains(category) ? Colors.Brand.primary : Colors.Foreground.secondary)
                            Spacer()
                        }
                        HStack(alignment: .top) {
                            Spacer()
                            Text(category.categoryName)
                                .multilineTextAlignment(.center)
                                .captionStyle()
                            Spacer()
                        }
                    }
                    .onTapGesture {
                        viewModel.didTap(raceCategory: category)
                    }
                    .accessibilityLabel(Text("Tap to set the \(category.categoryName) filter \(viewModel.activeCategories.contains(category) ? "active" : "inactive")"))
                }
            }
            .padding(Sizes.Space.large)
            Spacer()
        }
        .padding(Sizes.Space.large)
        .navigationTitle("Race Category Filters")
    }
}

#Preview {
    RaceCategoryView(viewModel: RaceCategoryViewModel(activeCategories: Binding.constant([.greyhound, .harness])))
}
