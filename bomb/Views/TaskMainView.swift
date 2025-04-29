//
//  TaskMainView.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//
import SwiftUI
import SwiftData

struct TaskMainView: View {
    @Environment(\.modelContext) private var context
    @Query var tasks: [TaskModel]
    @StateObject var tabRouter = TabRouter()
    
    @State private var remainingTime: TimeInterval = 0
    @State private var timer: Timer? = nil

    
    @State private var showBombDefuseView = false
    
    @State private var showBomb = false
    @State private var showTasks = false
    @State private var bombVerticalOffset: CGFloat = 0

    @State private var isEnteringCode = false
    @State private var input = ""
    @State private var expandedScale: CGFloat = 0.2
    @State private var expandedOffset: CGSize = .zero
    @State private var keypadOffsetY: CGFloat = 800

    @State private var bombPassword: String = ""
    @State private var showSuccessView = false
    @State private var showFailurePopup = false

    let bombCenter = CGPoint(x: 41 + 319/2, y: (52 + 319/2) - 50)
    let expandedFinalCenter = CGPoint(x: 31 + 337/2, y: (175 + 172/2) - 50)

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                mainContent(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }

    // MARK: - Main Content

    @ViewBuilder
    private func mainContent(width: CGFloat, height: CGFloat) -> some View {
        ZStack {
            backgroundView()

            VStack(spacing: 20) {
                if showBomb {
                    bombView()
                }
                if showTasks {
                    
                    tasksView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .position(x: width / 2, y: height * 0.45)

            if isEnteringCode {
                enteringCodeLayer()
            }
        }
        .onAppear {
            fetchTodayBomb()
            showInSequence()
            startTimer()
        }
        .fullScreenCover(isPresented: $showSuccessView) {
            DefusedAnimationView(
                showBombDefuseView: $showBombDefuseView,
                isEnteringCode: $isEnteringCode
            )
        }
        .overlay(
            failurePopupView()
                .opacity(showFailurePopup ? 1 : 0)
        )
    }

    // MARK: - Background

    @ViewBuilder
    private func backgroundView() -> some View {
        Image("background")
            .resizable()
            .ignoresSafeArea()
    }

    // MARK: - Bomb View

    @ViewBuilder
    private func bombView() -> some View {
        ZStack {
            Image("bomb")
                .resizable()
                .frame(width: 300, height: 300)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        isEnteringCode = true
                        animateExpandedNumberInput()
                        animateKeypad()
                    }
                }

            Text(formatTime(remainingTime))
                .foregroundColor(.green)
                .font(.title)
                .offset(x: 2, y: 16)
                .zIndex(1)

        }
        .padding()
        .shadow(radius: 10)
        .frame(width: 300, height: 250)
        .offset(y: bombVerticalOffset)
        .transition(.scale)
    }

    // MARK: - Tasks View

    @ViewBuilder
    private func tasksView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.15))
                .frame(width: 320, height: 380)

            VStack(spacing: 12) {
                Text("04/29 Tue") // ❗ 나중에 현재 날짜 자동으로 넣게 수정 가능
                    .foregroundColor(Color("daycolor1"))
                    .font(.headline)
                    .bold()
                    .padding(.top, 8)

                taskListView()
            }
            .frame(width: 412, height: 338)
        }
        .transition(.opacity.combined(with: .scale))
    }

    @ViewBuilder
    private func taskListView() -> some View {
        if tabRouter.isCompleted == 1{

            ScrollView {
                VStack(spacing: 20) {
                    ForEach(tasks.chunked(into: 2), id: \.self) { taskRow in
                        HStack(spacing: 40) {
                            ForEach(taskRow, id: \.id) { task in
                                TaskPaper(onDone: {
                                    setIsDone(Int64(task.id))
                                }, task: task)
                            }
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 16)
            }
        }
    }

    // MARK: - Entering Code Layer

    @ViewBuilder
    private func enteringCodeLayer() -> some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .transition(.opacity)
                .zIndex(1)

            ExpandedNumberInputView(input: $input)
                .frame(width: 337, height: 172)
                .scaleEffect(expandedScale)
                .position(
                    x: bombCenter.x + expandedOffset.width,
                    y: bombCenter.y + expandedOffset.height - 50
                )
                .zIndex(2)

            KeypadView(
                input: $input,
                isEnteringCode: $isEnteringCode,
                bombPassword: $bombPassword,
                showSuccessView: $showSuccessView,
                showFailurePopup: $showFailurePopup
            )
            .offset(y: keypadOffsetY)
            .animation(.easeOut(duration: 0.5).delay(0.2), value: keypadOffsetY)
            .position(x: UIScreen.main.bounds.width/2, y: (371 - 50) + 468/2 - 50)
            .zIndex(3)
        }
    }

    // MARK: - Failure Popup

    @ViewBuilder
    private func failurePopupView() -> some View {
        VStack {
            Spacer()
                .frame(height: 100)

            Text("오류입니다")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.black.opacity(0.8))
                .cornerRadius(20)
                .shadow(radius: 6)
                .transition(.opacity.combined(with: .scale))
                .animation(.easeInOut(duration: 0.3), value: showFailurePopup)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Animations

    private func animateExpandedNumberInput() {
        withAnimation(.easeOut(duration: 1.0)) {
            expandedScale = 1.0
            expandedOffset = CGSize(
                width: expandedFinalCenter.x - bombCenter.x,
                height: expandedFinalCenter.y - bombCenter.y
            )
        }
    }

    private func animateKeypad() {
        withAnimation(.easeOut(duration: 2.0).delay(0.3)) {
            keypadOffsetY = 0
        }
    }

    private func showInSequence() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { withAnimation { showBomb = true } }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                bombVerticalOffset = -20
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) { withAnimation { showTasks = true } }
    }

    // MARK: - Data Functions

    private func setIsDone(_ id: Int64) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        tasks[index].isDone = true
        try? context.save()
    }

    private func fetchTodayBomb() {
        let today = Date()
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: today)
        let startOfNextDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        let descriptor = FetchDescriptor<BombModel>(
            predicate: #Predicate { bomb in
                bomb.createdAt >= startOfDay && bomb.createdAt < startOfNextDay
            }
        )

        do {
            let bombs = try context.fetch(descriptor)
            if let todayBomb = bombs.first {
                bombPassword = todayBomb.password
            } else {
                print("⚠️ 오늘 Bomb이 없습니다.")
            }
        } catch {
            print("❌ Bomb fetch 실패: \(error)")
        }
    }
    private func startTimer() {
        let calendar = Calendar.current
        let now = Date()
        let startOfTomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: now)!)

        remainingTime = startOfTomorrow.timeIntervalSince(now)

      
    }

    private func formatTime(_ timeInterval: TimeInterval) -> String {
        let totalMinutes = Int(timeInterval) / 60
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return String(format: "%02d : %02d", hours, minutes)
    }
}




#Preview {
    TaskMainView()
}
