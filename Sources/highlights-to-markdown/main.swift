import PDFKit

guard CommandLine.arguments.count == 2 else {
    print("Usage: h2m path-to-document.pdf")
    exit(1)
}

let url = URL(fileURLWithPath: CommandLine.arguments[1])

guard
    FileManager.default.fileExists(atPath: url.path),
    let pdf = PDFDocument(url: url)
else {
    print("Valid PDF not found at path \(url.path)")
    exit(1)
}

let highlights = pdf.pages.enumerated().flatMap { pageIndex, page in
    return page.highlights.sorted(by: topLeftMost).map { annotation -> Highlight in
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
