<p align="center">
  <img src="../website/icon.png" width="128" height="128" alt="Clearly icon" />
</p>

<h1 align="center">Clearly</h1>

<p align="center">适用于 Mac 的 Markdown 编辑器与知识库。</p>

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
  <a href="https://github.com/Shpigford/clearly/releases/latest/download/Clearly.dmg">直接下载</a> &middot;
  <a href="https://clearly.md">网站</a> &middot;
  <a href="https://x.com/Shpigford">@Shpigford</a>
</p>

<p align="center">
  <img src="../website/screenshots/screenshot-1.jpg" width="720" alt="Clearly —— 带有侧边栏与文档大纲的编辑器界面" />
</p>

边写边高亮，用 `wiki-links` 连接想法，搜索所有内容，并获得精美预览。原生 macOS 体验，没有 Electron，没有订阅。

## 功能特性

### 写作

- **语法高亮** — 标题、粗体、斜体、链接、代码块、表格都会在输入时即时高亮
- **格式快捷键** — ⌘B 加粗，⌘I 斜体，⌘K 插入链接
- **扩展 Markdown** — 支持 `==高亮==`、`^上标^`、`~下标~`、`:emoji:` 短代码与 `[TOC]` 目录生成
- **Scratchpad** — 带全局快捷键的菜单栏速记板

### 知识管理

- **Wiki 链接** — 使用 `[[wiki-links]]` 连接文档，输入 `[[` 即可自动补全
- **反向链接** — 已链接与未链接提及都可一键关联
- **标签** — 使用 `#tags` 组织内容，并在侧边栏浏览
- **全局搜索** — 基于相关性的全文搜索，覆盖全部文档
- **文档大纲** — 可导航的标题大纲，点击即可跳转
- **文件浏览器** — 浏览文件夹、收藏位置、创建并重命名文件

### 预览

- **GFM 渲染** — 支持表格、任务列表、脚注与删除线
- **KaTeX 数学公式** — 支持行内与块级公式
- **Mermaid 图表** — 从代码块渲染流程图与时序图
- **代码块** — 支持 27+ 种语言、行号、diff 高亮与一键复制
- **Callout** — 支持 NOTE、TIP、WARNING 等 15+ 种可折叠类型
- **交互式预览** — 可切换复选框、缩放图片、悬停脚注，并双击跳回源码

### 集成

- **AI / MCP 服务器** — 内置 `MCP server`，可将知识库暴露给 `AI agent` 做搜索与检索
- **QuickLook** — 在 Finder 中按空格预览 `.md` 文件
- **PDF 导出** — 支持导出或打印，并正确处理分页
- **复制格式** — 支持复制 Markdown、HTML 或富文本

## 截图

<p>
  <img src="../website/screenshots/screenshot-2-alt.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-3.jpg" width="360" alt="" />
</p>
<p>
  <img src="../website/screenshots/screenshot-4.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-5-alt.jpg" width="360" alt="" />
</p>

## 环境要求

