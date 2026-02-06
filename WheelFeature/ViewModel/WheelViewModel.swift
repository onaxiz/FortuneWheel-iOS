//
//  WheelViewModel.swift
//  WheelFeature
//
//  Created by Евгения Максимова on 08.12.2025.
//

import SwiftUI


final class WheelViewModel: ObservableObject {
    @Published var rotation: Double = 0
    @Published var isSpinning: Bool = false
    @Published var remainingSpins: Int = 3
    let maxSpins: Int = 3
    @Published var currentPrize: Prize? = nil
    let segments: [Prize]
    
    init() {
        segments = [
            Prize(title: "-10%", subtitle: "Скидка на заказ",
                  color: Color(red: 0.96, green: 0.33, blue: 0.30)),
            Prize(title: "Бонус 300 ₽", subtitle: "На счёт",
                  color: Color(red: 0.99, green: 0.75, blue: 0.20)),
            Prize(title: "300 ₽", subtitle: "На следующий заказ",
                  color: Color(red: 0.13, green: 0.71, blue: 0.95)),
            Prize(title: "Промокод", subtitle: "Раздел Дом",
                  color: Color(red: 0.28, green: 0.53, blue: 0.96)),
            Prize(title: "Не повезло", subtitle: "В этот раз",
                  color: Color(red: 0.74, green: 0.24, blue: 0.65)),
            Prize(title: "Бесплатная", subtitle: "доставка",
                  color: Color(red: 0.96, green: 0.30, blue: 0.30)),
            Prize(title: "Бонус 300 ₽", subtitle: "На покупки",
                  color: Color(red: 0.99, green: 0.75, blue: 0.20)),
            Prize(title: "Сюрприз", subtitle: "Секретный приз",
                  color: Color(red: 0.13, green: 0.71, blue: 0.95))
        ]
    }
    
    
    var attemptsText: String {
        "Осталось попыток: \(remainingSpins) из \(maxSpins)"
    }
    
    var attemptsHint: String {
        "+1 попытка за каждые 1 000 ₽ в заказе"
    }
    
    func spinWheel() {
        guard !isSpinning, remainingSpins > 0 else { return }
        
        isSpinning = true
        remainingSpins -= 1
        currentPrize = nil
        
        let segmentCount = segments.count
        let segmentAngle = 360.0/Double(segmentCount)
        
        let winningIndex = Int.random(in: 0..<segmentCount)
        let extraTurns = 5
        
        let targetRotation = rotation
        - Double(extraTurns) * 360.0
        - Double(winningIndex) * segmentAngle
        
        withAnimation(.easeOut(duration: 3.0)) {
            rotation = targetRotation
        }
        
        let animationDuration = 3.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) { [weak self] in
            guard let self else { return }
            self.isSpinning = false
            self.currentPrize = self.segments[winningIndex]
            
        }
    }
    
    func resetSpins() {
        remainingSpins = maxSpins
    }
}
