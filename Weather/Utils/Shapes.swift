//
//  Shapes.swift
//  Weather
//
//  Created by TKSOHLT on 07/12/23.
//

import SwiftUI
import CoreGraphics

struct Arc: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX - 1, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX + 1, y:rect.minY), control: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX + 1, y: rect.maxY + 1))
        path.addLine(to: CGPoint(x: rect.minX - 1, y: rect.maxY + 1))
        path.closeSubpath()
        
        return path
    }
}

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.37965*height))
        path.addCurve(to: CGPoint(x: 0.03312*width, y: 0.02995*height), control1: CGPoint(x: 0, y: 0.18083*height), control2: CGPoint(x: 0, y: 0.08142*height))
        path.addCurve(to: CGPoint(x: 0.21492*width, y: 0.04559*height), control1: CGPoint(x: 0.06623*width, y: -0.02153*height), control2: CGPoint(x: 0.1158*width, y: 0.00085*height))
        path.addLine(to: CGPoint(x: 0.9003*width, y: 0.35499*height))
        path.addCurve(to: CGPoint(x: 0.98602*width, y: 0.42173*height), control1: CGPoint(x: 0.94813*width, y: 0.37658*height), control2: CGPoint(x: 0.97204*width, y: 0.38738*height))
        path.addCurve(to: CGPoint(x: width, y: 0.59997*height), control1: CGPoint(x: width, y: 0.45609*height), control2: CGPoint(x: width, y: 0.50405*height))
        path.addLine(to: CGPoint(x: width, y: 0.74857*height))
        path.addCurve(to: CGPoint(x: 0.98116*width, y: 0.96318*height), control1: CGPoint(x: width, y: 0.8671*height), control2: CGPoint(x: width, y: 0.92636*height))
        path.addCurve(to: CGPoint(x: 0.87135*width, y: height), control1: CGPoint(x: 0.96232*width, y: height), control2: CGPoint(x: 0.93199*width, y: height))
        path.addLine(to: CGPoint(x: 0.12865*width, y: height))
        path.addCurve(to: CGPoint(x: 0.01884*width, y: 0.96318*height), control1: CGPoint(x: 0.06801*width, y: height), control2: CGPoint(x: 0.03768*width, y: height))
        path.addCurve(to: CGPoint(x: 0, y: 0.74857*height), control1: CGPoint(x: 0, y: 0.92636*height), control2: CGPoint(x: 0, y: 0.8671*height))
        path.addLine(to: CGPoint(x: 0, y: 0.37965*height))
        path.closeSubpath()
        return path
    }
}

struct HexagonParameters{
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }
    
    static let adjustment: CGFloat = 0.085


    static let segments = [
        Segment(
            line:    CGPoint(x: 0.60, y: 0.05),
            curve:   CGPoint(x: 0.40, y: 0.05),
            control: CGPoint(x: 0.50, y: 0.00)
        ),
        Segment(
            line:    CGPoint(x: 0.05, y: 0.20 + adjustment),
            curve:   CGPoint(x: 0.00, y: 0.30 + adjustment),
            control: CGPoint(x: 0.00, y: 0.25 + adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.00, y: 0.70 - adjustment),
            curve:   CGPoint(x: 0.05, y: 0.80 - adjustment),
            control: CGPoint(x: 0.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.40, y: 0.95),
            curve:   CGPoint(x: 0.60, y: 0.95),
            control: CGPoint(x: 0.50, y: 1.00)
        ),
        Segment(
            line:    CGPoint(x: 0.95, y: 0.80 - adjustment),
            curve:   CGPoint(x: 1.00, y: 0.70 - adjustment),
            control: CGPoint(x: 1.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 1.00, y: 0.30 + adjustment),
            curve:   CGPoint(x: 0.95, y: 0.20 + adjustment),
            control: CGPoint(x: 1.00, y: 0.25 + adjustment)
        )
    ]

}

struct BadgeBackground: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )


                HexagonParameters.segments.forEach { segment in
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )


                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            .fill(.linearGradient(
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
        }
        .aspectRatio(1, contentMode: .fit)
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}


#Preview {
    Arc()
}
