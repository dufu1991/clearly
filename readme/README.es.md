<p align="center">
  <img src="../website/icon.png" width="128" height="128" alt="Clearly icon" />
</p>

<h1 align="center">Clearly</h1>

<p align="center">Editor Markdown y base de conocimiento para Mac.</p>

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
  <a href="https://github.com/Shpigford/clearly/releases/latest/download/Clearly.dmg">Descarga directa</a> &middot;
  <a href="https://clearly.md">Sitio web</a> &middot;
  <a href="https://x.com/Shpigford">@Shpigford</a>
</p>

<p align="center">
  <img src="../website/screenshots/screenshot-1.jpg" width="720" alt="Clearly — editor con barra lateral y esquema del documento" />
</p>

Escribe con resaltado de sintaxis, enlaza ideas con wiki links, busca en todo y disfruta de una vista previa cuidada. Nativo para macOS, sin Electron y sin suscripciones.

## Funciones

### Escritura

- **Resaltado de sintaxis** — encabezados, negrita, cursiva, enlaces, bloques de código y tablas resaltados mientras escribes
- **Atajos de formato** — ⌘B negrita, ⌘I cursiva, ⌘K enlaces
- **Markdown extendido** — `==resaltados==`, `^superíndice^`, `~subíndice~`, atajos `:emoji:` y `[TOC]`
- **Scratchpad** — bloc de notas en la barra de menús con atajo global

### Conocimiento

- **Wiki links** — enlaza documentos con `[[wiki-links]]`; escribe `[[` para autocompletar
- **Backlinks** — menciones enlazadas y no enlazadas con vinculación en un clic
- **Tags** — organiza con `#tags` y recórrelos desde la barra lateral
- **Búsqueda global** — búsqueda de texto completo en todos los documentos, ordenada por relevancia
- **Esquema del documento** — estructura navegable de encabezados, con salto inmediato
- **Explorador de archivos** — navega carpetas, fija ubicaciones, crea y renombra archivos

### Vista previa

- **Renderizado GFM** — tablas, listas de tareas, notas al pie y tachado
- **Matemáticas KaTeX** — ecuaciones inline y de bloque
- **Diagramas Mermaid** — diagramas de flujo y secuencia desde bloques de código
- **Bloques de código** — 27+ lenguajes, números de línea, resaltado diff y copia en un clic
- **Callouts** — NOTE, TIP, WARNING y más de 15 tipos plegables
- **Interactivo** — alterna casillas, amplía imágenes, pasa sobre notas al pie y vuelve al origen con doble clic

### Integración

- **Servidor AI / MCP** — el servidor MCP integrado expone tu vault a agentes de AI para búsqueda y recuperación
- **QuickLook** — previsualiza archivos `.md` en Finder con Espacio
- **Exportación PDF** — exporta o imprime con saltos de página resueltos
- **Formatos de copia** — Markdown, HTML o texto enriquecido

## Capturas

<p>
  <img src="../website/screenshots/screenshot-2-alt.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-3.jpg" width="360" alt="" />
</p>
<p>
  <img src="../website/screenshots/screenshot-4.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-5-alt.jpg" width="360" alt="" />
</p>

## Requisitos previos

