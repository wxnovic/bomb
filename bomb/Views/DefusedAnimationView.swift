//
//  BombDefuseView.swift
//  bomb
//
//  Created by Chu on 4/29/25.
//

import SwiftUI

struct DefusedAnimationView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var showBombDefuseView: Bool
    @Binding var isEnteringCode: Bool

    @State private var currentFrame = 0
    @State private var canTapBackButton = false

    private let frameImages = (2...30).map { "Defused-\($0)" }

    var body: some View {
        ZStack {
            Image("DefusedBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer().frame(height: 0)

                Image(frameImages[currentFrame])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)

                Spacer()

                if canTapBackButton {
                    Button(action: {
                        dismiss()
                        showBombDefuseView = false
                        isEnteringCode = false
                    }) {
                        Text("메인으로 돌아가기")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.bottom, 80)
                }
            }

            VStack {
                Spacer()
                Text("폭탄 해체 성공!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom, 300)
            }
        }
        .onAppear {
            startAnimation()
            startAllowTapTimer()
        }
    }

    // MARK: - Animation Functions

    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1.0 / 15.0, repeats: true) { _ in
            currentFrame = (currentFrame + 1) % frameImages.count
        }
    }

    private func startAllowTapTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation {
                canTapBackButton = true
            }
        }
    }
}
