# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Clearly is a native macOS markdown editor built with SwiftUI. It's a document-based app (`DocumentGroup`) that opens/saves `.md` files, with two modes: a syntax-highlighted editor and a WKWebView-based preview. It also ships a QuickLook extension for previewing markdown files in Finder.

## Build & Run

The Xcode project is generated from `project.yml` using [XcodeGen](https://github.com/yonaskolb/XcodeGen):

```bash
xcodegen generate        # Regenerate .xcodeproj from project.yml
xcodebuild -scheme Clearly -configuration Debug build   # Build from CLI
```

Open in Xcode: `open Clearly.xcodeproj` (gitignored, so regenerate with xcodegen first).

- Deployment target: macOS 14.0
- Swift 5.9, Xcode 16+
- Single external dependency: `cmark-gfm` (GFM markdown → HTML via Swift Package Manager)

## Architecture

**Two targets** defined in `project.yml`:

1. **Clearly** (main app) — document-based SwiftUI app
2. **ClearlyQuickLook** (app extension) — QLPreviewProvider for Finder previews

**Shared code** lives in `Shared/` and is compiled into both targets:
- `MarkdownRenderer.swift` — wraps `cmark_gfm_markdown_to_html()` for GFM rendering (tables, strikethrough, task lists, autolinks)
- `PreviewCSS.swift` — CSS string used by both the in-app preview and the QuickLook extension

**App code** in `Clearly/`:
- `ClearlyApp.swift` — App entry point. `DocumentGroup` with `MarkdownDocument`, menu commands for switching view modes (⌘1 Editor, ⌘2 Preview)
- `MarkdownDocument.swift` — `FileDocument` conformance for reading/writing markdown files
- `ContentView.swift` — Hosts the mode picker toolbar and switches between `EditorView` and `PreviewView`. Defines `ViewMode` enum and `FocusedValueKey` for menu commands
- `EditorView.swift` — `NSViewRepresentable` wrapping `NSTextView` with undo, find panel, and live syntax highlighting via `NSTextStorageDelegate`
- `MarkdownSyntaxHighlighter.swift` — Regex-based syntax highlighter applied to `NSTextStorage`. Handles headings, bold, italic, code blocks, links, blockquotes, lists, etc. Code blocks are matched first to prevent inner highlighting
- `PreviewView.swift` — `NSViewRepresentable` wrapping `WKWebView` that renders the full HTML preview
- `Theme.swift` — Centralized colors (dynamic light/dark via `NSColor(name:)`) and font/spacing constants

**Key pattern**: The editor uses AppKit (`NSTextView`) bridged to SwiftUI via `NSViewRepresentable`, not SwiftUI's `TextEditor`. This is intentional — it provides undo support, find panel, and `NSTextStorageDelegate`-based syntax highlighting.

## Conventions

- All colors go through `Theme` with dynamic light/dark resolution — don't hardcode colors
- Preview CSS in `PreviewCSS.swift` must stay in sync with `Theme` colors for visual consistency between editor and preview modes
- Changes to `project.yml` require running `xcodegen generate` to update the Xcode project
