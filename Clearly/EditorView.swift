import SwiftUI
import AppKit

struct EditorView: NSViewRepresentable {
    @Binding var text: String
    @Environment(\.colorScheme) private var colorScheme

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.drawsBackground = false
        scrollView.autohidesScrollers = true

        let textView = ClearlyTextView()
        textView.isRichText = false
        textView.allowsUndo = true
        textView.usesFindPanel = true
        textView.isAutomaticQuoteSubstitutionEnabled = false
        textView.isAutomaticDashSubstitutionEnabled = false
        textView.isAutomaticTextReplacementEnabled = false
        textView.isAutomaticSpellingCorrectionEnabled = false

        // Font
        textView.font = Theme.editorFont
        textView.textColor = Theme.textColor
        textView.backgroundColor = Theme.backgroundColor

        // Paragraph style with line height
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = Theme.lineSpacing
        textView.defaultParagraphStyle = paragraph
        textView.typingAttributes = [
            .font: Theme.editorFont,
            .foregroundColor: Theme.textColor,
            .paragraphStyle: paragraph
        ]

        // Insets
        textView.textContainerInset = NSSize(width: Theme.editorInsetX, height: Theme.editorInsetTop)
        textView.textContainer?.lineFragmentPadding = 0

        // Layout
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.autoresizingMask = [.width]
        textView.textContainer?.widthTracksTextView = true

        // Insertion point color
        textView.insertionPointColor = Theme.textColor

        // Delegate
        textView.delegate = context.coordinator

        // Syntax highlighter on text storage
        let highlighter = MarkdownSyntaxHighlighter()
        textView.textStorage?.delegate = highlighter
        context.coordinator.highlighter = highlighter

        // Set initial text
        textView.string = text
        highlighter.highlightAll(textView.textStorage!)

        scrollView.documentView = textView
        context.coordinator.textView = textView

        return scrollView
    }

    func updateNSView(_ scrollView: NSScrollView, context: Context) {
        guard let textView = scrollView.documentView as? NSTextView else { return }

        // Always refresh colors (handles appearance changes via @Environment colorScheme)
        textView.backgroundColor = Theme.backgroundColor
        textView.insertionPointColor = Theme.textColor

        // Update typing attributes for new text
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = Theme.lineSpacing
        textView.typingAttributes = [
            .font: Theme.editorFont,
            .foregroundColor: Theme.textColor,
            .paragraphStyle: paragraph
        ]

        // Re-highlight to pick up new colors
        context.coordinator.highlighter?.highlightAll(textView.textStorage!)

        // Only update text if it changed externally (not from user typing)
        if !context.coordinator.isUpdating && textView.string != text {
            let selectedRanges = textView.selectedRanges
            textView.string = text
            textView.selectedRanges = selectedRanges
            context.coordinator.highlighter?.highlightAll(textView.textStorage!)
        }
    }

    // MARK: - Coordinator

    final class Coordinator: NSObject, NSTextViewDelegate {
        let parent: EditorView
        var isUpdating = false
        var highlighter: MarkdownSyntaxHighlighter?
        weak var textView: NSTextView?

        init(_ parent: EditorView) {
            self.parent = parent
        }

        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            isUpdating = true
            parent.text = textView.string
            isUpdating = false
        }
    }
}
