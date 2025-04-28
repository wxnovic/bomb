//
//  TaskCreateStep1.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//
import SwiftUI
import SwiftData

struct TaskCreateStep1View: View{
    
    var formData: TaskFormData;
    
    @Query private var categories: [CategoryModel]
    
    @State private var selectedCategory:Int? = nil
    
    var body: some View{
        
        VStack(){
            Text("내가 할 일은?")
                .font(.system(size: 30, weight: .bold, design: .default))
                .shadow(radius: 5)
                .padding()
            ScrollView(){
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100)), count: 3)){
                    ForEach(categories, id: \.self) { category in
                        Button(action:{
                            selectedCategory = category.id
                            formData.categoryId = category.id
                            formData.itemIds.removeAll()
                        }){
                            Text(category.title)
                                .padding()
                                .frame(width: 100, height: 50)
                                .foregroundColor(selectedCategory == category.id ? .white : .black)
                                .bold()
                                .shadow(radius: 5)
                            
                        }
                        .background(selectedCategory == category.id ?
                                    Color.init(hex: "0938DF").opacity(0.4).blur(radius: 2) :
                                    Color.init(hex: "151515").opacity(0.1).blur(radius: 2))
                        .cornerRadius(20)
                    }
                    
                    
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

        }.onAppear(){
            if(formData.categoryId != nil) {
                selectedCategory = formData.categoryId
            }
        }
    }
}
