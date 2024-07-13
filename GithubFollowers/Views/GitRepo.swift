//
//  GitRepo.swift
//  GithubFollowers
//
//  Created by qwerty on 13.07.2024.
//


import SwiftUI
struct GitRepo: View {
    let githubService : GitHubService
    @AppStorage("username") var userName = "doguner1"
    var body: some View {
        Text("Repos")
        List{
            ForEach(githubService.repositoryNames, id: \.self){ repo in
                Button(action: {
                    if let url = URL(string: "https://github.com/\(userName)/\(repo)") {
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                        }
                }, label: {
                    HStack{
                        Text("\(repo)")
                        Spacer()
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                }).padding()
                    .background(Capsule().stroke())
                        
            }
        }.listStyle(PlainListStyle())
            .padding(.horizontal)
    }
}

#Preview {
    GitRepo(githubService: GitHubService())
}
