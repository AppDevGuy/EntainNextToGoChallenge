//
//  TextModifiers.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 27/2/2024.
//

import SwiftUI

struct LargeTitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Fonts.Title.large.font)
            .foregroundColor(Colors.Foreground.primary)
            .multilineTextAlignment(.leading)
    }
}

struct HeadlineTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Fonts.Title.medium.font)
            .foregroundColor(Colors.Foreground.primary)
            .multilineTextAlignment(.leading)
    }
}

struct SubHeadlineTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Fonts.Title.small.font)
            .foregroundColor(Colors.Foreground.primary)
            .multilineTextAlignment(.leading)
    }
}

struct SubtitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Fonts.Body.regular.font)
            .fontWeight(.semibold)
            .foregroundColor(Colors.Foreground.primary)
            .multilineTextAlignment(.leading)
    }
}

struct BodyTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Fonts.Body.regular.font)
            .foregroundColor(Colors.Foreground.primary)
            .multilineTextAlignment(.leading)
    }
}

struct BodyBoldTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Fonts.Body.bold.font)
            .foregroundColor(Colors.Foreground.primary)
            .multilineTextAlignment(.leading)
    }
}

struct PrimaryButtonTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Fonts.Body.button.font)
            .foregroundColor(Colors.Button.foreground)
            .multilineTextAlignment(.leading)
    }
}

struct CaptionTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Fonts.Body.caption.font)
            .foregroundColor(Colors.Foreground.secondary)
            .multilineTextAlignment(.leading)
    }
}

extension View {

    func titleStyle() -> some View {
        self.modifier(LargeTitleTextStyle())
    }

    func headlineStyle() -> some View {
        self.modifier(HeadlineTextStyle())
    }

    func subheadlineStyle() -> some View {
        self.modifier(SubHeadlineTextStyle())
    }

    func subtitleStyle() -> some View {
        self.modifier(SubtitleTextStyle())
    }

    func bodyStyle() -> some View {
        self.modifier(BodyTextStyle())
    }

    func boldBodyStyle() -> some View {
        self.modifier(BodyBoldTextStyle())
    }

    func buttonStyle() -> some View {
        self.modifier(PrimaryButtonTextStyle())
    }

    func captionStyle() -> some View {
        self.modifier(CaptionTextStyle())
    }
}
