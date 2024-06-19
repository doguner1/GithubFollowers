//
//  GithubFollowersApp.swift
//  GithubFollowers
//
//  Created by qwerty on 19.06.2024.
//

import SwiftUI

@main
struct GithubFollowersApp: App {
    @AppStorage("username") var userName = "doguner1"
    
    init(){
        userName = ""
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
