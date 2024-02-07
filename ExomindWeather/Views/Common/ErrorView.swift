import SwiftUI

struct ErrorView: View {
    let error: Error
    let retry: (() -> Void)?

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text(LocalizeKeys.error.localizedString)
                .foregroundStyle(.primaryLabel)
                .multilineTextAlignment(.center)
                .font(.title)
            Text(error.localizedDescription)
                .foregroundStyle(.primaryLabel)
                .multilineTextAlignment(.center)
                .font(.callout)
            Spacer()
            if let retry {
                RoundedLabelButton(label: LocalizeKeys.retry.localizedString,
                                   action: retry)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .background(Color.background)
    }
}

#Preview {
    ErrorView(error: NSError(domain: "TestError", code: 0)) {}
}
