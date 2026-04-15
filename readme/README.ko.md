<p align="center">
  <img src="../website/icon.png" width="128" height="128" alt="Clearly icon" />
</p>

<h1 align="center">Clearly</h1>

<p align="center">Mac 용 Markdown 에디터이자 지식 베이스입니다.</p>

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
  <a href="https://github.com/Shpigford/clearly/releases/latest/download/Clearly.dmg">직접 다운로드</a> &middot;
  <a href="https://clearly.md">웹사이트</a> &middot;
  <a href="https://x.com/Shpigford">@Shpigford</a>
</p>

<p align="center">
  <img src="../website/screenshots/screenshot-1.jpg" width="720" alt="Clearly — 사이드바와 문서 개요를 갖춘 에디터" />
</p>

구문 강조와 함께 작성하고, wiki links 로 생각을 연결하고, 모든 내용을 검색하고, 아름답게 미리 볼 수 있습니다. 네이티브 macOS 앱이며 Electron 과 구독이 없습니다.

## 기능

### 작성

- **구문 강조** — 제목, 굵게, 기울임꼴, 링크, 코드 블록, 표를 입력하는 즉시 강조
- **서식 단축키** — ⌘B 굵게, ⌘I 기울임꼴, ⌘K 링크
- **확장 Markdown** — `==하이라이트==`, `^위첨자^`, `~아래첨자~`, `:emoji:`, `[TOC]`
- **Scratchpad** — 전역 단축키를 갖춘 메뉴 막대 메모장

### 지식 관리

- **Wiki links** — `[[wiki-links]]` 로 문서를 연결하고 `[[` 로 자동 완성
- **Backlinks** — 연결된 언급과 미연결 언급을 한 번에 연결
- **Tags** — `#tags` 로 정리하고 사이드바에서 탐색
- **전역 검색** — 모든 문서를 대상으로 한 관련도 기반 전체 텍스트 검색
- **문서 개요** — 클릭으로 이동할 수 있는 제목 구조
- **파일 탐색기** — 폴더 탐색, 위치 고정, 파일 생성 및 이름 변경

### 미리 보기

- **GFM 렌더링** — 표, 작업 목록, 각주, 취소선
- **KaTeX 수식** — 인라인 수식과 블록 수식
- **Mermaid 다이어그램** — 코드 블록에서 플로우차트와 시퀀스 다이어그램 렌더링
- **코드 블록** — 27+ 개 언어, 줄 번호, diff 강조, 원클릭 복사
- **Callouts** — NOTE, TIP, WARNING 등 15+ 가지 접을 수 있는 유형
- **인터랙티브** — 체크박스 토글, 이미지 확대, 각주 호버, 더블클릭으로 소스 이동

### 연동

- **AI / MCP Server** — 내장 MCP Server 가 vault 를 AI Agents 의 검색 및 검색 결과 대상으로 노출
- **QuickLook** — Finder 에서 `.md` 파일을 Space 로 미리 보기
- **PDF 내보내기** — 페이지 나눔을 처리한 채 내보내기 또는 인쇄
- **복사 형식** — Markdown, HTML, 리치 텍스트

## 스크린샷

<p>
  <img src="../website/screenshots/screenshot-2-alt.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-3.jpg" width="360" alt="" />
</p>
<p>
  <img src="../website/screenshots/screenshot-4.jpg" width="360" alt="" />
  <img src="../website/screenshots/screenshot-5-alt.jpg" width="360" alt="" />
</p>

## 준비 사항

