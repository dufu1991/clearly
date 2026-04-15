<p align="center">
  <img src="../website/icon.png" width="128" height="128" alt="Clearly icon" />
</p>

<h1 align="center">Clearly</h1>

<p align="center">Editor Markdown e base di conoscenza per Mac.</p>

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
  <a href="https://github.com/Shpigford/clearly/releases/latest/download/Clearly.dmg">Download diretto</a> &middot;
  <a href="https://clearly.md">Sito web</a> &middot;
  <a href="https://x.com/Shpigford">@Shpigford</a>
</p>

<p align="center">
  <img src="../website/screenshots/screenshot-1.jpg" width="720" alt="Clearly — editor con barra laterale e struttura del documento" />
</p>

Scrivi con evidenziazione della sintassi, collega le idee con wiki links, cerca ovunque e goditi un’anteprima curata. Nativo per macOS, senza Electron e senza abbonamenti.

## Funzionalità

### Scrittura

- **Evidenziazione della sintassi** — titoli, grassetto, corsivo, link, blocchi di codice e tabelle evidenziati mentre scrivi
- **Scorciatoie di formattazione** — ⌘B grassetto, ⌘I corsivo, ⌘K link
- **Markdown esteso** — `==evidenziazioni==`, `^apice^`, `~pedice~`, scorciatoie `:emoji:` e `[TOC]`
- **Scratchpad** — taccuino da barra dei menu con scorciatoia globale

### Conoscenza

- **Wiki links** — collega documenti con `[[wiki-links]]`, digita `[[` per l’autocompletamento
- **Backlinks** — menzioni collegate e non collegate con collegamento in un clic
- **Tags** — organizza con `#tags` e sfogliali dalla barra laterale
- **Ricerca globale** — ricerca full text su tutti i documenti, ordinata per rilevanza
- **Struttura del documento** — struttura dei titoli navigabile con salto immediato
- **Esplora file** — sfoglia cartelle, salva posizioni, crea e rinomina file

### Anteprima

- **Rendering GFM** — tabelle, task list, note a piè di pagina e barrato
- **Matematica KaTeX** — equazioni inline e a blocchi
- **Diagrammi Mermaid** — flowchart e sequence diagram dai blocchi di codice
- **Blocchi di codice** — 27+ linguaggi, numeri di riga, evidenziazione diff e copia in un clic
- **Callouts** — NOTE, TIP, WARNING e oltre 15 tipi comprimibili
- **Interattivo** — attiva checkbox, ingrandisci immagini, passa sulle note e torna al sorgente con doppio clic

### Integrazione

- **Server AI / MCP** — il server MCP integrato espone il tuo vault agli agenti AI per ricerca e recupero
- **QuickLook** — anteprima dei file `.md` nel Finder con Spazio
- **Esportazione PDF** — esporta o stampa con gestione corretta delle interruzioni di pagina
- **Formati di copia** — Markdown, HTML o testo ricco

## Schermate

<p>
  <img src="../website/screenshots/screenshot-2-alt.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-3.jpg" width="360" alt="" />
</p>
<p>
  <img src="../website/screenshots/screenshot-4.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-5-alt.jpg" width="360" alt="" />
</p>

## Prerequisiti

