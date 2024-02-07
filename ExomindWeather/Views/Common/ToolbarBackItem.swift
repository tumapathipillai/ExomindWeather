import SwiftUI

extension View {
    func toolbarBackItem(title: String, back: @escaping () -> Void) -> some View {
        return self
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackItem(title: title, back: back)
                }
            }
    }
}

fileprivate struct BackItem: View {
    let title: String
    let back: () -> Void

    public var body: some View {
        HStack {
            Button {
                back()
            } label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.primaryLabel)
                    .frame(width: 24, height: 24)
            }
            Text(title)
                .foregroundStyle(.primaryLabel)
            Spacer()
        }
    }
}
