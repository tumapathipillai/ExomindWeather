import SwiftUI

struct TimerView: View {
    let ratio: CGFloat
    let retry: () -> Void

    var body: some View {
        if ratio < 1.0 {
            GeometryReader { geo in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: geo.size.width * ratio)
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geo.size.width * (1 - ratio))
                }
            }
            .frame(height: 10)
        } else {
            RoundedLabelButton(label: LocalizeKeys.restart.localizedString,
                               action: retry)
        }
    }
}

#Preview {
    TimerView(ratio: 0.5) {}
}
