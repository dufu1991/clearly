<p align="center">
  <img src="../website/icon.png" width="128" height="128" alt="Clearly icon" />
</p>

<h1 align="center">Clearly</h1>

<p align="center">Éditeur Markdown et base de connaissances pour Mac.</p>

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
  <a href="https://github.com/Shpigford/clearly/releases/latest/download/Clearly.dmg">Téléchargement direct</a> &middot;
  <a href="https://clearly.md">Site web</a> &middot;
  <a href="https://x.com/Shpigford">@Shpigford</a>
</p>

<p align="center">
  <img src="../website/screenshots/screenshot-1.jpg" width="720" alt="Clearly — éditeur avec barre latérale et plan du document" />
</p>

Écrivez avec coloration syntaxique, reliez vos idées avec des wiki links, recherchez partout et profitez d’un bel aperçu. Natif pour macOS, sans Electron ni abonnement.

## Fonctionnalités

### Écriture

- **Coloration syntaxique** — titres, gras, italique, liens, blocs de code et tableaux surlignés pendant la saisie
- **Raccourcis de formatage** — ⌘B gras, ⌘I italique, ⌘K liens
- **Markdown étendu** — `==surlignage==`, `^exposant^`, `~indice~`, raccourcis `:emoji:` et `[TOC]`
- **Scratchpad** — bloc notes de barre de menus avec raccourci global

### Connaissance

- **Wiki links** — reliez des documents avec `[[wiki-links]]`, tapez `[[` pour l’autocomplétion
- **Backlinks** — mentions liées et non liées avec liaison en un clic
- **Tags** — organisez avec `#tags` et parcourez les tags depuis la barre latérale
- **Recherche globale** — recherche plein texte dans tous les documents, triée par pertinence
- **Plan du document** — structure de titres navigable, clic pour aller directement
- **Explorateur de fichiers** — parcourez des dossiers, épinglez des emplacements, créez et renommez des fichiers

### Aperçu

- **Rendu GFM** — tableaux, listes de tâches, notes de bas de page et texte barré
- **Maths KaTeX** — équations inline et en bloc
- **Diagrammes Mermaid** — organigrammes et diagrammes de séquence depuis des blocs de code
- **Blocs de code** — 27+ langages, numéros de ligne, surlignage diff et copie en un clic
- **Callouts** — NOTE, TIP, WARNING et plus de 15 types repliables
- **Interactif** — cochez des cases, zoomez des images, survolez les notes de bas de page et revenez à la source par double clic

### Intégration

- **Serveur AI / MCP** — le serveur MCP intégré expose votre vault aux agents AI pour la recherche et la récupération
- **QuickLook** — prévisualisez les fichiers `.md` dans Finder avec Espace
- **Export PDF** — export ou impression avec gestion correcte des sauts de page
- **Formats de copie** — Markdown, HTML ou texte enrichi

## Captures

<p>
  <img src="../website/screenshots/screenshot-2-alt.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-3.jpg" width="360" alt="" />
</p>
<p>
  <img src="../website/screenshots/screenshot-4.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-5-alt.jpg" width="360" alt="" />
</p>

## Prérequis

