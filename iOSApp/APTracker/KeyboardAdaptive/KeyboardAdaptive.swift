//
//  KeyboardAdaptive.swift
//  APTracker
//
//  Created by Matteo Visotto on 05/04/22.
//

import Foundation
import SwiftUI
import Combine

/// Note that the `KeyboardAdaptive` modifier wraps your view in a `GeometryReader`,
/// which attempts to fill all the available space, potentially increasing content view size.
struct KeyboardAdaptive: ViewModifier {
    @State private var bottomPadding: CGFloat = 0

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.bottomPadding)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    let keyboardTop = geometry.frame(in: .global).height - keyboardHeight + geometry.safeAreaInsets.bottom
                    let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                    self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom)
            }
            .animation(.easeOut(duration: 0.16))
        }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}