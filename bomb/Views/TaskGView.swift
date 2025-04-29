//
//  TaskGView.swift
//  bomb
//
//  Created by Chu on 4/29/25.
//

import SwiftUI

// 메인 화면
struct TaskGView: View {
    @State private var selectedIndex = 6
    @State private var showPaper = false
    @State private var showingLastWeek = false
    
    // 이번주 날짜 데이터
    let thisWeekDates: [FakeDateStatus] = [
        FakeDateStatus(dateText: "4/10", status: .fail),
        FakeDateStatus(dateText: "4/13", status: .success),
        FakeDateStatus(dateText: "4/17", status: .fail),
        FakeDateStatus(dateText: "4/20", status: .success),
        FakeDateStatus(dateText: "4/21", status: .success),
        FakeDateStatus(dateText: "4/23", status: .success),
        FakeDateStatus(dateText: "4/27", status: .fail)
    ]
    
    // 지난주 날짜 데이터
    let lastWeekDates: [FakeDateStatus] = [
        FakeDateStatus(dateText: "3/15", status: .fail),
        FakeDateStatus(dateText: "4/3", status: .success),
        FakeDateStatus(dateText: "4/6", status: .fail)
    ]
    
    // 보여줄 데이터
    var showingDates: [FakeDateStatus] {
        showingLastWeek ? lastWeekDates : thisWeekDates
    }
    
    var body: some View {
        ZStack {
            // 1. 배경 그라데이션
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "#C8E4FF"),
                    Color(hex: "#BABEE6")
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // 2. 폭탄 이미지
            Image("BombLogBack")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .clipped()
                .ignoresSafeArea(edges: .bottom)
            
            // 3. 메인 레이아웃
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        // ◀️ 왼쪽 화살표
                        if !showingLastWeek {
                            Button(action: {
                                showingLastWeek = true
                                selectedIndex = 0
                                restartPaperAnimation()
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                    .foregroundColor(.blue.opacity(0.7))
                            }
                        }
                        
                        ForEach(0..<3, id: \.self) { index in
                            if index < showingDates.count {
                                let item = showingDates[index]
                                DateButton(
                                    dateText: item.dateText,
                                    status: item.status,
                                    isSelected: selectedIndex == index
                                )
                                .onTapGesture {
                                    selectDate(index: index)
                                }
                            }
                        }
                        
                        // ▶️ 오른쪽 화살표
                        if showingLastWeek {
                            Button(action: {
                                showingLastWeek = false
                                selectedIndex = 6
                                restartPaperAnimation()
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.title2)
                                    .foregroundColor(.blue.opacity(0.7))
                            }
                        }
                    }
                    
                    HStack(spacing: 12) {
                        ForEach(3..<7, id: \.self) { index in
                            if index < showingDates.count {
                                let item = showingDates[index]
                                DateButton(
                                    dateText: item.dateText,
                                    status: item.status,
                                    isSelected: selectedIndex == index
                                )
                                .onTapGesture {
                                    selectDate(index: index)
                                }
                            }
                        }
                    }
                }
                .frame(height: 150)
                .padding(.top, 100)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // 종이+손+도장
                PaperView(
                    status: showingDates[selectedIndex].status,
                    showPaper: $showPaper
                )
                .frame(width: UIScreen.main.bounds.width * 0.95)
                .padding(.bottom, 250)
            }
        }
        .onAppear {
            showPaper = true
        }
    }
    
    // 날짜 선택시 호출
    private func selectDate(index: Int) {
        selectedIndex = index
        restartPaperAnimation()
    }
    
    // 종이 애니메이션 재시작
    private func restartPaperAnimation() {
        showPaper = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            showPaper = true
        }
    }
}

// 날짜 버튼 컴포넌트
struct DateButton: View {
    let dateText: String
    let status: StatusType
    let isSelected: Bool
    
    var body: some View {
        Text(dateText)
            .font(.headline)
            .foregroundColor(textColor)
            .frame(width: 60, height: 60)
            .background(backgroundColor)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
    
    private var textColor: Color {
        if isSelected {
            return .white
        }
        switch status {
        case .success:
            return .green
        case .fail:
            return .red
        case .none:
            return .gray
        }
    }
    
    private var backgroundColor: Color {
        isSelected ? Color.blue.opacity(0.7) : Color.white.opacity(0.9)
    }
}

// 종이+손+도장 컴포넌트
struct PaperView: View {
    let status: StatusType
    @Binding var showPaper: Bool
    @State private var showStamp = false
    
    var body: some View {
        ZStack {
            Image(status == .success ? "Log1" : "Log2")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.85)
                .scaleEffect(2.8)
                .offset(y: showPaper ? 0 : UIScreen.main.bounds.height)
                .animation(.easeOut(duration: 0.8), value: showPaper)
                .allowsHitTesting(false)
            
            if showStamp {
                Image(status == .success ? "Stamp-Defused" : "Stamp-Failed")
                    .resizable()
                    .frame(width: 270, height: 160)
                    .rotationEffect(Angle(degrees: -15))
                    .opacity(showStamp ? 1 : 0)
                    .scaleEffect(showStamp ? 1 : 0.7)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6), value: showStamp)
                    .offset(x: 15, y: 60)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                showStamp = true
            }
        }
        .onChange(of: showPaper) { _ in
            showStamp = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                showStamp = true
            }
        }
    }
}

// 데이터 모델
struct FakeDateStatus: Identifiable {
    let id = UUID()
    let dateText: String
    let status: StatusType
}

// 상태 타입
enum StatusType {
    case success
    case fail
    case none
}