- **macOS 14**（Sonoma）ou version ultérieure
- **Xcode** avec les outils en ligne de commande（`xcode-select --install`）
- **Homebrew**（[brew.sh](https://brew.sh)）
- **xcodegen** — `brew install xcodegen`

Sparkle（mises à jour automatiques）et cmark-gfm（rendu Markdown）sont récupérés automatiquement par Xcode via Swift Package Manager. Aucune configuration manuelle n’est nécessaire.

## Démarrage rapide

```bash
git clone https://github.com/Shpigford/clearly.git
cd clearly
brew install xcodegen    # à ignorer si déjà installé
xcodegen generate        # génère Clearly.xcodeproj depuis project.yml
open Clearly.xcodeproj   # ouvre le projet dans Xcode
```

Ensuite, appuyez sur **⌘R** pour compiler et exécuter.

> **Remarque :** Le projet Xcode est généré à partir de `project.yml`. Si vous modifiez `project.yml`, relancez `xcodegen generate`. N’éditez pas le `.xcodeproj` directement.

### Build CLI（sans interface graphique Xcode）

```bash
xcodebuild -scheme Clearly -configuration Debug build
```

## Structure du projet

```
Clearly/
├── ClearlyApp.swift                # point d’entrée @main — DocumentGroup et commandes de menu（⌘1 / ⌘2）
├── MarkdownDocument.swift          # implémentation FileDocument pour lire et écrire des fichiers .md
├── ContentView.swift               # barre d’outils de sélection du mode, bascule entre Editor ↔ Preview
├── EditorView.swift                # NSViewRepresentable enveloppant NSTextView
├── MarkdownSyntaxHighlighter.swift # coloration basée sur des regex via NSTextStorageDelegate
├── PreviewView.swift               # NSViewRepresentable enveloppant WKWebView
├── Theme.swift                     # couleurs centralisées（clair / sombre）et constantes typographiques
└── Info.plist                      # types de fichiers pris en charge et configuration Sparkle

ClearlyQuickLook/
├── PreviewViewController.swift     # QLPreviewProvider pour les aperçus Finder
└── Info.plist                      # configuration de l’extension（NSExtensionAttributes）

Shared/
├── MarkdownRenderer.swift          # wrapper cmark-gfm — GFM → HTML et pipeline de post-traitement
├── PreviewCSS.swift                # CSS partagé entre la prévisualisation de l’app et QuickLook
├── EmojiShortcodes.swift           # table de correspondance :shortcode: → emoji Unicode
├── SyntaxHighlightSupport.swift    # injection de Highlight.js pour la coloration des blocs de code
└── Resources/                      # JS / CSS embarqués（Mermaid、KaTeX、Highlight.js、demo.md）

website/                 # site marketing statique（HTML / CSS）déployé sur clearly.md
scripts/                 # pipeline de release（release.sh）
project.yml              # configuration xcodegen — source unique de vérité pour les réglages du projet Xcode
ExportOptions.plist      # configuration d’export Developer ID pour les builds de release
```

## Architecture

Application documentaire basée sur **SwiftUI + AppKit** avec deux modes principaux.

### Cycle de vie de l’application

1. `ClearlyApp` crée un `DocumentGroup` avec `MarkdownDocument` pour gérer les E / S des fichiers `.md`
2. `ContentView` affiche un sélecteur de mode dans la barre d’outils et bascule entre `EditorView` et `PreviewView`
3. Les commandes de menu（⌘1 Editor, ⌘2 Preview）utilisent `FocusedValueKey` pour communiquer dans la chaîne de réponse

### Éditeur

L’éditeur enveloppe le `NSTextView` d’AppKit via `NSViewRepresentable` — **pas** le `TextEditor` de SwiftUI. C’est intentionnel : cela fournit un undo / redo natif, le panneau de recherche système（⌘F）et une coloration syntaxique basée sur `NSTextStorageDelegate` exécutée à chaque frappe.

`MarkdownSyntaxHighlighter` applique des motifs regex pour les titres, le gras, l’italique, les blocs de code, les liens, les citations et les listes. Les blocs de code sont traités en premier pour éviter une coloration interne incorrecte.

### Prévisualisation

`PreviewView` enveloppe `WKWebView` et affiche la prévisualisation HTML complète à l’aide de `MarkdownRenderer`（cmark-gfm）stylé par `PreviewCSS`.

### Décisions clés de conception

- **Pont AppKit** — `NSTextView` plutôt que `TextEditor` pour l’undo, la recherche et la coloration syntaxique via `NSTextStorageDelegate`
- **Thème dynamique** — toutes les couleurs passent par `Theme.swift` avec `NSColor(name:)` pour une résolution automatique clair / sombre. N’utilisez pas de couleurs codées en dur.
- **Code partagé** — `MarkdownRenderer` et `PreviewCSS` sont compilés dans l’application principale et l’extension QuickLook
- **Aucune suite de tests** — validez les changements manuellement en compilant, en exécutant et en observant

## Tâches de développement courantes

### Ajouter un type de fichier pris en charge

Modifiez `Clearly/Info.plist` et ajoutez une nouvelle entrée sous `CFBundleDocumentTypes` avec l’UTI et l’extension de fichier.

### Modifier la coloration syntaxique

Modifiez `Clearly/MarkdownSyntaxHighlighter.swift`. Les motifs sont appliqués dans l’ordre : d’abord les blocs de code, puis le reste. Ajoutez de nouveaux motifs regex à la méthode `highlightAllMarkdown()`.

### Modifier le style de la prévisualisation

Modifiez `Shared/PreviewCSS.swift`. Ce CSS est utilisé à la fois par la prévisualisation dans l’application et par l’extension QuickLook. Gardez-le synchronisé avec les couleurs de `Theme.swift`.

### Mettre à jour les couleurs du thème

Modifiez `Clearly/Theme.swift`. Toutes les couleurs utilisent `NSColor(name:)` avec des fournisseurs dynamiques clair / sombre. Mettez aussi à jour le CSS correspondant dans `PreviewCSS.swift`.

## Tests

Il n’y a pas de suite de tests automatisée. Vérifiez manuellement :

1. Compilez et lancez l’application（⌘R）
2. Ouvrez un fichier `.md` et vérifiez la coloration syntaxique
3. Passez en mode prévisualisation（⌘2）et vérifiez le rendu
4. Testez les wiki links, backlinks, la recherche et les tags
5. Testez QuickLook en sélectionnant un fichier `.md` dans Finder puis en appuyant sur Espace
6. Vérifiez les modes clair et sombre

## Configuration de AI Agent

Ce dépôt inclut un fichier `CLAUDE.md` avec le contexte d’architecture et des compétences Claude Code dans `.claude/skills/` pour l’automatisation des releases et l’onboarding de développement.

## Licence

FSL-1.1-MIT — voir [LICENSE](../LICENSE). Le code devient MIT au bout de deux ans.
