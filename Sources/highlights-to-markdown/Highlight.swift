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
