//
//  SearchView.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import SwiftUI

struct SearchView: View {
    var label: String = "Search for name, title, region etc"
    @Binding var searchText: String
    @State var focused: Bool = false
    var onEditingChanged: (Bool) -> Void = { _ in }

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 8)
                .foregroundColor(.gray)

            TextField(label,
                      text: $searchText,
                      onEditingChanged: { edit in
                focused = edit
                onEditingChanged(edit)
            })
            .foregroundColor(.black)
            .frame(height: 35)
            .disableAutocorrection(true)

            if searchText != "" {
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .padding(.trailing, 8)
                }
            }
        }
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 3))
        .foregroundColor(.black.opacity(0.5))
        .background(Color.white)
        .cornerRadius(10.0)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(focused ? Color.black : .gray, lineWidth: 1)
        )
        .padding(.bottom, 8)
    }
}
