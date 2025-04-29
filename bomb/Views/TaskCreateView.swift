//
//  TaskCreate.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//



import SwiftUI
import SwiftData

class TaskDateData {
    
    
    @Published var id: Int
    @Published var date: Date
    
    init (id: Int, date: Date) {
        self.id = id
        self.date = date
    }
}

class TaskFormData: ObservableObject {
    @Published var categoryId: Int?
    @Published var dayCount: Int?
    @Published var itemIds: [Int] = []
    @Published var taskTempData: [[Int]] = []
}

struct TaskCreateView: View {
    @EnvironmentObject var tabRouter: TabRouter
    @StateObject private var formData: TaskFormData = TaskFormData()
    
    @Environment(\.modelContext) private var modelContext
    
    @State var step: Int = 1
    @State var bombDegrees: Double = 0
    @State var backgroundBombDegrees: Double = 280
    
    
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "M/d" // "5/1" 이런 스타일
        return f
    }()
    
    var body: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width
            let height = geometry.size.height
            
            // -------------------------------------------------------------------
            // 배경화면
            // -------------------------------------------------------------------
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea(edges: .all)
                
                Image("bomb")
                    .resizable()
                    .rotationEffect(.degrees(backgroundBombDegrees))
                    .frame(width: 1000, height: 1000)
                    .position(x: width, y: height)
                    
                // -------------------------------------------------------------------
                // Step 1
                // -------------------------------------------------------------------
                if step == 1 {
                    TaskCreateStep1View(formData: formData)
                        .frame(width: width - 20, height: 300, alignment: .top)
                        .background(Color.init(hex: "151515").opacity(0.2).blur(radius: 30))
                        .cornerRadius(20)
                }
                // -------------------------------------------------------------------
                // Step 2
                // -------------------------------------------------------------------
                else if step == 2 {
                    if(formData.categoryId != -1) {
                        TaskCreateStep2View(formData: formData)
                            .frame(width: width - 20, height: 300, alignment: .top)
                            .background(Color.init(hex: "151515").opacity(0.2).blur(radius: 30))
                            .cornerRadius(20)
                    }
                }
                
                // -------------------------------------------------------------------
                // Step 3
                // -------------------------------------------------------------------
                else if step == 3 {
                    TaskCreateStep3View(formData: formData)
                        .frame(width: width - 20, height: 300, alignment: .top)
                        .background(Color.init(hex: "151515").opacity(0.2).blur(radius: 30))
                        .cornerRadius(20)
                }
                
                // -------------------------------------------------------------------
                // Step 4
                // -------------------------------------------------------------------
                else if step == 4 {
                    TaskCreateStep4View(formData: formData)
                }
                
                // 하단 버튼 수정
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            if step > 1 {
                                withAnimation(.easeInOut) {
                                    step -= 1
                                    backgroundBombDegrees -= 10
                                }
                            }
                        }) {
                            Text("이전")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 120, height: 50)
                                .background(Color.gray.opacity(0.8))
                                .cornerRadius(15)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            if step < 4 {
                                withAnimation(.easeInOut) {
                                    step += 1
                                    backgroundBombDegrees += 10
                                }
                            } else if step == 4 {
                                tabRouter.selectedTab = 0
                                step = 1
                                tabRouter.isCompleted = 1
                            }
                        }) {
                            Text(step == 4 ? "완료" : "다음")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 120, height: 50)
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 30)
                }

                
            }
        }
    }
}

#Preview {
    TaskCreateView()
}
