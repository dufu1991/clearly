import SwiftUI

enum ViewMode: String, CaseIterable {
    case edit
    case preview
}

struct ViewModeKey: FocusedValueKey {
    typealias Value = Binding<ViewMode>
}

extension FocusedValues {
    var viewMode: Binding<ViewMode>? {
        get { self[ViewModeKey.self] }
        set { self[ViewModeKey.self] = newValue }
    }
}

struct HiddenToolbarBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(macOS 15.0, *) {
            content.toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
        } else {
            content
        }
    }
}

struct ContentView: View {
    @Binding var document: MarkdownDocument
    @State private var mode: ViewMode = .edit
    @AppStorage("editorFontSize") private var fontSize: Double = 16

    private var wordCount: Int {
        document.text.split { $0.isWhitespace || $0.isNewline }.count
    }

    private var characterCount: Int {
        document.text.count
    }

    var body: some View {
        Group {
            switch mode {
            case .edit:
                EditorView(text: $document.text)
            case .preview:
                PreviewView(markdown: document.text)
            }
        }
        .frame(minWidth: 500, minHeight: 400)
        .background(Theme.backgroundColorSwiftUI)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if mode == .edit {
                HStack(spacing: 12) {
                    Text("\(wordCount) words")
                    Text("\(characterCount) characters")
                }
                .font(.caption)
                .foregroundStyle(.tertiary)
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(Theme.backgroundColorSwiftUI)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Mode", selection: $mode) {
                    Image(systemName: "pencil")
                        .tag(ViewMode.edit)
                    Image(systemName: "eye")
                        .tag(ViewMode.preview)
                }
                .pickerStyle(.segmented)
                .frame(width: 100)
            }
            ToolbarItem(placement: .automatic) {
                if mode == .edit {
                    Button {
                        NSApp.sendAction(#selector(ClearlyTextView.showFindPanel(_:)), to: nil, from: nil)
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .help("Find (Cmd+F)")
                }
            }
        }
        .modifier(HiddenToolbarBackground())
        .focusedSceneValue(\.viewMode, $mode)
    }
}
