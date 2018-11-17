#if canImport(PDFKit)
    import PDFKit
#elseif canImport(Quartz)
    import Quartz.PDFKit
#endif

struct Highlight {
    let pageIndex: Int
    let text: String
    let note: String?

    var markdown: String {
        return [
            """
            > \(text)
            – Page \(pageIndex + 1)
            """,
            note
        ].compactMap { $0 }
         .joined(separator: "\n\n")
    }
}

let url = URL(fileURLWithPath: CommandLine.arguments[1])
let pdf = PDFDocument(url: url)!

let highlights = pdf.pages.enumerated().flatMap { pageIndex, page in
    return page.highlights.map { annotation -> Highlight in
        return Highlight(pageIndex: pageIndex, 
                         text: (annotation.quadrilateralPoints ?? [])
                               .map { annotation.bounds.origin + $0.point }
                               .chunked(by: 4)
                               .map(CGRect.init(points:))
                               .map { $0.insetBy(dx: -1, dy: -1) }
                               .compactMap { page.selection(for: $0)?.string }
                               .joined()
                               .trimmingCharacters(in: .whitespacesAndNewlines),
                         note: annotation.popup?.contents)
    }
}

print("""
      # \(pdf.title ?? pdf.documentURL?.lastPathComponent ?? "")

      \(highlights.map { $0.markdown }.joined(separator: "\n\n"))
      """)