- **macOS 14**（Sonoma）或更高版本
- 安装了命令行工具的 **Xcode**（`xcode-select --install`）
- **Homebrew**（[brew.sh](https://brew.sh)）
- **xcodegen** — `brew install xcodegen`

Sparkle（自动更新）与 cmark-gfm（Markdown 渲染）会由 Xcode 通过 Swift Package Manager 自动拉取，无需手动配置。

## 快速开始

```bash
git clone https://github.com/Shpigford/clearly.git
cd clearly
brew install xcodegen    # 如果已经安装可跳过
xcodegen generate        # 根据 project.yml 生成 Clearly.xcodeproj
open Clearly.xcodeproj   # 在 Xcode 中打开
```

然后按 **⌘R** 进行构建并运行。

> **注意：** Xcode 工程由 `project.yml` 生成。如果你修改了 `project.yml`，请重新执行 `xcodegen generate`。不要直接编辑 `.xcodeproj`。

### CLI 构建（不使用 Xcode 图形界面）

```bash
xcodebuild -scheme Clearly -configuration Debug build
```

## 项目结构

```
Clearly/
├── ClearlyApp.swift                # @main 入口 — DocumentGroup 与菜单命令（⌘1 / ⌘2）
├── MarkdownDocument.swift          # 用于读取和写入 .md 文件的 FileDocument 实现
├── ContentView.swift               # 模式切换工具栏，在 Editor 与 Preview 间切换
├── EditorView.swift                # 封装 NSTextView 的 NSViewRepresentable
├── MarkdownSyntaxHighlighter.swift # 基于正则的高亮，使用 NSTextStorageDelegate
├── PreviewView.swift               # 封装 WKWebView 的 NSViewRepresentable
├── Theme.swift                     # 集中的颜色（浅色 / 深色）与字体常量
└── Info.plist                      # 支持的文件类型与 Sparkle 配置

ClearlyQuickLook/
├── PreviewViewController.swift     # Finder 预览用的 QLPreviewProvider
└── Info.plist                      # 扩展配置（NSExtensionAttributes）

Shared/
├── MarkdownRenderer.swift          # cmark-gfm 封装 — GFM 转 HTML 与后处理流水线
├── PreviewCSS.swift                # 应用内预览与 QuickLook 共用的 CSS
├── EmojiShortcodes.swift           # :shortcode: 到 Unicode emoji 的查找表
├── SyntaxHighlightSupport.swift    # 为代码块语法高亮注入 Highlight.js
└── Resources/                      # 打包的 JS / CSS（Mermaid、KaTeX、Highlight.js、demo.md）

website/                 # 静态营销站点（HTML / CSS），部署到 clearly.md
scripts/                 # 发布流水线（release.sh）
project.yml              # xcodegen 配置 — Xcode 工程设置的唯一真值来源
ExportOptions.plist      # 发布构建的 Developer ID 导出配置
```

## 架构

这是一个由 **SwiftUI + AppKit** 构建的文档型应用，包含两种核心模式。

### 应用生命周期

1. `ClearlyApp` 使用 `MarkdownDocument` 创建 `DocumentGroup`，负责 `.md` 文件 I/O
2. `ContentView` 渲染工具栏模式选择器，并在 `EditorView` 与 `PreviewView` 之间切换
3. 菜单命令（⌘1 编辑器、⌘2 预览）通过 `FocusedValueKey` 在响应链中通信

### 编辑器

编辑器通过 `NSViewRepresentable` 封装 AppKit 的 `NSTextView`，**而不是** SwiftUI 的 `TextEditor`。这是有意为之：它提供原生的撤销 / 重做、系统查找面板（⌘F），以及基于 `NSTextStorageDelegate`、在每次按键时运行的语法高亮。

`MarkdownSyntaxHighlighter` 会对标题、粗体、斜体、代码块、链接、引用块和列表应用正则模式。代码块会最先匹配，以防止内部内容被错误高亮。

### 预览

`PreviewView` 封装 `WKWebView`，并使用 `MarkdownRenderer`（cmark-gfm）与 `PreviewCSS` 来渲染完整的 HTML 预览。

### 关键设计决策

- **AppKit 桥接** — 使用 `NSTextView` 而不是 `TextEditor`，以获得撤销、查找与 `NSTextStorageDelegate` 语法高亮
- **动态主题** — 所有颜色都通过 `Theme.swift` 与 `NSColor(name:)` 实现自动浅色 / 深色解析，不要硬编码颜色
- **共享代码** — `MarkdownRenderer` 与 `PreviewCSS` 会同时编译进主应用和 QuickLook 扩展
- **没有测试套件** — 通过构建、运行和实际观察来手动验证更改

## 常见开发任务

### 添加受支持的文件类型

编辑 `Clearly/Info.plist`，在 `CFBundleDocumentTypes` 下新增一项，填入 UTI 与文件扩展名。

### 修改语法高亮

编辑 `Clearly/MarkdownSyntaxHighlighter.swift`。模式会按顺序应用，先处理代码块，再处理其它内容。把新的正则模式添加到 `highlightAllMarkdown()` 方法中。

### 修改预览样式

编辑 `Shared/PreviewCSS.swift`。这份 CSS 同时用于应用内预览和 QuickLook 扩展，请保持它与 `Theme.swift` 中的颜色同步。

### 更新主题颜色

编辑 `Clearly/Theme.swift`。所有颜色都通过带动态浅色 / 深色提供器的 `NSColor(name:)` 定义。更新时也要同步修改 `PreviewCSS.swift` 中对应的 CSS。

## 测试

没有自动化测试套件。请手动验证：

1. 构建并运行应用（⌘R）
2. 打开一个 `.md` 文件，并确认语法高亮正常
3. 切换到预览模式（⌘2），并确认渲染结果正确
4. 测试 `wiki-links`、反向链接、搜索与标签
5. 在 Finder 中选中一个 `.md` 文件并按空格，测试 QuickLook
6. 检查浅色模式与深色模式

## AI Agent 设置

这个仓库包含一个 `CLAUDE.md` 文件，里面提供架构背景，以及位于 `.claude/skills/` 中供 Claude Code 使用的发布自动化与开发入门技能。

## 许可证

FSL-1.1-MIT — 参见 [LICENSE](../LICENSE)。代码会在两年后转换为 MIT。
