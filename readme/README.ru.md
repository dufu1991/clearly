<p align="center">
  <img src="../website/icon.png" width="128" height="128" alt="Clearly icon" />
</p>

<h1 align="center">Clearly</h1>

<p align="center">Markdown редактор и база знаний для Mac.</p>

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
  <a href="https://github.com/Shpigford/clearly/releases/latest/download/Clearly.dmg">Прямая загрузка</a> &middot;
  <a href="https://clearly.md">Сайт</a> &middot;
  <a href="https://x.com/Shpigford">@Shpigford</a>
</p>

<p align="center">
  <img src="../website/screenshots/screenshot-1.jpg" width="720" alt="Clearly — редактор с боковой панелью и структурой документа" />
</p>

Пишите с подсветкой синтаксиса, связывайте мысли через wiki links, ищите по всем заметкам и получайте аккуратный предпросмотр. Нативно для macOS, без Electron и подписок.

## Возможности

### Writing

- **Подсветка синтаксиса** — заголовки, жирный текст, курсив, ссылки, блоки кода и таблицы подсвечиваются во время набора
- **Горячие клавиши форматирования** — ⌘B жирный, ⌘I курсив, ⌘K ссылки
- **Расширенный Markdown** — `==выделение==`, `^надстрочный^`, `~подстрочный~`, `:emoji:` и `[TOC]`
- **Scratchpad** — заметки в строке меню с глобальной горячей клавишей

### Knowledge

- **Wiki links** — связывайте документы через `[[wiki-links]]`, `[[` запускает автодополнение
- **Backlinks** — связанные и несвязанные упоминания с привязкой в один клик
- **Tags** — организуйте записи с помощью `#tags` и просматривайте их в боковой панели
- **Глобальный поиск** — полнотекстовый поиск по всем документам с сортировкой по релевантности
- **Структура документа** — навигация по заголовкам с быстрым переходом
- **Проводник файлов** — просмотр папок, закрепление мест, создание и переименование файлов

### Preview

- **Рендеринг GFM** — таблицы, списки задач, сноски и зачёркивание
- **Формулы KaTeX** — строчные и блочные уравнения
- **Диаграммы Mermaid** — блок схемы и sequence diagram из блоков кода
- **Блоки кода** — 27+ языков, номера строк, diff подсветка и копирование в один клик
- **Callouts** — NOTE, TIP, WARNING и ещё 15+ сворачиваемых типов
- **Интерактивность** — переключение чекбоксов, увеличение изображений, hover по сноскам и двойной щелчок к исходнику

### Integration

- **AI / MCP Server** — встроенный MCP Server открывает ваш vault для AI Agents, поиска и извлечения данных
- **QuickLook** — просмотр `.md` файлов в Finder по клавише Space
- **Экспорт PDF** — экспорт или печать с корректной разбивкой страниц
- **Форматы копирования** — Markdown, HTML или rich text

## Скриншоты

<p>
  <img src="../website/screenshots/screenshot-2-alt.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-3.jpg" width="360" alt="" />
</p>
<p>
  <img src="../website/screenshots/screenshot-4.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-5-alt.jpg" width="360" alt="" />
</p>

## Требования

