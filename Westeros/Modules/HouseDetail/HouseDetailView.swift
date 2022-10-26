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
