import QuickLookUI
import UniformTypeIdentifiers

class PreviewProvider: QLPreviewProvider {
    func providePreview(for request: QLFilePreviewRequest) async throws -> QLPreviewReply {
        let url = request.fileURL
        let accessing = url.startAccessingSecurityScopedResource()
        defer { if accessing { url.stopAccessingSecurityScopedResource() } }

        let markdownText = try String(contentsOf: url, encoding: .utf8)
        let htmlBody = MarkdownRenderer.renderHTML(markdownText)

        let html = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="utf-8">
        <style>\(PreviewCSS.css)</style>
        </head>
        <body>\(htmlBody)</body>
        </html>
        """

        let data = Data(html.utf8)
        return QLPreviewReply(dataOfContentType: UTType.html, contentSize: CGSize(width: 800, height: 800)) { _ in
            return data
        }
    }
}
