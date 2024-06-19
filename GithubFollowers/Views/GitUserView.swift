//
//  GitUserView.swift
//  GithubFollowers
//
//  Created by qwerty on 19.06.2024.
//

import SwiftUI

struct GitUserView: View {
    @StateObject private var gitHubService = GitHubService()
    @Binding  var username: String
    @Binding var index : Int
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    switch index{
                    case 1:
                        Section(header: Text("Followers").font(.system(size: 20))) {
                            ForEach(gitHubService.followers) { user in
                                Text(user.login)
                            }
                        }
                    case 2:
                        Section(header: Text("Following").font(.system(size: 20))) {
                            ForEach(gitHubService.following) { user in
                                Text(user.login)
                            }
                        }
                    case 3:
                        Section(header: Text("Not Followed Back").font(.system(size: 20))) {
                            ForEach(gitHubService.notFollowedBack) { user in
                                HStack{ 
                                    Text(user.login)
                                    Spacer()
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("Unfollow")
                                            .padding()
                                            .background(Color.black)
                                            .cornerRadius(20)
                                    })
                                }
                            }
                        }
                    case 4:
                        Section(header: Text("Not Following Back").font(.system(size: 20))) {
                            ForEach(gitHubService.notFollowingBack) { user in
                                HStack{
                                    Text(user.login)
                                    Spacer()
                                    Button(action: {
                                    }, label: {
                                        Text("Follow")
                                            .padding()
                                            .background(Color.black)
                                            .cornerRadius(20)
                                    })
                                }
                            }
                        }
                    default:
                        EmptyView()
                    }
                    
                }
            }.onAppear{
                gitHubService.fetchFollowers(for: username)
                gitHubService.fetchFollowing(for: username)
                gitHubService.fetchUserIdAndAvatar(for: username)
            }
        }
    }
}
//
//#Preview {
//    GitUserView()
//}
