//
//  TaskPaper.swift
//  bomb
//
//  Created by Chu on 4/29/25.
//

import SwiftUI

struct TaskPaper2: View {
    @State public var title: String
    @State public var password: String
    var onDone: (() -> Void)? = nil


    @State private var isDone: Bool = false
    @State private var dragOffset: CGSize = .zero
    @State private var showCheck = false
    @State private var checkScale: CGFloat = 0.6
    @State private var checkOpacity: Double = 0
    @State private var showCountText = false
    @State private var countOffset: CGFloat = 10
    @State private var countOpacity: Double = 0

    var body: some View {
        ZStack {
            if showCheck {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
                    .scaleEffect(checkScale)
                    .opacity(checkOpacity)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(3)
            }

            if showCountText {
                Text(password)
                    .font(.title)
                    .foregroundColor(.green)
                    .bold()
                    .offset(y: countOffset)
                    .opacity(countOpacity)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(2)
            }


            if !isDone {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "D9D9D9"))
                        .frame(width: 100, height: 130)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)

                    Image("tear-line")
                        .resizable()
                        .frame(width: 95, height: 10)
                        .offset(x: 0, y: -30)

                    Image("paper")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .offset(
                            x: dragOffset.width / 5,
                            y: 15 + dragOffset.height / 5
                        )
                        .rotationEffect(
                            .degrees(Double(dragOffset.height) / 5),
                            anchor: .topLeading
                        )
                        .opacity(isDone ? 0 : 1)

                    VStack(spacing: 4) {
                        Image("fire")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.top, 8)

                        Spacer()

                        Text(title)
                            .foregroundColor(.black)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 40)
                            .frame(width: 80)
                    }
                    .frame(width: 100, height: 130)
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.width < 0 {
                                dragOffset = value.translation
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < 0 && abs(value.translation.height) > 80 {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isDone = true
                                }
                                onDone?() // ✅ 저장 요청
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                        showCheck = true
                                        checkScale = 1.0
                                        checkOpacity = 1.0
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                                    withAnimation(.easeOut(duration: 0.3)) {
                                        showCheck = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        withAnimation(.easeOut(duration: 0.6)) {
                                            showCountText = true
                                            countOffset = -20
                                            countOpacity = 1.0
                                        }
                                    }
                                }
                            } else {
                                withAnimation(.spring()) {
                                    dragOffset = .zero
                                }
                            }
                        }
                )
            }
        }
        .frame(width: 100, height: 130)
    }
}
