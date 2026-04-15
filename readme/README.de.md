<p align="center">
  <img src="../website/icon.png" width="128" height="128" alt="Clearly icon" />
</p>

<h1 align="center">Clearly</h1>

<p align="center">Markdown Editor und Wissensbasis für Mac.</p>

<p align="center">
  <a href="../README.md">English</a> ·
  <a href="./README.zh-Hans.md">简体中文</a> ·
  <a href="./README.zh-Hant.md">繁體中文</a> ·
  <a href="./README.ja.md">日本語</a> ·
  <a href="./README.ko.md">한국어</a> ·
  <a href="./README.es.md">Español</a> ·
  <a href="./README.ru.md">Русский</a> ·
  <a href="./README.fr.md">Français</a> ·
  <a href="./README.de.md">Deutsch</a> ·
  <a href="./README.it.md">Italiano</a>
</p>

<p align="center">
  <a href="https://apps.apple.com/app/clearly-markdown/id6760669470">Mac App Store</a> &middot;
  <a href="https://github.com/Shpigford/clearly/releases/latest/download/Clearly.dmg">Direkter Download</a> &middot;
  <a href="https://clearly.md">Website</a> &middot;
  <a href="https://x.com/Shpigford">@Shpigford</a>
</p>

<p align="center">
  <img src="../website/screenshots/screenshot-1.jpg" width="720" alt="Clearly — Editor mit Seitenleiste und Dokumentgliederung" />
</p>

Schreibe mit Syntaxhervorhebung, verknüpfe Gedanken mit Wiki Links, durchsuche alles und erhalte eine schöne Vorschau. Nativ für macOS, kein Electron, keine Abos.

## Funktionen

### Schreiben

- **Syntaxhervorhebung** — Überschriften, Fett, Kursiv, Links, Codeblöcke und Tabellen werden beim Tippen direkt hervorgehoben
- **Formatierungs Shortcuts** — ⌘B für Fett, ⌘I für Kursiv, ⌘K für Links
- **Erweitertes Markdown** — `==Hervorhebungen==`, `^Hochgestellt^`, `~Tiefgestellt~`, `:emoji:` Kurzbefehle und `[TOC]`
- **Scratchpad** — Menubar Notizzettel mit globalem Hotkey

### Wissen

- **Wiki Links** — Dokumente mit `[[wiki-links]]` verknüpfen, `[[` startet die Autovervollständigung
- **Backlinks** — verlinkte und unverlinkte Erwähnungen mit einem Klick verbinden
- **Tags** — Inhalte mit `#tags` organisieren und in der Seitenleiste durchsuchen
- **Globale Suche** — Volltextsuche über alle Dokumente, nach Relevanz sortiert
- **Dokumentgliederung** — navigierbare Überschriftenstruktur zum direkten Springen
- **Dateiexplorer** — Ordner durchsuchen, Orte merken, Dateien erstellen und umbenennen

### Vorschau

- **GFM Rendering** — Tabellen, Aufgabenlisten, Fußnoten und Durchstreichungen
- **KaTeX Mathematik** — Inline und Block Gleichungen
- **Mermaid Diagramme** — Flussdiagramme und Sequenzdiagramme aus Codeblöcken
- **Codeblöcke** — 27+ Sprachen, Zeilennummern, diff Hervorhebung und Kopieren mit einem Klick
- **Callouts** — NOTE, TIP, WARNING und 15+ einklappbare Typen
- **Interaktiv** — Checkboxen umschalten, Bilder zoomen, Fußnoten anzeigen, per Doppelklick zur Quelle springen

### Integration

- **AI / MCP Server** — integrierter MCP Server macht deinen Vault für AI Agents durchsuchbar
- **QuickLook** — `.md` Dateien im Finder mit Space vorschauen
- **PDF Export** — exportieren oder drucken, Seitenumbrüche inklusive
- **Kopierformate** — Markdown, HTML oder Rich Text

## Screenshots

<p>
  <img src="../website/screenshots/screenshot-2-alt.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-3.jpg" width="360" alt="" />
</p>
<p>
  <img src="../website/screenshots/screenshot-4.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-5-alt.jpg" width="360" alt="" />
</p>

## Voraussetzungen

