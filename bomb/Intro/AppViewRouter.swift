//
//  AppViewRouter.swift
//  bomb
//
//  Created by Chu on 4/29/25.
//

import SwiftUI
import Combine

class AppViewRouter: ObservableObject {
    @Published var currentPage: Page = .intro1
}

enum Page{
    case intro1
    case intro2SignUp
    case intro3Login
    case intro4Welcome
    case main
}
