//
//  ActivityIndicator.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import Foundation
import SwiftUI

struct ConfigurableActivityIndicator: UIViewRepresentable {
    typealias UIView = UIActivityIndicatorView

    var color: UIColor

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIActivityIndicatorView {
        UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        uiView.color = color
        uiView.startAnimating()
    }
}

struct ActivityIndicator: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ConfigurableActivityIndicator(color: colorScheme == .dark ? .white : .black)
    }
}