- **macOS 14**（Sonoma）o posterior
- **Xcode** con herramientas de línea de comandos（`xcode-select --install`）
- **Homebrew**（[brew.sh](https://brew.sh)）
- **xcodegen** — `brew install xcodegen`

Sparkle（actualizaciones automáticas）y cmark-gfm（renderizado de Markdown）se descargan automáticamente por Xcode mediante Swift Package Manager. No se necesita configuración manual.

## Inicio rápido

```bash
git clone https://github.com/Shpigford/clearly.git
cd clearly
brew install xcodegen    # omítelo si ya está instalado
xcodegen generate        # genera Clearly.xcodeproj a partir de project.yml
open Clearly.xcodeproj   # lo abre en Xcode
```

Luego pulsa **⌘R** para compilar y ejecutar.

> **Nota:** El proyecto de Xcode se genera a partir de `project.yml`. Si cambias `project.yml`, vuelve a ejecutar `xcodegen generate`. No edites el `.xcodeproj` directamente.

### Compilación por CLI（sin interfaz gráfica de Xcode）

```bash
xcodebuild -scheme Clearly -configuration Debug build
```

## Estructura del proyecto

```
Clearly/
├── ClearlyApp.swift                # entrada @main — DocumentGroup y comandos de menú（⌘1 / ⌘2）
├── MarkdownDocument.swift          # conformidad FileDocument para leer y escribir archivos .md
├── ContentView.swift               # barra de herramientas del selector de modo, cambia entre Editor ↔ Preview
├── EditorView.swift                # NSViewRepresentable que envuelve NSTextView
├── MarkdownSyntaxHighlighter.swift # resaltado basado en expresiones regulares mediante NSTextStorageDelegate
├── PreviewView.swift               # NSViewRepresentable que envuelve WKWebView
├── Theme.swift                     # colores centralizados（claro / oscuro）y constantes tipográficas
└── Info.plist                      # tipos de archivo compatibles y configuración de Sparkle

ClearlyQuickLook/
├── PreviewViewController.swift     # QLPreviewProvider para vistas previas en Finder
└── Info.plist                      # configuración de la extensión（NSExtensionAttributes）

Shared/
├── MarkdownRenderer.swift          # envoltorio de cmark-gfm — GFM → HTML y tubería de posprocesado
├── PreviewCSS.swift                # CSS compartido por la vista previa en la app y QuickLook
├── EmojiShortcodes.swift           # tabla de búsqueda de :shortcode: → emoji Unicode
├── SyntaxHighlightSupport.swift    # inyección de Highlight.js para coloreado sintáctico de bloques de código
└── Resources/                      # JS / CSS incluidos（Mermaid、KaTeX、Highlight.js、demo.md）

website/                 # sitio de marketing estático（HTML / CSS）desplegado en clearly.md
scripts/                 # tubería de lanzamiento（release.sh）
project.yml              # configuración de xcodegen — fuente única de verdad para los ajustes del proyecto Xcode
ExportOptions.plist      # configuración de exportación Developer ID para builds de lanzamiento
```

## Arquitectura

Aplicación documental basada en **SwiftUI + AppKit** con dos modos principales.

### Ciclo de vida de la app

1. `ClearlyApp` crea un `DocumentGroup` con `MarkdownDocument` para manejar la E / S de archivos `.md`
2. `ContentView` renderiza un selector de modo en la barra de herramientas y cambia entre `EditorView` y `PreviewView`
3. Los comandos de menú（⌘1 Editor, ⌘2 Preview）usan `FocusedValueKey` para comunicarse a través de la cadena de respuesta

### Editor

El editor envuelve el `NSTextView` de AppKit mediante `NSViewRepresentable`, **no** el `TextEditor` de SwiftUI. Esto es intencional: proporciona undo / redo nativo, el panel de búsqueda del sistema（⌘F）y resaltado de sintaxis basado en `NSTextStorageDelegate` que se ejecuta en cada pulsación.

`MarkdownSyntaxHighlighter` aplica patrones regex para encabezados, negrita, cursiva, bloques de código, enlaces, citas y listas. Los bloques de código se hacen coincidir primero para evitar resaltados internos incorrectos.

### Vista previa

`PreviewView` envuelve `WKWebView` y renderiza la vista previa HTML completa usando `MarkdownRenderer`（cmark-gfm）estilizado con `PreviewCSS`.

### Decisiones clave de diseño

- **Puente AppKit** — `NSTextView` en lugar de `TextEditor` para undo, búsqueda y resaltado de sintaxis mediante `NSTextStorageDelegate`
- **Tema dinámico** — todos los colores pasan por `Theme.swift` con `NSColor(name:)` para una resolución automática claro / oscuro. No codifiques colores de forma fija.
- **Código compartido** — `MarkdownRenderer` y `PreviewCSS` se compilan tanto en la app principal como en la extensión QuickLook
- **Sin suite de pruebas** — valida los cambios manualmente compilando, ejecutando y observando

## Tareas comunes de desarrollo

### Añadir un tipo de archivo compatible

Edita `Clearly/Info.plist` y añade una nueva entrada bajo `CFBundleDocumentTypes` con el UTI y la extensión de archivo.

### Cambiar el resaltado de sintaxis

Edita `Clearly/MarkdownSyntaxHighlighter.swift`. Los patrones se aplican en orden: primero los bloques de código y después todo lo demás. Añade nuevos patrones regex al método `highlightAllMarkdown()`.

### Modificar el estilo de la vista previa

Edita `Shared/PreviewCSS.swift`. Este CSS se usa tanto en la vista previa dentro de la app como en la extensión QuickLook. Mantenlo sincronizado con los colores de `Theme.swift`.

### Actualizar los colores del tema

Edita `Clearly/Theme.swift`. Todos los colores usan `NSColor(name:)` con proveedores dinámicos claro / oscuro. Actualiza también el CSS correspondiente en `PreviewCSS.swift`.

## Pruebas

No hay una suite de pruebas automatizada. Valida manualmente:

1. Compila y ejecuta la app（⌘R）
2. Abre un archivo `.md` y verifica el resaltado de sintaxis
3. Cambia al modo de vista previa（⌘2）y verifica el resultado renderizado
4. Prueba wiki links, backlinks, búsqueda y tags
5. Prueba QuickLook seleccionando un archivo `.md` en Finder y pulsando Espacio
6. Comprueba tanto el modo claro como el oscuro

## Configuración de AI Agent

Este repositorio incluye un archivo `CLAUDE.md` con contexto de arquitectura y habilidades de Claude Code en `.claude/skills/` para automatización de lanzamientos e incorporación de desarrollo.

## Licencia

FSL-1.1-MIT — consulta [LICENSE](../LICENSE). El código pasa a MIT después de dos años.
