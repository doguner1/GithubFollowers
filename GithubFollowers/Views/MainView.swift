//
//  MainView.swift
//  GithubFollowers
//
//  Created by qwerty on 19.06.2024.
//

import SwiftUI
import SDWebImageSwiftUI


struct MainView: View {
    @State var show = false
    @AppStorage("username") var userName = "doguner1"
    @StateObject private var gitHubService = GitHubService()
    @State var isShowingSheet = false
    @State var isRepoShowing = false
    @State var index : Int = 0
    var body: some View {
        if show {
            Home
                .preferredColorScheme(.dark)
        }else{
            SlideHomeView(show: $show)
                .preferredColorScheme(.dark)
        }
    }
    
    var Home: some View{
        VStack{
            HStack{
                Button(action: {
                    show.toggle()
                    userName = ""
                }, label: {
                    Label("", systemImage: "arrowshape.turn.up.left.2")
                })
                Spacer()
                
                Button(action: {
                    isRepoShowing.toggle()
                }, label: {
                    Image(systemName: "menucard")
                })
                
                
            }.overlay{
                Text(userName)
            }

            .padding(.bottom,30)
            HStack{
                VStack{
                    Text("\(gitHubService.followers.count)")
                        .font(.system(size: 25))
                    Text("Followers")
                        .font(.caption)
                }
                Spacer()
                /*
                 for follower in gitHubService.notFollowedBack {
                     let login = follower.login
                     let userId = follower.id
                     print(login)
                     print(userId)
                 }
                 */
                
                WebImage(url: URL(string: gitHubService.avatarUrl ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipped()
                    .cornerRadius(min(90, 90) / 2)
                    .overlay(RoundedRectangle(cornerRadius: min(90, 90) / 2).stroke(Color(.label), lineWidth: 2))
                    .shadow(radius: 5)
                Spacer()
                VStack{
                    Text("\(gitHubService.following.count)")
                        .font(.system(size: 25))
                    Text("Following")
                        .font(.caption)
                }
            }
            .padding(.bottom,30)
            
            VStack{
                WebView(html: """
                <div align="center">
                    <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=\(userName)&theme=dark&hide_border=false&include_all_commits=false&count_private=false&layout=compact" width="80%" />
                </div>
                """)
                
                HStack{
                    WebView(html: """
                    <div align="center">
                        <img src="https://github-readme-streak-stats.herokuapp.com/?user=\(userName)&theme=dark&hide_border=false" width="80%"  />
                    </div>
                            <div align="center">
                                <img src="https://github-readme-stats.vercel.app/api?username=\(userName)&theme=dark&hide_border=false&include_all_commits=false&count_private=false" width="80%" />
                            </div>
                    """)
                }
                .frame(height: 165)
                
            }.frame(height: 390)
                .frame(width: 500)
            
            
            VStack{
                HStack {
                    Button(action: {
                        isShowingSheet.toggle()
                        index = 1
                    }, label: {
                        HStack{
                            Text("Followers")
                            Image(systemName: "arrowshape.right")
                        }.padding()
                    })
                    .frame(width: 177, height:  60,alignment: .leading)
                    .background(Color("Color 1").cornerRadius(15))
                    .background(Color("Color").cornerRadius(15).offset(x:2,y: 4))
                    
                    Button(action: {
                        isShowingSheet.toggle()
                        index = 2
                    }, label: {
                        HStack{
                            Text("Following")
                            Image(systemName: "arrowshape.right")
                        }.padding()
                    })
                    .frame(width: 177, height:  60,alignment: .leading)
                    .background(Color("Color 1").cornerRadius(15))
                    .background(Color("Color").cornerRadius(15).offset(x:2,y: 4))
                }
                Capsule().foregroundColor(.white)
                    .frame(width: 400,height: 1)
                    .padding(.top,10)
                HStack {
                    Button(action: {
                        isShowingSheet.toggle()
                        index = 4
                    }, label: {
                        HStack{
                            VStack{
                                Text("Not")
                                Text("Following Back")
                            }
                            Image(systemName: "arrowshape.right")
                        }.padding()
                    })
                    .frame(width: 177, height:  60,alignment: .leading)
                    .background(Color("Color 1").cornerRadius(15))
                    .background(Color("Color").cornerRadius(15).offset(x:2,y: 4))
                    
                    Button(action: {
                        isShowingSheet.toggle()
                        index = 3
                        print(gitHubService.userRepos.count)
                        /*
                        for follower in gitHubService.notFollowedBack {
                            let login = follower.avatar_url
                            let userId = follower.id
                            print(login)
                            print(userId)
                        }
                         */
                    }, label: {
                        HStack{
                            VStack{
                                Text("Not")
                                Text("Followed Back")
                            }
                            
                            Image(systemName: "arrowshape.right")
                        }.padding()
                    })
                    .frame(width: 177, height:  60,alignment: .leading)
                    .background(Color("Color 1").cornerRadius(15))
                    .background(Color("Color").cornerRadius(15).offset(x:2,y: 4))
                }
            }.padding(.top,30)
                .sheet(isPresented: $isShowingSheet){
                    GitUserView(username: $userName, index: $index)
                    
                }
                .sheet(isPresented: $isRepoShowing){
                    GitRepo(githubService: gitHubService)
                }
                .onAppear{
                    gitHubService.fetchFollowers(for: userName)
                    gitHubService.fetchFollowing(for: userName)
                    gitHubService.fetchUserIdAndAvatar(for: userName)
                    gitHubService.fetchUserRepos(for: userName)
                }
            Spacer()
        }.padding()
        
            .padding(.horizontal)
            .foregroundColor(Color(.label))
    }
}



#Preview {
    MainView()
}
