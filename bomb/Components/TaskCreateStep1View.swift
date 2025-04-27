//
//  TaskCreateStep1.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//
import SwiftUI

struct TaskCreateStep1View: View{

    
    var body: some View{
        VStack(){
            Text("내가 할 일은?")
                .font(.system(size: 30, weight: .bold, design: .default))
                .shadow(radius: 5)
                .padding()
            ScrollView(){
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100)), count: 3)){
                    Button(action:{}){
                        Text("레포트")
                            .padding()
                            .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                        
                    }
                    .background(Color.init(hex: "151515").opacity(0.1).blur(radius: 2))
                    .cornerRadius(20)
                    Button(action:{}){
                        Text("시험")
                            .padding()
                            .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                        
                    }
                    .background(Color.init(hex: "151515").opacity(0.1).blur(radius: 2))
                    .cornerRadius(20)
                    Button(action:{}){
                        Text("발표")
                            .padding()
                            .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                        
                    }
                    .background(Color.init(hex: "151515").opacity(0.1).blur(radius: 2))
                    .cornerRadius(20)
                    
                    Button(action:{}){
                        Image(systemName: "plus")
                            .padding()
                            .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                        
                    }
                    .background(Color.init(hex: "151515").opacity(0.1).blur(radius: 2))
                    .cornerRadius(20)
                }
            }

        }
    }
}
