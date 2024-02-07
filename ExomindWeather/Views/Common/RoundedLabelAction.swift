import SwiftUI

fileprivate struct RoundedLabel: View {
    let label: String

    var body: some View {
        Text(label)
            .bold()
            .font(.title2)
            .lineLimit(1)
            .foregroundStyle(.primaryLabel)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(.action)
            .clipShape(.capsule)
    }
}

struct RoundedLabelButton: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            RoundedLabel(label: label)
        }
    }
}

struct RoundedLabelNavigationLink<Destination: View>: View {
    let label: String
    let destination: () -> Destination

    var body: some View {
        NavigationLink {
            destination()
        } label: {
            RoundedLabel(label: label)
        }

    }
}
