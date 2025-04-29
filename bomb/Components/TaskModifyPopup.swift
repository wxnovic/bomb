//
//  Untitled.swift
//  zota
//
//  Created by 윤 on 4/25/25.
//

import SwiftUI

struct TaskModifyPopup: View {
    let date: Date
    let onClose: () -> Void

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(hex: "E9EAF0"))
                    .frame(width: 300, height: 550)
                    .cornerRadius(30)
                    .padding(.top, 75)

                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(formatDate(date))
                                .font(.title3)
                                .foregroundColor(.black)
                            Text(formatDay(date))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Button(action: {
                            onClose()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 50)

                    Spacer()
                }
                .frame(width: 300, height: 550)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // 날짜 (MM.dd 포맷)
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        return formatter.string(from: date)
    }

    // 요일 (Mon, Tue 등 포맷)
    func formatDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date).uppercased()
    }
}