- **macOS 14**（Sonoma）или новее
- **Xcode** с установленными инструментами командной строки（`xcode-select --install`）
- **Homebrew**（[brew.sh](https://brew.sh)）
- **xcodegen** — `brew install xcodegen`

Sparkle（автообновления）и cmark-gfm（рендеринг Markdown）Xcode подтягивает автоматически через Swift Package Manager. Ручная настройка не требуется.

## Быстрый старт

```bash
git clone https://github.com/Shpigford/clearly.git
cd clearly
brew install xcodegen    # пропустите, если уже установлен
xcodegen generate        # генерирует Clearly.xcodeproj из project.yml
open Clearly.xcodeproj   # открывает проект в Xcode
```

После этого нажмите **⌘R**, чтобы собрать и запустить приложение.

> **Примечание:** Проект Xcode генерируется из `project.yml`. Если вы изменили `project.yml`, повторно выполните `xcodegen generate`. Не редактируйте `.xcodeproj` напрямую.

### Сборка через CLI（без графического интерфейса Xcode）

```bash
xcodebuild -scheme Clearly -configuration Debug build
```

## Структура проекта

```
Clearly/
├── ClearlyApp.swift                # точка входа @main — DocumentGroup и команды меню（⌘1 / ⌘2）
├── MarkdownDocument.swift          # реализация FileDocument для чтения и записи файлов .md
├── ContentView.swift               # панель выбора режима, переключение между Editor ↔ Preview
├── EditorView.swift                # NSViewRepresentable, оборачивающий NSTextView
├── MarkdownSyntaxHighlighter.swift # подсветка на основе регулярных выражений через NSTextStorageDelegate
├── PreviewView.swift               # NSViewRepresentable, оборачивающий WKWebView
├── Theme.swift                     # централизованные цвета（светлая / тёмная）и константы шрифтов
└── Info.plist                      # поддерживаемые типы файлов и конфигурация Sparkle

ClearlyQuickLook/
├── PreviewViewController.swift     # QLPreviewProvider для предпросмотра в Finder
└── Info.plist                      # конфигурация расширения（NSExtensionAttributes）

Shared/
├── MarkdownRenderer.swift          # обёртка над cmark-gfm — GFM → HTML и конвейер постобработки
├── PreviewCSS.swift                # CSS, общий для предпросмотра в приложении и QuickLook
├── EmojiShortcodes.swift           # таблица соответствия :shortcode: → Unicode emoji
├── SyntaxHighlightSupport.swift    # внедрение Highlight.js для подсветки блоков кода
└── Resources/                      # встроенные JS / CSS（Mermaid、KaTeX、Highlight.js、demo.md）

website/                 # статический маркетинговый сайт（HTML / CSS）, развёрнутый на clearly.md
scripts/                 # конвейер релизов（release.sh）
project.yml              # конфигурация xcodegen — единственный источник истины для настроек проекта Xcode
ExportOptions.plist      # конфигурация экспорта Developer ID для релизных сборок
```

## Архитектура

Документное приложение на **SwiftUI + AppKit** с двумя основными режимами.

### Жизненный цикл приложения

1. `ClearlyApp` создаёт `DocumentGroup` с `MarkdownDocument` и обрабатывает ввод / вывод файлов `.md`
2. `ContentView` отображает переключатель режимов на панели инструментов и меняет `EditorView` и `PreviewView`
3. Команды меню（⌘1 Editor, ⌘2 Preview）используют `FocusedValueKey` для связи по цепочке responder

### Редактор

Редактор оборачивает `NSTextView` из AppKit через `NSViewRepresentable`, **а не** использует SwiftUI `TextEditor`. Это сделано намеренно: так доступны нативные undo / redo, системная панель поиска（⌘F）и подсветка синтаксиса на основе `NSTextStorageDelegate`, которая выполняется при каждом нажатии клавиши.

`MarkdownSyntaxHighlighter` применяет regex шаблоны для заголовков, жирного текста, курсива, блоков кода, ссылок, цитат и списков. Блоки кода сопоставляются первыми, чтобы избежать внутренней подсветки.

### Предпросмотр

`PreviewView` оборачивает `WKWebView` и рендерит полный HTML предпросмотр с помощью `MarkdownRenderer`（cmark-gfm）, оформленного через `PreviewCSS`.

### Ключевые проектные решения

- **Мост с AppKit** — `NSTextView` вместо `TextEditor` ради undo, поиска и подсветки синтаксиса через `NSTextStorageDelegate`
- **Динамические темы** — все цвета идут через `Theme.swift` и `NSColor(name:)` с автоматическим выбором светлой / тёмной темы. Не хардкодьте цвета.
- **Общий код** — `MarkdownRenderer` и `PreviewCSS` компилируются и в основное приложение, и в расширение QuickLook
- **Без тестового набора** — изменения проверяются вручную через сборку, запуск и визуальную проверку

## Частые задачи разработки

### Добавить поддерживаемый тип файла

Отредактируйте `Clearly/Info.plist` и добавьте новую запись в `CFBundleDocumentTypes` с UTI и расширением файла.

### Изменить подсветку синтаксиса

Отредактируйте `Clearly/MarkdownSyntaxHighlighter.swift`. Шаблоны применяются по порядку: сначала блоки кода, затем всё остальное. Добавляйте новые regex шаблоны в метод `highlightAllMarkdown()`.

### Изменить стиль предпросмотра

Отредактируйте `Shared/PreviewCSS.swift`. Этот CSS используется и во встроенном предпросмотре, и в расширении QuickLook. Держите его синхронизированным с цветами из `Theme.swift`.

### Обновить цвета темы

Отредактируйте `Clearly/Theme.swift`. Все цвета используют `NSColor(name:)` с динамическими провайдерами светлой / тёмной темы. Одновременно обновите соответствующий CSS в `PreviewCSS.swift`.

## Тестирование

Автоматизированного набора тестов нет. Проверьте вручную:

1. Соберите и запустите приложение（⌘R）
2. Откройте файл `.md` и убедитесь, что подсветка синтаксиса работает
3. Переключитесь в режим предпросмотра（⌘2）и убедитесь, что рендеринг корректен
4. Проверьте wiki links, backlinks, поиск и tags
5. Проверьте QuickLook: выберите файл `.md` в Finder и нажмите Space
6. Проверьте и светлую, и тёмную тему

## Настройка AI Agent

В этом репозитории есть файл `CLAUDE.md` с архитектурным контекстом и навыки Claude Code в `.claude/skills/` для автоматизации релизов и онбординга разработчиков.

## Лицензия

FSL-1.1-MIT — см. [LICENSE](../LICENSE). Через два года код переходит на MIT.
