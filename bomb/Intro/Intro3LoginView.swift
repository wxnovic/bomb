//
//  D.swift
//  bomb
//
//  Created by Chu on 4/29/25.
//

import SwiftUI

struct Intro3LoginView: View {
    @EnvironmentObject var viewRouter: AppViewRouter

    @State private var showBackground = false
    @State private var showTitle = false
    @State private var titleOffset: CGFloat = 0
    @State private var titleScale: CGFloat = 1.2
    @State private var showInputFields = false
    @State private var showBurger = false
    @State private var isLoggingIn = false // ✅ 로그인 페이드아웃용

    @State private var email = ""
    @State private var password = ""
    @State private var showLoginButton = false

    var body: some View {
        ZStack {
            // 배경
            if showBackground {
                Image("intro_wallpaper")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.0), value: showBackground)
            }

            VStack {
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.8)) {
                            viewRouter.currentPage = .intro1
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.leading, 10)

                Spacer()
            }
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                // "시작이 반이다" 텍스트
                if showTitle {
                    HStack(spacing: 0) {
                        Text("시작이 ")
                            .foregroundColor(.black)
                            .font(.system(size: 32, weight: .bold))
                            .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 1)

                        Text("반")
                            .foregroundColor(.yellow)
                            .font(.system(size: 42, weight: .bold))
                            .shadow(color: .gray.opacity(1.0), radius: 3, x: 1, y: 2)

                        Text("이다")
                            .foregroundColor(.black)
                            .font(.system(size: 32, weight: .bold))
                            .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 1)
                    }
                    .scaleEffect(titleScale)
                    .offset(y: titleOffset)
                    .opacity(showTitle ? 1.0 : 0.0)
                    .animation(.easeOut(duration: 1.0), value: showTitle)
                    .animation(.easeOut(duration: 1.0), value: titleOffset)
                    .animation(.easeOut(duration: 1.0), value: titleScale)
                }

                Spacer()

                // 입력창
                if showInputFields {
                    VStack(spacing: 16) {
                        TextField("이메일을 입력하세요", text: $email)
                            .padding()
                            .background(Color(.systemGray6).opacity(0.9))
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                            .onChange(of: email) { _ in checkInputCompletion() }

                        SecureField("비밀번호를 입력하세요", text: $password)
                            .padding()
                            .background(Color(.systemGray6).opacity(0.9))
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                            .onChange(of: password) { _ in checkInputCompletion() }
                    }
                    .offset(y: -60)
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.0), value: showInputFields)
                }

                Spacer()
            }
            .padding(.top, 80)

            // burger 어셋
            if showBurger {
                VStack {
                    Spacer()
                    Image("intro3_burger")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .opacity(0.25)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1.0), value: showBurger)
                        .offset(y: -85)
                    Spacer()
                }
            }

            // 로그인 버튼
            if showLoginButton {
                VStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.8)) {
                            isLoggingIn = true // ✅ 페이드아웃 부드럽게
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { // ✅ 충분히 기다리고
                            viewRouter.currentPage = .intro4Welcome
                        }
                    }) {
                        Text("로그인")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .padding(.horizontal, 50)
                    }
                    .scaleEffect(showLoginButton ? 1.0 : 0.8)
                    .opacity(showLoginButton ? 1.0 : 0.0)
                    .animation(.easeOut(duration: 0.8), value: showLoginButton)
                    .padding(.bottom, 80)
                }
            }

            // 최상단 페이드아웃 레이어 (잔상 완전 제거)
            Color.white
                .opacity(isLoggingIn ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.8), value: isLoggingIn)
                .ignoresSafeArea()
        }
        .onAppear {
            animateIntro()
        }
    }

    private func animateIntro() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                showBackground = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.easeOut(duration: 1.0)) {
                showTitle = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            withAnimation(.easeOut(duration: 1.0)) {
                titleScale = 1.0
                titleOffset = -20
                showBurger = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            withAnimation(.easeOut(duration: 1.0)) {
                showInputFields = true
            }
        }
    }

    private func checkInputCompletion() {
        if !email.isEmpty || !password.isEmpty {
            withAnimation(.easeOut(duration: 0.8)) {
                showLoginButton = true
            }
        } else {
            withAnimation(.easeOut(duration: 0.8)) {
                showLoginButton = false
            }
        }
    }
}
