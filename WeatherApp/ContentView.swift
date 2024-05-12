//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ziemowit Korzeniewski on 09/05/2024.
//

import SwiftUI
import Foundation

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                
                LinearGradient(colors: [.black,.gray], startPoint: .bottomLeading, endPoint: .topTrailing).ignoresSafeArea().opacity(1)
                VStack{
                    
                    VStack
                    {
                       
                        VStack{
                            Image(systemName: "cloud.sun")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200, alignment: .top)
                                .opacity(0.7)
                            
                        }.frame(width: 300, height:300, alignment: .top)
                        
                        Button(action: {
                            //Task{ await refreshData()}
                        }, label:  {
                            NavigationLink(destination: TypeCityView())
                            {
                                Text("Go to App \(Image(systemName: "chevron.forward"))").tint(.white).foregroundColor(.black)}.navigationBarBackButtonHidden(true)
                            
                        }).tint(.gray).controlSize(.large).buttonStyle(.borderedProminent)
                    }.padding()
                }.padding()
            }
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Weather App")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                    
                }
            }
        }.accentColor(.white)//NavigationView
            .navigationBarBackButtonHidden(true)
    }
}

   

#Preview {
    ContentView()
}

