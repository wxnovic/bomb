//
//  LoginView.swift
//  bomb
//
//  Created by Aaron on 4/29/25.
//

import SwiftUI

struct Intro0View: View {
    @StateObject var viewRouter = AppViewRouter()

    var body: some View {
        VStack {
            switch viewRouter.currentPage {
            case .intro1:
                Intro1View()
                    .environmentObject(viewRouter) // ✅
            case .intro2SignUp:
                Intro2View()
                    .environmentObject(viewRouter) // ✅
            case .intro3Login:
                Intro3LoginView()
                    .environmentObject(viewRouter) // ✅
            case .intro4Welcome:
                Intro4WelcomeView()
                    .environmentObject(viewRouter) // ✅
            case .main:
                ContentView()
                    .environmentObject(viewRouter)
                
            }
            

        }
    }
}


#Preview {
    Intro0View()
}
