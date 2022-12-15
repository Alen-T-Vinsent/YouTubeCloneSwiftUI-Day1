//
//  HomeView.swift
//  YouTubeCloneSwiftUI-Day1
//
//  Created by Apple  on 15/12/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var headerData = HeaderViewModel()
    
    //disabling bouncing
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            //header view
            HeaderView()
            
            //video view
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing:15){
                    ForEach(1...5,id:\.self){eachIndex in
                        
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rect.width - 30,height: 250)
                            .cornerRadius(1)
                            .background(Color.red)
                        
                        
                        HStack(spacing:20){
                            Image(systemName: "person.and.background.dotted")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30,height: 30)
                                .foregroundColor(Color.primary)
                                .clipShape(Circle())
                            
                            
                            VStack(alignment:.leading,spacing: 4){
                                Text("here is some title")
                                    .font(.title2)
                                
                                Text("ijustine . 4 hours ago")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.bottom,10)
                    }
                }
                .overlay(
                    GeometryReader{proxy -> Color in
                        
                        let minY = proxy.frame(in: .global).minY
                        
                        //print(minY)
                        
                        DispatchQueue.main.async {
                            
                            //storing initial MinY value..
                            if headerData.startMinY == 0{
                                headerData.startMinY = minY
                            }
                            //getting exact offset value by substracting current from start
                            let offset = headerData.startMinY - minY
                            
                        
                            //print("offset -- \(offset)")
                            //getting scroll direction...
                            
                            if offset > headerData.offset{ //offset is defaulty 0
                                print("Top")
                                //if top hiding header
                                
                                if headerData.topScrolledOffset == 0{
                                    headerData.topScrolledOffset = offset
                                }
                                let progress = (headerData.topScrolledOffset + getMaxOffset() ) - offset
                               // print(progress)
                                
                                let offsetCondition = getMaxOffset() - progress <= getMaxOffset()
                                
                                let headerOffset = offsetCondition ? -(getMaxOffset() - progress) : -getMaxOffset()
                                
                                headerData.headerOffset = headerOffset
                                
                                print(headerOffset)
                                
                            }
                            
                            
                            if  offset < headerData.offset{
                                print("Bottom")
                                //if bottom revealing header
                                let progress = headerData.bottomScrolledOffset
                            }
                            
                            headerData.offset = offset
                            
                            
                            
                        }
                        return Color.clear
                    }
                        .frame(height: 0)
                    ,alignment: .top
                    
                )

             .padding(.top,75)
            }
        }
    }
    //getting max Top offset Including top safe area....
    func getMaxOffset()->CGFloat{
        return headerData.startMinY + (edges?.top ?? 0)+10
    }
    
}


var edges = UIApplication.shared.windows.first?.safeAreaInsets

var rect = UIScreen.main.bounds

struct HeaderView:View{
    @Environment(\.colorScheme) var scheme
    var body: some View{
        HStack(){
            Image("YTlogo 1")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fit)
                .frame(width: 40,height: 50,alignment: .center)
                .padding(.top,60)
            Text("Youtube")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.top,60)
            //kerning
                .kerning(0.5)
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Image(systemName: "display")
                    .font(.title)
                    .foregroundColor(.primary)
            }
            .padding(.top,60)
            
            Button {
                
            } label: {
                Image(systemName: "bell")
                    .font(.title)
                    .foregroundColor(.primary)
            }
            .padding(.top,60)
            
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundColor(.primary)
            }
            .padding(.top,60)
            
            Button {
                
            } label: {
                Image(systemName: "person.and.background.dotted")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30,height: 30)
                    .foregroundColor(Color.primary)
                    .clipShape(Circle())
            }
            .padding(.top,60)
            
        }
        .padding(.horizontal)
        .padding(.vertical,8)
        .background(Color.green)
        .background(scheme == .dark ? Color.black : Color.white)
        .ignoresSafeArea(.all,edges: .top)
        
        
        //Divider
        .overlay(
            Divider()
            ,alignment: .center
        )
    }
}
