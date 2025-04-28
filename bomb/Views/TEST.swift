//
//  TEST.swift
//  bomb
//
//  Created by emdas93 on 4/28/25.
//

import SwiftUI

struct TEST: View {
    let dates = ["4/10", "4/13", "4/17", "4/20", "4/21", "4/23", "4/27"]
    
    // ✅ 상태 변수 추가
    @State private var selectedDate: String? = nil
    @State private var showCelebrationImage = false
    
    var body: some View {
        ZStack(alignment: .top) {
            // 📦 배경
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // 📦 폭탄
            Image("bomb")
                .resizable()
                .frame(width: 1000, height: 1000)
                .position(x: 500, y: 500)
            
            // 📦 날짜 버튼 + 화살표
            HStack(spacing: 16) {
                // 왼쪽 화살표
                Image("leftArrow")
                    .resizable()
                    .frame(width: 24, height: 24)
                
                // 날짜 버튼들
                VStack(spacing: 10) {
                    HStack(spacing: 16) {
                        ForEach(0..<3, id: \.self) { index in
                            DateButton(
                                dateText: dates[index],
                                selectedDate: $selectedDate,
                                showCelebrationImage: $showCelebrationImage
                            )
                        }
                    }
                    HStack(spacing: 10) {
                        ForEach(3..<7, id: \.self) { index in
                            DateButton(
                                dateText: dates[index],
                                selectedDate: $selectedDate,
                                showCelebrationImage: $showCelebrationImage
                            )
                        }
                    }
                }
                
                // 오른쪽 화살표
                Image("right_arrow")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding(.top, 100)
            
            // 📦 축하 이미지 애니메이션
            if showCelebrationImage {
                Image("successDiary") // ✅ 에셋 이름 확인
                    .resizable()
                    .frame(width: 200, height: 200)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height + 100)
                    .offset(y: showCelebrationImage ? -UIScreen.main.bounds.height / 2 - 100 : 0)
                    .animation(.easeOut(duration: 1.0), value: showCelebrationImage)
            }
        }
    }
}

// 📦 날짜 버튼 컴포넌트
struct DateButton: View {
    let dateText: String
    @Binding var selectedDate: String?
    @Binding var showCelebrationImage: Bool
    
    var body: some View {
        Button(action: {
            if dateText == "4/27" {
                selectedDate = dateText
                showCelebrationImage = true
            }
        }) {
            Text(dateText)
                .font(.system(size: 18, weight: .bold))
                .frame(width: 65, height: 55)
                .background(backgroundColor(for: dateText))
                .cornerRadius(24)
                .foregroundColor(textColor(for: dateText))
        }
    }
    
    // 📦 버튼 배경색 설정
    func backgroundColor(for date: String) -> Color {
        if selectedDate == date {
            return Color.blue // 선택되면 파란색
        } else {
            return Color(.systemGray6) // 기본 배경
        }
    }
    
    // 📦 버튼 텍스트 색상 설정
    func textColor(for date: String) -> Color {
        if date == "4/10" || date == "4/17" {
            return Color.red
        } else {
            return Color.green
        }
    }
}

#Preview {
    TEST()
}
