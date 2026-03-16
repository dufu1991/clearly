import SwiftUI
import WebKit

struct PreviewView: NSViewRepresentable {
    let markdown: String
    @Environment(\.colorScheme) private var colorScheme

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeNSView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.underPageBackgroundColor = Theme.backgroundColor
        webView.alphaValue = 0 // hidden until content loads
        loadHTML(in: webView)
        return webView
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
        webView.underPageBackgroundColor = Theme.backgroundColor
        loadHTML(in: webView)
    }

    private func loadHTML(in webView: WKWebView) {
        let htmlBody = MarkdownRenderer.renderHTML(markdown)
        let html = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>\(PreviewCSS.css)</style>
        </head>
        <body>\(htmlBody)</body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }

    final class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.alphaValue = 1
        }
    }
}
