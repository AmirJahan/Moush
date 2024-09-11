import SwiftUI

class StaticData {
    static let examplePath = PathModel(path: Path { path in
        path.move(to: CGPoint(x: 50, y: 50))
        path.addLine(to: CGPoint(x: 200, y: 50))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 50, y: 200))
        path.closeSubpath()
    }, fill: .black, stroke: .black, strokeWidth: 2, strokeStyle: StrokeStyle(), visible: true)
}
