import SwiftUI
import Foundation
import UIKit
import PocketSVG

class StaticData
{
    static let examplePath = PathModel(path: Path { path in
        path.move(to: CGPoint(x: 50, y: 50))
        path.addLine(to: CGPoint(x: 200, y: 50))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 50, y: 200))
        path.closeSubpath()
    }, fill: .black, stroke: .black, strokeWidth: 2, strokeStyle: StrokeStyle(
        lineWidth: 5,
        lineCap: .round,
        lineJoin: .miter,
        miterLimit: 0,
        dash: [5, 10],
        dashPhase: 0
    ), visible: true)
    
    
    static var myPaths : [PathModel] = [PathModel(path: Path { path in
        path.move(to: CGPoint(x: 50, y: 50))
        path.addLine(to: CGPoint(x: 100, y: 50))
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 50, y: 100))
        path.closeSubpath()
    }, fill: .black, stroke: .black, strokeWidth: 2, strokeStyle: StrokeStyle(
        lineWidth: 5,
        lineCap: .round,
        lineJoin: .miter,
        miterLimit: 0,
        dash: [5, 10],
        dashPhase: 0
    ), visible: true),
                                        
                                        PathModel(path: Path { path in
        path.move(to: CGPoint(x: 150, y: 150))
        path.addLine(to: CGPoint(x: 200, y: 150))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 150, y: 200))
        path.closeSubpath()
    }, fill: .yellow, stroke: .blue, strokeWidth: 2, strokeStyle: StrokeStyle(
        lineWidth: 5,
        lineCap: .round,
        lineJoin: .miter,
        miterLimit: 0,
        dash: [5, 10],
        dashPhase: 0
    ), visible: true)]
    
    
    
    
    
}
