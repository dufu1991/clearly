import SwiftUI

@main
struct ClearlyApp: App {
    @AppStorage("themePreference") private var themePreference = "system"

    var body: some Scene {
        DocumentGroup(newDocument: MarkdownDocument()) { file in
            ContentView(document: file.$document)
        }
        .windowToolbarStyle(.unified(showsTitle: true))
        .defaultSize(width: 720, height: 900)
        .commands {
            CommandGroup(after: .textEditing) {
                ViewModeCommands()
            }
            CommandMenu("Format") {
                Button("Bold") {
                    NSApp.sendAction(#selector(ClearlyTextView.toggleBold(_:)), to: nil, from: nil)
                }
                .keyboardShortcut("b", modifiers: .command)

                Button("Italic") {
                    NSApp.sendAction(#selector(ClearlyTextView.toggleItalic(_:)), to: nil, from: nil)
                }
                .keyboardShortcut("i", modifiers: .command)

                Button("Heading") {
                    NSApp.sendAction(#selector(ClearlyTextView.insertHeading(_:)), to: nil, from: nil)
                }
                .keyboardShortcut("h", modifiers: [.command, .shift])

                Divider()

                Button("Link...") {
                    NSApp.sendAction(#selector(ClearlyTextView.insertLink(_:)), to: nil, from: nil)
                }
                .keyboardShortcut("k", modifiers: .command)
            }
        }

        Settings {
            SettingsView()
        }
    }
}

struct ViewModeCommands: View {
    @FocusedValue(\.viewMode) var mode

    var body: some View {
        Button("Editor") {
            mode?.wrappedValue = .edit
        }
        .keyboardShortcut("1", modifiers: .command)

        Button("Preview") {
            mode?.wrappedValue = .preview
        }
        .keyboardShortcut("2", modifiers: .command)
    }
}
