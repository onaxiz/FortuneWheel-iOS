//
//  WheelGameView.swift
//  WheelFeature
//
//  Created by Евгения Максимова on 08.12.2025.
//

import SwiftUI

struct WheelGameView: View {
    @StateObject private var viewModel = WheelViewModel()
    
    var body: some View {
        ZStack {
            Color(red: 0.07, green: 0.38, blue: 0.96)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                header
                
                Spacer(minLength: 0)
                
                WheelView(
                    segments: viewModel.segments,
                    rotation: viewModel.rotation,
                    isSpinning: viewModel.isSpinning,
                    onSpinTap: { viewModel.spinWheel() }
                )
                .frame(width: 400, height: 400)
                
                VStack(spacing: 6) {
                    Text(viewModel.attemptsText)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                    
                    Text(viewModel.attemptsHint)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.white.opacity(0.85))
                }
                .padding(.top, 8)
                
                Spacer(minLength: 0)
                
                Button(action: {
                    viewModel.spinWheel()
                }, label: {
                    Text(viewModel.remainingSpins > 0 ? "Крутить бесплатно" : "Нет попыток")
                        .font(.system(size: 17, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(viewModel.remainingSpins > 0 && !viewModel.isSpinning ? Color.red : Color.gray)
                        .foregroundStyle(.white)
                        .cornerRadius(16)
                })
                .disabled(viewModel.remainingSpins == 0 || viewModel.isSpinning)
                .padding(.horizontal, 24)
                .padding(.bottom, 28)
            }
        }
    }
    
    private var header: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .padding(8)
                .background(Color.white.opacity(0.15))
                .clipShape(Circle())
            
            Spacer()
            
            VStack(spacing: 4) {
                Text("Колесо подарков")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                Text("Крути колесо и забирай призы за покупки")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.85))
            }
            
            Spacer()
            
            Image(systemName: "info.circle")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.white)
                .padding(8)
                .background(Color.white.opacity(0.15))
                .clipShape(Circle())
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

#Preview {
    WheelGameView()
}

#Preview {
    WheelGameView()
}

