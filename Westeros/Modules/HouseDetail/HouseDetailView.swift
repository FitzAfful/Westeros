//
//  HouseDetailView.swift
//  Westeros
//
//  Created by Fitzgerald Afful on 26/10/2022.
//

import SwiftUI

struct HouseDetailView: View {
    @ObservedObject var viewModel: HouseViewModel

    var body: some View {
        VStack {
            if let name = viewModel.name, let words = viewModel.words {
                HouseTitleRow(title: name, words: words)
            }

            ZStack{
                GeometryReader { geometry in
                    Image("houseBackground")
                        .scaledToFill()

                    ScrollView (.vertical, showsIndicators: false) {
                        Group {

                            if let region = viewModel.region {
                                HouseDetailRow(key: "Region", value: region)
                            }

                            if let coatOfArms = viewModel.coatOfArms {
                                HouseDetailRow(key: "Coat of Arms", value: coatOfArms)
                            }
                        }

                        Group {

                            if !viewModel.titles.isEmpty {
                                HouseDetailRow(key: "Titles", value: "• " + viewModel.titles.joined(separator: "\n• "))
                            }

                            if let currentLord = viewModel.currentLord, !currentLord.isEmpty {
                                HouseDetailRow(key: "Current Lord", value: currentLord)
                            }

                            if !viewModel.seats.isEmpty {
                                HouseDetailRow(key: "Seats", value: "• " + viewModel.seats.joined(separator: "\n• "))
                            }

                            if let heir = viewModel.heir, !heir.isEmpty {
                                HouseDetailRow(key: "Heir", value: heir)
                            }
                        }

                        Group {
                            if let overlord = viewModel.overlord, !overlord.isEmpty {
                                HouseDetailRow(key: "Overlord", value: overlord)
                            }

                            if let founded = viewModel.founded, !founded.isEmpty {
                                HouseDetailRow(key: "Founded", value: founded)
                            }

                            if let diedOut = viewModel.diedOut, !diedOut.isEmpty {
                                HouseDetailRow(key: "Died Out", value: diedOut)
                            }
                        }

                        Group {

                            if !viewModel.ancestralWeapons.isEmpty {
                                HouseDetailRow(key: "Ancestral Weapons", value: "• " + viewModel.ancestralWeapons.joined(separator: "\n• "))
                            }

                            if !viewModel.cadetBranches.isEmpty {
                                HouseDetailRow(key: "Cadet Branches", value: "• " + viewModel.cadetBranches.joined(separator: "\n• "))
                            }

                            if !viewModel.swornMembers.isEmpty {
                                HouseDetailRow(key: "Sworn Members", value: "• " + viewModel.swornMembers.joined(separator: "\n• "))
                            }

                            Spacer()
                                .frame(height: 100)
                        }

                    }
                    .frame(height: geometry.size.height)
                    .padding()
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct HouseTitleRow: View {
    var title: String
    var words: String

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .defaultGOTFont(color: .darkBlue, size: 30)
                .multilineTextAlignment(.center)

            if words.isEmpty {
                Text(words)
                    .font(.body.smallCaps())
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}

struct HouseDetailRow: View {
    var key: String
    var value: String

    var body: some View {
        VStack(spacing: 0) {
            Text(key)
                .defaultGOTFont(color: .gray, size: 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)

            HStack {
                Text(value)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
        }
        .whiteRectangleBackground()
    }
}

struct WhiteRoundedRectangleBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
            )
            .padding(.bottom, 8)
    }
}

extension View {
    func whiteRectangleBackground() -> some View {
        modifier(WhiteRoundedRectangleBackground())
    }
}
