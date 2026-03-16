import SwiftUI

struct SettingsView: View {
    @AppStorage("editorFontSize") private var fontSize: Double = 16
    @AppStorage("themePreference") private var themePreference = "system"

    var body: some View {
        Form {
            Picker("Appearance", selection: $themePreference) {
                Text("System").tag("system")
                Text("Light").tag("light")
                Text("Dark").tag("dark")
            }
            HStack {
                Text("Font Size")
                Slider(value: $fontSize, in: 12...24, step: 1)
                Text("\(Int(fontSize))")
                    .monospacedDigit()
                    .frame(width: 24, alignment: .trailing)
            }
        }
        .formStyle(.grouped)
        .frame(width: 360)
    }
}
