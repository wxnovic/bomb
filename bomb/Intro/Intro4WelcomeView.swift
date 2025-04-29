//
//  Intro4LoginView.swift
//  bomb
//
//  Created by Chu on 4/29/25.
//

import SwiftUI

struct Intro4WelcomeView: View {
    @EnvironmentObject var viewRouter: AppViewRouter

    @State private var appear = false
    @State private var bounce = false

    var body: some View {
        ZStack {
            // 배경
            Image("main_wallpaper")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer()

                VStack(spacing: 20) {
                    // 폭탄 어셋
                    Image("intro4_bomb")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .scaleEffect(appear ? 1.0 : 1.2)
                        .opacity(appear ? 1.0 : 0.0)
                        .animation(.easeOut(duration: 1.0), value: appear)

                    // 텍스트 (오늘도 파이팅 + 브라이언)
                    HStack(spacing: 0) {
                        Text("오늘도 파이팅 ")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                            .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 2)

                        Text("브라이언!")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.yellow)
                            .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 2)
                            .offset(y: bounce ? -10 : 0) // ✅ 위로 10포인트 튀기
                            .animation(
                                .interpolatingSpring(stiffness: 300, damping: 5)
                                    .repeatCount(2, autoreverses: true),
                                value: bounce
                            )
                    }
                    .scaleEffect(appear ? 1.0 : 1.2)
                    .opacity(appear ? 1.0 : 0.0)
                    .animation(.easeOut(duration: 1.0), value: appear)
                }

                Spacer()
            }
            .opacity(appear ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.8), value: appear)
        }
        .onAppear {
            withAnimation {
                appear = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                bounce = true // ✅ 브라이언 튀기 시작
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // ✅ 충분히 기다리고
                viewRouter.currentPage = .main
            }
        }
    }
}
