import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Text(LocalizeKeys.welcome.localizedString)
                .font(.title)
                .foregroundStyle(.primaryLabel)
                .multilineTextAlignment(.center)
            Spacer()
            RoundedLabelNavigationLink(label: LocalizeKeys.welcomeButton.localizedString) {
                WeatherView()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .background(Color.background)
    }
}
