//
//  ArrowShape.swift
//  Custom PopOver View
//
//  Created by The Odd Institute on 2023-05-11.
//

import SwiftUI

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        let l: CGFloat = 10.0
        let u: CGFloat = 15.0
        let r: CGFloat = 10.0

        return Path { path in
            path.move(to: CGPoint(x: 0, y: u))
            path.addLine(to: CGPoint(x: 0, y: rect.height - u))

            path.addArc(center: CGPoint(x: u,
                                        y: rect.height - u),
                        radius: u,
                        startAngle: .degrees(-180),
                        endAngle: .degrees(90),
                        clockwise: true)

            path.addLine(to: CGPoint(x: rect.width - u - u, y: rect.height))
            path.addArc(center: CGPoint(x: rect.width - u,
                                        y: rect.height - u),
                        radius: u,
                        startAngle: .degrees(90),
                        endAngle: .degrees(0),
                        clockwise: true)

            path.addLine(to: CGPoint(x: rect.width, y: u + u))

            path.addArc(center: CGPoint(x: rect.width - u,
                                        y: u),
                        radius: u,
                        startAngle: .degrees(0),
                        endAngle: .degrees(270),
                        clockwise: true)

            path.addLine(to: CGPoint(x: rect.width - u - r, y: 0))

            path.addLine(to: CGPoint(x: rect.width - u - l - r, y: -u))
            path.addLine(to: CGPoint(x: rect.width - u - l - l - r, y: 0))
            path.addLine(to: CGPoint(x: u, y: 0))

            path.addArc(center: CGPoint(x: u,
                                        y: u),
                        radius: u,
                        startAngle: .degrees(-90),
                        endAngle: .degrees(180),
                        clockwise: true)
        }
    }
}

extension Shape {
    func union<S: Shape>(with shape: S) -> some Shape {
        Path { path in
            path.addPath(self.path(in: CGRect.infinite))
            path.addPath(shape.path(in: CGRect.infinite))
        }
    }
}

struct TempView: View {
    var body: some View {
        ArrowShape()
            .background(.white)
            .frame(width: 200, height: 100)
    }
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        TempView()
    }
}
