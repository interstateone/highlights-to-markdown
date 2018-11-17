import Foundation

extension Array {
    func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}

extension NSValue {
    var point: CGPoint {
        #if os(iOS) || os(watchOS) || os(tvOS)
            return cgPointValue
        #elseif os(macOS)
            return pointValue
        #else
            fatalError("Unsupported OS")
        #endif
    }
}
