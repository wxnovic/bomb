//
//  Untitled.swift
//  zota
//
//  Created by 예나 on 4/25/25.
//
import SwiftUI

// 📦 요일 박스 뷰
struct DayTaskBox: View {
    let day: String
    let date: Date
    let isToday: Bool
    var onTap: () -> Void

    var body: some View {
        VStack(spacing: 6) {
            Text(formattedDate(date)) // 예: 4/26
                .font(.subheadline)
                .foregroundColor(isToday ? .red : Color(hex: "005B00"))
                .shadow(color: .black.opacity(0.25), radius: 1, x: 1, y: 1) // 텍스트 그림자

            Text(day)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(isToday ? .red : Color(hex: "005B00"))
                .shadow(color: .black.opacity(0.25), radius: 1, x: 1, y: 1) // 텍스트 그림자
        }
        .frame(width: 80, height: 110)
        .background(
            Color(hex: "E7EAF4")
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.3), radius: 6, x: 4, y: 6) // ✅ 박스 음영 더 진하고 깊게
        )
        .onTapGesture {
            onTap()
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter.string(from: date)
    }
}





// 🌈 메인 캘린더 뷰

struct TaskCalendar: View {
    let dates: [Date]

    init() {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        let start = calendar.date(from: DateComponents(year: 2025, month: 4, day: 28))!
        dates = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
    }

    @State private var selectedDate: Date? = nil
    @State private var showPopup = false

    var body: some View {
        ZStack {
            VStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                Spacer()
            }

            VStack(spacing: 100) {
                // ✅ 중앙 정렬된 타이틀
                Text("아차차.. 계획변경")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                // ✅ 요일 칸: 중앙 정렬 + 아래로 50 이동
                LazyVGrid(columns: [
                    GridItem(.fixed(80), spacing: 16),
                    GridItem(.fixed(80), spacing: 16),
                    GridItem(.fixed(80))
                ], spacing: 24) {
                    ForEach(dates, id: \.self) { date in
                        let isToday = Calendar.current.isDateInToday(date)
                        let day = formattedDay(date)

                        DayTaskBox(day: day, date: date, isToday: isToday) {
                            selectedDate = date
                            showPopup = true
                        }
                    }
                }
                .offset(y: -50) // ✅ 하단으로 50 이동
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60) // 상단 기본 여백

            if showPopup, let selected = selectedDate {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                TaskModifyPopup(date: selected) {
                    withAnimation {
                        showPopup = false
                    }
                }
                .transition(.scale)
                .zIndex(1)
                .offset(y: 110) // ✅ 팝업을 아래로 110 이동
            }

        }
        .animation(.easeInOut, value: showPopup)
    }

    func formattedDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
}


#Preview {
    TaskCalendar()
}