- **macOS 14**（Sonoma）oder neuer
- **Xcode** mit Kommandozeilenwerkzeugen（`xcode-select --install`）
- **Homebrew**（[brew.sh](https://brew.sh)）
- **xcodegen** — `brew install xcodegen`

Sparkle（Auto Updates）und cmark-gfm（Markdown Rendering）werden von Xcode automatisch über Swift Package Manager geladen. Keine manuelle Einrichtung erforderlich.

## Schnellstart

```bash
git clone https://github.com/Shpigford/clearly.git
cd clearly
brew install xcodegen    # überspringen, wenn bereits installiert
xcodegen generate        # erzeugt Clearly.xcodeproj aus project.yml
open Clearly.xcodeproj   # öffnet das Projekt in Xcode
```

Drücke dann **⌘R**, um zu bauen und zu starten.

> **Hinweis:** Das Xcode Projekt wird aus `project.yml` generiert. Wenn du `project.yml` änderst, führe `xcodegen generate` erneut aus. Bearbeite die `.xcodeproj` Datei nicht direkt.

### CLI Build（ohne Xcode GUI）

```bash
xcodebuild -scheme Clearly -configuration Debug build
```

## Projektstruktur

```
Clearly/
├── ClearlyApp.swift                # @main Einstieg — DocumentGroup und Menübefehle（⌘1 / ⌘2）
├── MarkdownDocument.swift          # FileDocument Implementierung zum Lesen und Schreiben von .md Dateien
├── ContentView.swift               # Modusauswahl in der Symbolleiste, wechselt zwischen Editor ↔ Preview
├── EditorView.swift                # NSViewRepresentable, das NSTextView umschließt
├── MarkdownSyntaxHighlighter.swift # Regex basierte Hervorhebung über NSTextStorageDelegate
├── PreviewView.swift               # NSViewRepresentable, das WKWebView umschließt
├── Theme.swift                     # zentrale Farben（hell / dunkel）und Schriftkonstanten
└── Info.plist                      # unterstützte Dateitypen und Sparkle Konfiguration

ClearlyQuickLook/
├── PreviewViewController.swift     # QLPreviewProvider für Finder Vorschauen
└── Info.plist                      # Erweiterungskonfiguration（NSExtensionAttributes）

Shared/
├── MarkdownRenderer.swift          # cmark-gfm Wrapper — GFM → HTML und Post Processing Pipeline
├── PreviewCSS.swift                # CSS, das von App Vorschau und QuickLook gemeinsam genutzt wird
├── EmojiShortcodes.swift           # :shortcode: → Unicode emoji Nachschlagetabelle
├── SyntaxHighlightSupport.swift    # Highlight.js Injection für Syntaxfärbung in Codeblöcken
└── Resources/                      # gebündeltes JS / CSS（Mermaid、KaTeX、Highlight.js、demo.md）

website/                 # statische Marketing Website（HTML / CSS）, bereitgestellt auf clearly.md
scripts/                 # Release Pipeline（release.sh）
project.yml              # xcodegen Konfiguration — einzige Quelle der Wahrheit für Xcode Projekteinstellungen
ExportOptions.plist      # Developer ID Exportkonfiguration für Release Builds
```

## Architektur

Dokumentenbasierte App auf Basis von **SwiftUI + AppKit** mit zwei Kernmodi.

### App Lebenszyklus

1. `ClearlyApp` erstellt ein `DocumentGroup` mit `MarkdownDocument` für die `.md` Datei E / A
2. `ContentView` rendert einen Moduswähler in der Symbolleiste und wechselt zwischen `EditorView` und `PreviewView`
3. Menübefehle（⌘1 Editor, ⌘2 Preview）verwenden `FocusedValueKey`, um über die Responder Kette zu kommunizieren

### Editor

Der Editor kapselt AppKits `NSTextView` über `NSViewRepresentable` — **nicht** SwiftUIs `TextEditor`. Das ist beabsichtigt: Es liefert natives Undo / Redo, das System Suchpanel（⌘F）und `NSTextStorageDelegate` basierte Syntaxhervorhebung, die bei jedem Tastendruck läuft.

`MarkdownSyntaxHighlighter` wendet Regex Muster für Überschriften, Fett, Kursiv, Codeblöcke, Links, Blockzitate und Listen an. Codeblöcke werden zuerst abgeglichen, um innere Hervorhebung zu verhindern.

### Vorschau

`PreviewView` kapselt `WKWebView` und rendert die vollständige HTML Vorschau mit `MarkdownRenderer`（cmark-gfm）, gestylt durch `PreviewCSS`.

### Wichtige Designentscheidungen

- **AppKit Brücke** — `NSTextView` statt `TextEditor` für Undo, Suche und `NSTextStorageDelegate` Syntaxhervorhebung
- **Dynamisches Theming** — alle Farben laufen über `Theme.swift` mit `NSColor(name:)` zur automatischen Auflösung für hell / dunkel. Farben nicht hart kodieren.
- **Geteilter Code** — `MarkdownRenderer` und `PreviewCSS` werden sowohl in die Haupt App als auch in die QuickLook Erweiterung kompiliert
- **Keine Testsuite** — Änderungen werden manuell durch Bauen, Ausführen und Beobachten validiert

## Häufige Entwicklungsaufgaben

### Einen unterstützten Dateityp hinzufügen

Bearbeite `Clearly/Info.plist` und füge unter `CFBundleDocumentTypes` einen neuen Eintrag mit UTI und Dateiendung hinzu.

### Syntaxhervorhebung ändern

Bearbeite `Clearly/MarkdownSyntaxHighlighter.swift`. Muster werden der Reihe nach angewendet — zuerst Codeblöcke, dann alles andere. Füge neue Regex Muster zur Methode `highlightAllMarkdown()` hinzu.

### Vorschau Styling ändern

Bearbeite `Shared/PreviewCSS.swift`. Dieses CSS wird sowohl von der In App Vorschau als auch von der QuickLook Erweiterung verwendet. Halte es mit den Farben aus `Theme.swift` synchron.

### Theme Farben aktualisieren

Bearbeite `Clearly/Theme.swift`. Alle Farben verwenden `NSColor(name:)` mit dynamischen hell / dunkel Providern. Aktualisiere dazu passend auch das CSS in `PreviewCSS.swift`.

## Testen

Es gibt keine automatisierte Testsuite. Prüfe manuell:

1. Build und Run（⌘R）
2. Eine `.md` Datei öffnen und die Syntaxhervorhebung prüfen
3. In die Vorschau wechseln（⌘2）und das Rendering prüfen
4. Wiki Links, Backlinks, Suche und Tags testen
5. QuickLook testen: `.md` Datei im Finder auswählen und Space drücken
6. Hellen und dunklen Modus prüfen

## AI Agent Einrichtung

Dieses Repository enthält eine `CLAUDE.md` Datei mit Architekturkontext und Claude Code Skills in `.claude/skills/` für Release Automatisierung und Entwickler Onboarding.

## Lizenz

FSL-1.1-MIT — siehe [LICENSE](../LICENSE). Der Code wird nach zwei Jahren zu MIT.
