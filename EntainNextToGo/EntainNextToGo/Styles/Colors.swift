//
//  NTGColors.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 27/2/2024.
//

import SwiftUI

struct Colors {

    enum Brand {
        static let primary = Color("PrimaryBrand")
        static let secondary = Color("SecondaryBrand")
    }

    enum Background {
        static let primary = Color("PrimaryBackground")
        static let secondary = Color("SecondaryBackground")
        static let tertiary = Color("TertiaryBackgroundColor")
    }

    enum Foreground {
        static let primary = Color("PrimaryForeground")
        static let secondary = Color("SecondaryForeground")
        static let placeholder = Color("PlaceholderForeground")
    }

    enum Shadow {
        static let primary = Color("PrimaryShadow")
    }

    enum Border {
        static let primary = Color("PrimaryBorder")
    }

    enum Button {
        static let foreground = Color("ButtonPrimaryForeground")
        static let background = Color("PrimaryBrand")
    }

    enum UtilityColors {
        static let extraLightGrey = Color("ExtraLightGrey")
    }
}