- **macOS 14**（Sonoma）이상
- 명령줄 도구가 설치된 **Xcode**（`xcode-select --install`）
- **Homebrew**（[brew.sh](https://brew.sh)）
- **xcodegen** — `brew install xcodegen`

Sparkle（자동 업데이트）와 cmark-gfm（Markdown 렌더링）은 Xcode 가 Swift Package Manager 를 통해 자동으로 가져옵니다. 수동 설정은 필요하지 않습니다.

## 빠른 시작

```bash
git clone https://github.com/Shpigford/clearly.git
cd clearly
brew install xcodegen    # 이미 설치되어 있다면 생략
xcodegen generate        # project.yml 에서 Clearly.xcodeproj 생성
open Clearly.xcodeproj   # Xcode 로 열기
```

그다음 **⌘R** 을 눌러 빌드하고 실행합니다.

> **참고:** Xcode 프로젝트는 `project.yml` 에서 생성됩니다. `project.yml` 을 변경했다면 `xcodegen generate` 를 다시 실행하세요. `.xcodeproj` 를 직접 수정하지 마세요.

### CLI 빌드（Xcode GUI 없이）

```bash
xcodebuild -scheme Clearly -configuration Debug build
```

## 프로젝트 구조

```
Clearly/
├── ClearlyApp.swift                # @main 진입점 — DocumentGroup 과 메뉴 명령（⌘1 / ⌘2）
├── MarkdownDocument.swift          # .md 파일 읽기 / 쓰기를 위한 FileDocument 구현
├── ContentView.swift               # 모드 선택 툴바, Editor ↔ Preview 전환
├── EditorView.swift                # NSTextView 를 감싸는 NSViewRepresentable
├── MarkdownSyntaxHighlighter.swift # NSTextStorageDelegate 를 통한 정규식 기반 강조
├── PreviewView.swift               # WKWebView 를 감싸는 NSViewRepresentable
├── Theme.swift                     # 중앙 집중식 색상（라이트 / 다크）과 폰트 상수
└── Info.plist                      # 지원 파일 형식과 Sparkle 설정

ClearlyQuickLook/
├── PreviewViewController.swift     # Finder 미리 보기를 위한 QLPreviewProvider
└── Info.plist                      # 확장 설정（NSExtensionAttributes）

Shared/
├── MarkdownRenderer.swift          # cmark-gfm 래퍼 — GFM → HTML 및 후처리 파이프라인
├── PreviewCSS.swift                # 앱 내 미리 보기와 QuickLook 이 공유하는 CSS
├── EmojiShortcodes.swift           # :shortcode: → Unicode emoji 조회 테이블
├── SyntaxHighlightSupport.swift    # 코드 블록 구문 색상을 위한 Highlight.js 주입
└── Resources/                      # 번들된 JS / CSS（Mermaid、KaTeX、Highlight.js、demo.md）

website/                 # clearly.md 에 배포되는 정적 마케팅 사이트（HTML / CSS）
scripts/                 # 릴리스 파이프라인（release.sh）
project.yml              # xcodegen 설정 — Xcode 프로젝트 설정의 단일 기준
ExportOptions.plist      # 릴리스 빌드용 Developer ID 내보내기 설정
```

## 아키텍처

**SwiftUI + AppKit** 기반의 문서형 앱이며, 두 가지 핵심 모드를 가집니다.

### 앱 생명주기

1. `ClearlyApp` 이 `MarkdownDocument` 로 `DocumentGroup` 을 생성하여 `.md` 파일 I/O 를 처리
2. `ContentView` 가 툴바 모드 선택기를 렌더링하고 `EditorView` 와 `PreviewView` 를 전환
3. 메뉴 명령（⌘1 편집기, ⌘2 미리 보기）은 `FocusedValueKey` 를 사용해 응답자 체인 전체에서 통신

### 편집기

편집기는 SwiftUI 의 `TextEditor` 가 **아닌** AppKit 의 `NSTextView` 를 `NSViewRepresentable` 로 감싸 사용합니다. 이는 의도적인 선택입니다. 기본 undo / redo, 시스템 찾기 패널（⌘F）, 그리고 키 입력마다 실행되는 `NSTextStorageDelegate` 기반 구문 강조를 제공하기 때문입니다.

`MarkdownSyntaxHighlighter` 는 제목, 굵게, 기울임꼴, 코드 블록, 링크, 인용 블록, 목록에 정규식 패턴을 적용합니다. 코드 블록은 내부 강조를 막기 위해 가장 먼저 매칭됩니다.

### 미리 보기

`PreviewView` 는 `WKWebView` 를 감싸고, `MarkdownRenderer`（cmark-gfm）와 `PreviewCSS` 를 사용해 전체 HTML 미리 보기를 렌더링합니다.

### 핵심 설계 결정

- **AppKit 브리지** — undo, 찾기, `NSTextStorageDelegate` 기반 구문 강조를 위해 `TextEditor` 대신 `NSTextView` 사용
- **동적 테마** — 모든 색상은 `Theme.swift` 의 `NSColor(name:)` 를 통해 자동으로 라이트 / 다크에 맞게 해석됩니다. 색상을 하드코딩하지 마세요
- **공유 코드** — `MarkdownRenderer` 와 `PreviewCSS` 는 메인 앱과 QuickLook 확장 모두에 컴파일됩니다
- **테스트 스위트 없음** — 변경 사항은 빌드, 실행, 실제 동작 관찰로 수동 검증합니다

## 자주 하는 개발 작업

### 지원 파일 형식 추가

`Clearly/Info.plist` 를 수정하여 `CFBundleDocumentTypes` 아래에 UTI 와 파일 확장자를 포함한 새 항목을 추가합니다.

### 구문 강조 변경

`Clearly/MarkdownSyntaxHighlighter.swift` 를 수정합니다. 패턴은 순서대로 적용되며, 코드 블록이 먼저, 그다음 나머지가 처리됩니다. 새 정규식 패턴을 `highlightAllMarkdown()` 메서드에 추가하세요.

### 미리 보기 스타일 수정

`Shared/PreviewCSS.swift` 를 수정합니다. 이 CSS 는 앱 내 미리 보기와 QuickLook 확장 모두에서 사용됩니다. `Theme.swift` 의 색상과 동기화된 상태를 유지하세요.

### 테마 색상 업데이트

`Clearly/Theme.swift` 를 수정합니다. 모든 색상은 동적 라이트 / 다크 제공자를 가진 `NSColor(name:)` 로 정의됩니다. 함께 `PreviewCSS.swift` 의 해당 CSS 도 업데이트하세요.

## 테스트

자동 테스트 스위트는 없습니다. 다음을 수동으로 검증하세요.

1. 앱을 빌드하고 실행하기（⌘R）
2. `.md` 파일을 열고 구문 강조가 올바른지 확인하기
3. 미리 보기 모드（⌘2）로 전환하고 렌더링 결과 확인하기
4. wiki links, backlinks, 검색, tags 를 테스트하기
5. Finder 에서 `.md` 파일을 선택하고 Space 를 눌러 QuickLook 테스트하기
6. 라이트 모드와 다크 모드 모두 확인하기

## 라이선스

FSL-1.1-MIT — [LICENSE](../LICENSE) 를 참고하세요. 코드는 2 년 후 MIT 로 전환됩니다。
