//
//  Intro2View.swift
//  bomb
//
//  Created by Chu on 4/29/25.
//

import SwiftUI

struct Intro2View: View {
    @EnvironmentObject var viewRouter: AppViewRouter

    // 입력 데이터
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""

    // 상태 제어
    @State private var animateIntro2 = false
    @State private var animateForm = false
    @State private var isSigningUp = false
    @State private var animateTitle = false
    @State private var showButton = false

    var body: some View {
        ZStack {
            // 전체 배경
            Image("intro_wallpaper")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer().frame(height: 40)

                // 상단 텍스트 + 상단 부분 배경 이미지
                ZStack {
                    Image("intro2_idcheck")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 260)
                        .opacity(0.3)

                    HStack(spacing: 0) {
                        Text("천리길도")
                            .foregroundColor(.black)
                            .shadow(color: .gray.opacity(0.5), radius: 2, x: 2, y: 2)
                        Text(" ID부터")
                            .foregroundColor(.yellow)
                            .shadow(color: .gray.opacity(0.5), radius: 2, x: 2, y: 2)
                    }
                    .font(.system(size: 40, weight: .black))
                    .scaleEffect(animateTitle ? 1.0 : 0.8)
                    .opacity(animateTitle ? 1.0 : 0.0)
                    .animation(.easeOut(duration: 1.0), value: animateTitle)
                }
                .padding(.bottom, 10)

                // 입력창 폼
                VStack(spacing: 16) {
                    TextField("이름을 입력하세요", text: $name)
                        .padding()
                        .background(Color(.systemGray6).opacity(0.9))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .onChange(of: name) { _ in
                            checkInputCompletion()
                        }

                    TextField("이메일을 입력하세요", text: $email)
                        .padding()
                        .background(Color(.systemGray6).opacity(0.9))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .onChange(of: email) { _ in
                            checkInputCompletion()
                        }

                    SecureField("비밀번호를 입력하세요", text: $password)
                        .padding()
                        .background(Color(.systemGray6).opacity(0.9))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .onChange(of: password) { _ in
                            checkInputCompletion()
                        }
                }
                .opacity(animateForm ? 1.0 : 0.0)
                .offset(y: animateForm ? 0 : 50)
                .animation(.easeOut(duration: 1.0), value: animateForm)

                // 입력창과 버튼 사이 여백
                Spacer().frame(height: 60)

                // 회원가입 완료 버튼
                if showButton {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isSigningUp = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(.easeInOut(duration: 0.8)) {
                                viewRouter.currentPage = .intro1
                            }
                        }
                    }) {
                        Text(isSigningUp ? "기억하는 중..." : "완료")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isSigningUp ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .padding(.horizontal, 50)
                    }
                    .disabled(isSigningUp)
                    .scaleEffect(isSigningUp ? 0.95 : 1.0)
                    .opacity(showButton ? 1.0 : 0.0)
                    .offset(y: showButton ? 0 : 20)
                    .animation(.easeOut(duration: 0.8), value: showButton)
                }

                Spacer()
            }
        }
        .scaleEffect(animateIntro2 ? 1.0 : 0.8)
        .opacity(animateIntro2 ? 1.0 : 0.0)
        .animation(.easeOut(duration: 0.8), value: animateIntro2)
        .onAppear {
            animateIntro2 = true

            // 0.5초 후 상단 텍스트 등장
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animateTitle = true
            }

            // 1.5초 후 입력창 등장
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 1.0)) {
                    animateForm = true
                }
            }
        }
    }

    // 이름, 이메일, 비밀번호 모두 입력되었는지 확인
    private func checkInputCompletion() {
        if !name.isEmpty && !email.isEmpty && !password.isEmpty {
            withAnimation(.easeOut(duration: 0.8)) {
                showButton = true
            }
        } else {
            withAnimation(.easeOut(duration: 0.8)) {
                showButton = false
            }
        }
    }
}
