//
//  BombDefuseView.swift
//  bomb
//
//  Created by Chu on 4/29/25.
//

import SwiftUI

// 📦 숫자 입력창 (ExpandedNumberInputView)
struct ExpandedNumberInputView: View {
    @Binding var input: String

    var body: some View {
        ZStack {
            Image("expandedNumberInput")
                .resizable()
                .frame(width: 337, height: 172)
            
            Text(input)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

// 📦 키패드 (KeypadView)
struct KeypadView: View {
    @Binding var input: String
    @Binding var isEnteringCode: Bool

    // ✅ Bomb password 받아오기
    @Binding var bombPassword: String

    // ✅ 성공/실패를 판단하는 상태 추가
    @Binding var showSuccessView: Bool
    @Binding var showFailurePopup: Bool

    let keys = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["<", "0", "OK"]
    ]

    var body: some View {
        ZStack {
            Image("keypadBackground")
                .resizable()
                .frame(width: 375, height: 468)

            VStack(spacing: 16) {
                ForEach(0..<4, id: \.self) { row in
                    HStack(spacing: 22) {
                        ForEach(0..<3, id: \.self) { col in
                            let key = keys[row][col]
                            Button(action: {
                                buttonTapped(key)
                            }) {
                                Text(key)
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                                    .frame(width: 90, height: 90)
                                    .background(Color.clear)
                                    .contentShape(Rectangle())
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
        .frame(width: 375, height: 468)
    }

    private func buttonTapped(_ key: String) {
        switch key {
        case "<":
            if !input.isEmpty {
                input.removeLast()
            }
        case "OK":
            if input == bombPassword {
                // ✅ 비밀번호 일치: 성공 화면으로
                withAnimation {
                    showSuccessView = true
                }
            } else {
                // ✅ 비밀번호 불일치: 오류 팝업 띄우고 메인화면 복귀
                withAnimation {
                    showFailurePopup = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        showFailurePopup = false
                        isEnteringCode = false
                        input = ""
                    }
                }
            }
        default:
            input.append(key)
        }
    }
}
