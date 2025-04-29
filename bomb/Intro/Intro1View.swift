//
//  Intro2SignUpView.swift
//  bomb
//
//  Created by Chu on 4/29/25.
//

import SwiftUI

struct Intro1View: View {
    @EnvironmentObject var viewRouter: AppViewRouter

    // 등장 제어
    @State private var showCharacter = false
    @State private var showCalendar = false
    @State private var showBomb = false
    @State private var showButtons = false

    // 흔들림 애니메이션 제어
    @State private var animateCalendarMove = false
    @State private var animateBombMove = false

    // 위치 조정용 변수 (X, Y 따로)
    @State private var characterX: CGFloat = 50
    @State private var characterY: CGFloat = 195

    @State private var bombX: CGFloat = -90
    @State private var bombY: CGFloat = 60

    @State private var calendarX: CGFloat = -110
    @State private var calendarY: CGFloat = 195

    @State private var textX: CGFloat = 0
    @State private var textY: CGFloat = 300

    @State private var buttonX: CGFloat = 0
    @State private var buttonY: CGFloat = 0

    var body: some View {
        ZStack {
            // 배경
            Image("intro_wallpaper")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer().frame(height: 30)

                if showCharacter || showCalendar || showBomb {
                    ZStack {
                        // 폭탄
                        if showBomb {
                            Image("intro1_bomb")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 220, height: 220)
                                .offset(x: bombX,
                                        y: bombY + (animateBombMove ? 10 : -10))
                                .scaleEffect(showBomb ? 1 : 0.8)
                                .opacity(showBomb ? 1 : 0)
                        }

                        // 달력
                        if showCalendar {
                            Image("intro1_calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 140)
                                .offset(x: calendarX,
                                        y: calendarY + (animateCalendarMove ? 10 : -10))
                                .scaleEffect(showCalendar ? 1 : 0.8)
                                .opacity(showCalendar ? 1 : 0)
                        }

                        // 캐릭터
                        if showCharacter {
                            Image("intro1_character")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260, height: 340)
                                .offset(x: characterX, y: characterY)
                                .scaleEffect(showCharacter ? 1 : 0.8)
                                .opacity(showCharacter ? 1 : 0)
                        }
                    }
                    .padding(.bottom, 50)
                }

                Spacer()

                if showButtons {
                    VStack(spacing: 16) {
                        // 텍스트
                        HStack(spacing: 0) {
                            Text("BOMB")
                                .font(.system(size: 32, weight: .black))
                                .foregroundColor(.black)
                                .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 2)
                            Text("바르딜로")
                                .font(.system(size: 32, weight: .black))
                                .foregroundColor(Color.yellow)
                                .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 2)
                        }
                        .offset(x: 0, y: -480)
                        .transition(.opacity)
                        .animation(.easeIn(duration: 0.8), value: showButtons)

                        // 버튼들
                        HStack(spacing: 20) {
                            Button(action: {
                                viewRouter.currentPage = .intro3Login
                            }) {
                                Button(action: {
                                    viewRouter.currentPage = .intro3Login
                                }) {
                                    Text("로그인")
                                        .frame(width: 140, height: 50)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(25)
                                }
                                .scaleEffect(showButtons ? 1.0 : 0.95) // ✅ 눌릴 때 살짝 줄었다가 복원
                                .animation(.easeInOut(duration: 0.2), value: showButtons) // ✅ 부드럽게

                            }

                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.8)) {
                                    viewRouter.currentPage = .intro2SignUp
                                }
                            }) {
                                Text("회원가입")
                                    .frame(width: 140, height: 50)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(25)
                            }
                            .scaleEffect(showButtons ? 1.0 : 0.95)
                            .animation(.easeInOut(duration: 0.2), value: showButtons)

                        }
                        .offset(x: 0, y: -50)
                        .transition(.opacity)
                        .animation(.easeIn(duration: 0.8), value: showButtons)

                        // Skip
                        Text("Skip >>")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.top, 10)
                    }
                    .padding(.bottom, 40)
                }
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            // 캐릭터 등장
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeOut(duration: 0.5)) {
                    showCharacter = true
                }
            }
            // 캘린더 등장 + 흔들림
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation(.easeOut(duration: 0.5)) {
                    showCalendar = true
                }
                withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    animateCalendarMove.toggle()
                }
            }
            // 폭탄 등장 + 흔들림
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
                withAnimation(.easeOut(duration: 0.5)) {
                    showBomb = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(Animation.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
                        animateBombMove.toggle()
                    }
                }
            }
            // 버튼과 텍스트 등장
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeIn(duration: 0.8)) {
                    showButtons = true
                }
            }
        }
    }
}