- **macOS 14**（Sonoma）o successivo
- **Xcode** con strumenti da riga di comando（`xcode-select --install`）
- **Homebrew**（[brew.sh](https://brew.sh)）
- **xcodegen** — `brew install xcodegen`

Sparkle（aggiornamenti automatici）e cmark-gfm（rendering Markdown）vengono scaricati automaticamente da Xcode tramite Swift Package Manager. Non è necessaria alcuna configurazione manuale.

## Avvio rapido

```bash
git clone https://github.com/Shpigford/clearly.git
cd clearly
brew install xcodegen    # salta se già installato
xcodegen generate        # genera Clearly.xcodeproj da project.yml
open Clearly.xcodeproj   # apre il progetto in Xcode
```

Poi premi **⌘R** per compilare ed eseguire.

> **Nota:** Il progetto Xcode viene generato da `project.yml`. Se modifichi `project.yml`, esegui di nuovo `xcodegen generate`. Non modificare direttamente `.xcodeproj`.

### Build CLI（senza interfaccia grafica di Xcode）

```bash
xcodebuild -scheme Clearly -configuration Debug build
```

## Struttura del progetto

```
Clearly/
├── ClearlyApp.swift                # entry point @main — DocumentGroup e comandi di menu（⌘1 / ⌘2）
├── MarkdownDocument.swift          # conformità FileDocument per leggere e scrivere file .md
├── ContentView.swift               # barra degli strumenti del selettore di modalità, passa tra Editor ↔ Preview
├── EditorView.swift                # NSViewRepresentable che avvolge NSTextView
├── MarkdownSyntaxHighlighter.swift # evidenziazione basata su regex tramite NSTextStorageDelegate
├── PreviewView.swift               # NSViewRepresentable che avvolge WKWebView
├── Theme.swift                     # colori centralizzati（chiaro / scuro）e costanti tipografiche
└── Info.plist                      # tipi di file supportati e configurazione Sparkle

ClearlyQuickLook/
├── PreviewViewController.swift     # QLPreviewProvider per l’anteprima nel Finder
└── Info.plist                      # configurazione dell’estensione（NSExtensionAttributes）

Shared/
├── MarkdownRenderer.swift          # wrapper cmark-gfm — GFM → HTML e pipeline di post elaborazione
├── PreviewCSS.swift                # CSS condiviso tra anteprima nell’app e QuickLook
├── EmojiShortcodes.swift           # tabella di ricerca :shortcode: → emoji Unicode
├── SyntaxHighlightSupport.swift    # iniezione di Highlight.js per la colorazione dei blocchi di codice
└── Resources/                      # JS / CSS inclusi（Mermaid、KaTeX、Highlight.js、demo.md）

website/                 # sito marketing statico（HTML / CSS）distribuito su clearly.md
scripts/                 # pipeline di rilascio（release.sh）
project.yml              # configurazione xcodegen — fonte unica di verità per le impostazioni del progetto Xcode
ExportOptions.plist      # configurazione di esportazione Developer ID per le build di rilascio
```

## Architettura

App documentale basata su **SwiftUI + AppKit** con due modalità principali.

### Ciclo di vita dell’app

1. `ClearlyApp` crea un `DocumentGroup` con `MarkdownDocument` per gestire l’I / O dei file `.md`
2. `ContentView` renderizza un selettore di modalità nella barra degli strumenti e passa tra `EditorView` e `PreviewView`
3. I comandi di menu（⌘1 Editor, ⌘2 Preview）usano `FocusedValueKey` per comunicare lungo la catena dei responder

### Editor

L’editor avvolge `NSTextView` di AppKit tramite `NSViewRepresentable` — **non** `TextEditor` di SwiftUI. È una scelta intenzionale: fornisce undo / redo nativi, il pannello di ricerca di sistema（⌘F）e l’evidenziazione della sintassi basata su `NSTextStorageDelegate`, eseguita a ogni battitura.

`MarkdownSyntaxHighlighter` applica pattern regex per titoli, grassetto, corsivo, blocchi di codice, link, blockquote e liste. I blocchi di codice vengono abbinati per primi per evitare evidenziazioni interne.

### Anteprima

`PreviewView` avvolge `WKWebView` e renderizza l’anteprima HTML completa usando `MarkdownRenderer`（cmark-gfm）stilizzato con `PreviewCSS`.

### Decisioni di progettazione chiave

- **Ponte AppKit** — `NSTextView` invece di `TextEditor` per undo, ricerca ed evidenziazione della sintassi tramite `NSTextStorageDelegate`
- **Tema dinamico** — tutti i colori passano da `Theme.swift` con `NSColor(name:)` per la risoluzione automatica chiaro / scuro. Non codificare i colori in modo fisso.
- **Codice condiviso** — `MarkdownRenderer` e `PreviewCSS` vengono compilati sia nell’app principale sia nell’estensione QuickLook
- **Nessuna suite di test** — convalida le modifiche manualmente compilando, eseguendo e osservando

## Attività di sviluppo comuni

### Aggiungere un tipo di file supportato

Modifica `Clearly/Info.plist` e aggiungi una nuova voce sotto `CFBundleDocumentTypes` con UTI ed estensione del file.

### Cambiare l’evidenziazione della sintassi

Modifica `Clearly/MarkdownSyntaxHighlighter.swift`. I pattern vengono applicati in ordine: prima i blocchi di codice, poi tutto il resto. Aggiungi nuovi pattern regex al metodo `highlightAllMarkdown()`.

### Modificare lo stile dell’anteprima

Modifica `Shared/PreviewCSS.swift`. Questo CSS è usato sia dall’anteprima nell’app sia dall’estensione QuickLook. Mantienilo sincronizzato con i colori di `Theme.swift`.

### Aggiornare i colori del tema

Modifica `Clearly/Theme.swift`. Tutti i colori usano `NSColor(name:)` con provider dinamici chiaro / scuro. Aggiorna anche il CSS corrispondente in `PreviewCSS.swift`.

## Test

Non esiste una suite di test automatizzata. Verifica manualmente:

1. Compila ed esegui l’app（⌘R）
2. Apri un file `.md` e verifica l’evidenziazione della sintassi
3. Passa alla modalità anteprima（⌘2）e verifica il risultato renderizzato
4. Prova wiki links, backlinks, ricerca e tags
5. Prova QuickLook selezionando un file `.md` nel Finder e premendo Spazio
6. Controlla sia la modalità chiara sia quella scura

## Configurazione di AI Agent

Questo repository include un file `CLAUDE.md` con il contesto architetturale e skill di Claude Code in `.claude/skills/` per l’automazione dei rilasci e l’onboarding di sviluppo.

## Licenza

FSL-1.1-MIT — vedi [LICENSE](../LICENSE). Il codice diventa MIT dopo due anni.
