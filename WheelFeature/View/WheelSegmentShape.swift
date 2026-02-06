//
//  WheelSegmentShape.swift
//  WheelFeature
//
//  Created by Евгения Максимова on 09.12.2025.
//

import SwiftUI

struct WheelSegmentShape: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2.0
        
        path.move(to: center)
        
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        
        path.closeSubpath()
        
        return path
    }
}

struct TrianglePointer: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let left = CGPoint(x: rect.minX, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.maxY)
        
        path.move(to: top)
        path.addLine(to: left)
        path.addLine(to: right)
        path.addLine(to: top)
        
        return path
    }
}
