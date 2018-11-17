import Quartz

extension PDFDocument {
    var title: String? {
        return documentAttributes?[PDFDocumentAttribute.titleAttribute] as? String
    }

    var pages: AnySequence<PDFPage> {
        return AnySequence(
            sequence(state: 0, next: { index -> PDFPage? in
                guard self.pageCount > 0, index < self.pageCount else { return nil }
                let page = self.page(at: index)
                index += 1
                return page
            })
        )
    }
}

extension PDFPage {
    var highlights: [PDFAnnotation] {
        return annotations.filter { $0.type == "Highlight" }
    }
}

func topLeftMost(_ first: PDFAnnotation, _ second: PDFAnnotation) -> Bool {
    return first.bounds.origin.x < second.bounds.origin.x || first.bounds.origin.y > second.bounds.origin.y
} 
