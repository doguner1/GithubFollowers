//
//  SlideHomeView.swift
//  GithubFollowers
//
//  Created by qwerty on 19.06.2024.
//

import SwiftUI

struct SlideHomeView: View {
    @State private var dragAmount = CGSize.zero
    @State private var progress: CGFloat = 0.0
    private let maxDragAmount: CGFloat = 70
    @Binding var show: Bool
    @State var multiColor = false
    @AppStorage("username") var userName = ""
    
    @State var animation = false
    var text = "Scanner"
    
    var body: some View {
        VStack(spacing: 30){
            TextShimmer(text: "Please", multiColors: $multiColor)
            
            TextShimmer(text: "Enter", multiColors: $multiColor)
            
            TextShimmer(text: "Username", multiColors: $multiColor)
                
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.horizontal,10)
                    .padding(.trailing,4)
                TextField(".   .   .   .",text: $userName)
                    .autocapitalization(.none)
                    
                .padding()
            }.padding(.top,120)
            .font(.system(size: 35, weight: .bold))
                .foregroundColor(Color.white.opacity(0.25))
            HStack{
                slideView
                progressView
                    .padding()
                    .scaleEffect(max(1 + progress / 5,1))
            }
            
            Spacer()
        }
    }
    var progressView:some View{
        ZStack{
            if progress >= 0.5 {
                Image(progress == 1 ? "4" : "3")
                    .resizable().scaledToFill()
                    .frame(width: 100,height: 100)
                    .rotationEffect(.degrees(-15))
            }
            
            if progress < 0.5 {
                Image(progress == 0 ? "1" : "2")
                    .resizable().scaledToFill()
                    .frame(width: 100,height: 100)
                    .rotationEffect(.degrees(-15))
            }
            
            
            Circle()
                .trim(from:0, to: progress)
                .stroke(Color.white,style: StrokeStyle(lineWidth: 4,lineCap: .round,lineJoin: .round))
                .frame(width: 70,height: 70)
                .rotationEffect(.degrees(-90))
                .background(
                    Circle()
                        .stroke(lineWidth: 4)
                        .foregroundColor(.white.opacity(0.25))
                )
            
            
        }
        .rotationEffect(.degrees(10),anchor: .bottomTrailing)
    }
    var slideView: some View{
        HStack{
            
            ZStack{
                VStack {
                    Text("Slide To")
                     Text("Analyze")
                } .font(.system(size: 45, weight: .bold))
                    .foregroundColor(Color.white.opacity(0.25))

            }
            Image(systemName: "arrow.forward")
                .padding(.horizontal)
                
            
            
        }
        .foregroundStyle(.secondary)
        .font(.title2)
        .bold()
        .offset(x:max(0,dragAmount.width))
        .gesture(
            DragGesture()
                .onChanged{ value in
                    withAnimation{
                        let translationWidth = value.translation.width
                        self.dragAmount.width = min(translationWidth , maxDragAmount)
                        self.progress = min(1,self.dragAmount.width / maxDragAmount)
                    }
                    
                }
                .onEnded{ _ in
                    if self.progress >= 1{
                        withAnimation{
                            self.dragAmount = .zero
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            withAnimation{
                                show = true
                                
                            }
                        }
                        
                    }else {
                        withAnimation (.linear) {
                            self.dragAmount = .zero
                            self.progress = 0
                        }
                    }
                    
                    
                    
                }
        )
    }
}

struct TextShimmer: View {
    
    var text: String
    @State var animation = false
    @Binding var multiColors: Bool
    
    var body: some View{
        
        ZStack{
            Text(text)
                .font(.system(size: 75, weight: .bold))
                .foregroundColor(Color.white.opacity(0.25))

            HStack(spacing: 0){
                
                ForEach(0..<text.count,id: \.self){index in
                    
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .font(.system(size: 75, weight: .bold))
                        .foregroundColor(multiColors ? randomColor() : Color.white)
                }
            }
            .mask(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: .init(colors: [Color.white.opacity(0.5),Color.white,Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                    .padding(20)
                    .offset(x: -250)
                    
                    .offset(x: animation ? 500 : 0)
            )
            .onAppear(perform: {
                
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)){
                    
                    animation.toggle()
                }
            })
        }
    }
    func randomColor()->Color{
        
        let color = UIColor(red: 1, green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        return Color(color)
    }
}

#Preview {
    SlideHomeView(show: .constant(false))
}

