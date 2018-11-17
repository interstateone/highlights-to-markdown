import CoreGraphics

extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

extension CGRect {
    init(points: [CGPoint]) {
        precondition(points.count == 4)

        let origin  = points.min { return $0.x < $1.x || $0.y < $1.y }!
        let width = points.map { $0.x }.max()! - points.map { $0.x }.min()!
        let height = points.map { $0.y }.max()! - points.map { $0.y }.min()!
        self.init(origin: origin, size: CGSize(width: width, height: height))
    }
}