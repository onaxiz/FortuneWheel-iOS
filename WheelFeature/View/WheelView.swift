//
//  WheelView.swift
//  WheelFeature
//

import SwiftUI

struct WheelView: View {
    let segments: [Prize]
    let rotation: Double
    let isSpinning: Bool
    let onSpinTap: () -> Void

    private let wheelSize: CGFloat = 348

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.18))
                .frame(width: 400, height: 400)
            
            Circle()
                .fill(Color.yellow.opacity(0.75))
                .frame(width: 368, height: 368)
            
            wheelSegments
                .frame(width: wheelSize, height: wheelSize)
                .rotationEffect(.degrees(rotation))
            
            TrianglePointer()
                .fill(Color.yellow)
                .frame(width: 26, height: 32)
                .rotationEffect(.degrees(180))
                .offset(y: -160)
                .shadow(radius: 3)
            
            Button(action: {
                onSpinTap()
            }, label: {
                Text(isSpinning ? "Крутим..." : "КРУТИТЬ")
                    .font(.system(size: 16, weight: .bold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 36)
                    .padding(.vertical, 22)
                    .background(
                        Circle()
                            .fill(Color.red)
                            .shadow(radius: 4)
                    )
            })
            .buttonStyle(.plain)
            .disabled(isSpinning)
        }
        .accessibilityElement(children: .contain)
    }
    
    private var wheelSegments: some View {
        let count = segments.count
        let anglePerSegment = 360.0 / Double(count)
        let wheelRadius = wheelSize / 2
        let labelRadius = wheelRadius * (2.0 / 3.0)

        return ZStack {
            ForEach(0..<count, id: \.self) { index in
                let start = Angle(degrees: Double(index) * anglePerSegment - 90)
                let end = Angle(degrees: Double(index + 1) * anglePerSegment - 90)
                WheelSegmentShape(startAngle: start, endAngle: end)
                    .fill(segments[index].color)
                    .overlay(
                        WheelSegmentShape(startAngle: start, endAngle: end)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .overlay(
                        segmentLabel(
                            prize: segments[index],
                            index: index,
                            anglePerSegment: anglePerSegment,
                            labelRadius: labelRadius
                        )
                    )
            }
        }
    }

    private func segmentLabel(
        prize: Prize,
        index: Int,
        anglePerSegment: Double,
        labelRadius: CGFloat
    ) -> some View {
        let midAngle = Double(index) * anglePerSegment + anglePerSegment / 2.0
        let circleMidAngle = midAngle - 90
        let rad = circleMidAngle * .pi / 180
        let dx = labelRadius * cos(rad)
        let dy = labelRadius * sin(rad)

        return VStack(spacing: 1) {
            Text(prize.title)
                .font(.system(size: 12, weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            if let subtitle = prize.subtitle {
                Text(subtitle)
                    .font(.system(size: 10, weight: .medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
        .foregroundStyle(.white)
        .shadow(color: .black.opacity(0.4), radius: 1)
        .frame(width: 72)
        .rotationEffect(.degrees(circleMidAngle))
        .offset(x: dx, y: dy)
    }
}

#Preview {
    WheelView(
        segments: WheelViewModel().segments,
        rotation: 0,
        isSpinning: false,
        onSpinTap: {}
    )
    .padding()
    .background(Color(red: 0.07, green: 0.38, blue: 0.96))
}
