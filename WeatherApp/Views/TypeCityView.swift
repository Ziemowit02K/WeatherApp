//
//  TypeCityView.swift
//  WeatherApp
//
//  Created by Ziemowit Korzeniewski on 11/05/2024.
//

import SwiftUI

struct TypeCityView: View {
    @State public var cityName = "Warszawa"
    @State public var lat = 0.000
    @State public var lon = 0.000
    @State public var conditions_id = 801
    @State public var conditions_icon = "\(Constans.defaultCondition)"
    var body: some View {
        NavigationView{
            ZStack
            {
                LinearGradient(colors: [.black,.gray], startPoint: .bottomLeading, endPoint: .topTrailing).ignoresSafeArea().opacity(1)
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
                    HStack
                    {
                        TextField("City", text: $cityName).textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250,height: 50).foregroundColor(.black)
                        
                        
                        
                    }
                    .task {
                        do {
                            _ = try await fetchGeolocationFromAPI(name: cityName)
                            print("GeoLocationArray: \(getlocationArray)")
                            _ = try await fetchWeaherDataAPI()
                            
                            print("Current Weater: \(getCurrentWeatherArray))")
                            for localization in getlocationArray
                            {
                                lat = localization.lat
                                lon = localization.lon
                                
                            }
                            await refreshData()
                            SkyConditions()
                        } catch
                        {
                            print(error)
                        }
                        print(lat)
                        print(lon)
                        
                    }
                    
                    VStack
                    {
                        
                        
                        HStack
                        {
                            Button(action: {
                                Task{ await refreshData()}
                            }, label: {
                                NavigationLink(destination: DetailWeatherInfo(cityName: cityName, conditions_id: conditions_id, conditions_icon: conditions_icon)){
                                    Text("Show weather  \(Image(systemName: "location.fill"))").tint(.white)}.navigationBarBackButtonHidden(true)
                            }).tint(.gray).controlSize(.large).buttonStyle(.borderedProminent).opacity(0.8)
                        }
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Weather App")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
            }
        }.navigationBarBackButtonHidden(true)

    }


    
    func getDataFromArray(WeatherArray: [Weather])
    {
        for i in WeatherArray
        {
            conditions_id = i.id
        }
    }
    func SkyConditions()
    {
        if conditions_id >= 200 && conditions_id <= 232
        {
            conditions_icon = "\(Constans.storm)"
        }
        else if conditions_id>=300 && conditions_id <= 321
        {
            conditions_icon = "\(Constans.dizzle)"
        }
        else if conditions_id >= 500 && conditions_id <= 531
        {
            conditions_icon = "\(Constans.rain)"
        }
        else if conditions_id >= 600 && conditions_id <= 622
        {
            conditions_icon = "\(Constans.snow)"
        }
        else if conditions_id >= 700 && conditions_id <= 781
        {
            conditions_icon = "\(Constans.tornado)"
        }
        else if conditions_id == 800
        {
            conditions_icon = "\(Constans.sun)"
        }
        else if conditions_id == 801
        {
            conditions_icon = "\(Constans.sunnyClouds)"
        }
        else if conditions_id >= 802 && conditions_id <= 804
        {
            conditions_icon = "\(Constans.clouds)"
        }
        else
        {
            conditions_icon = "\(Constans.defaultCondition)"
        }
         
    }
    
    
    func refreshData() async
    {
                    
                        do {
                            _ = try await fetchGeolocationFromAPI(name: cityName)
                            print("GeoLocationArray: \(getlocationArray)")
                            _ = try await fetchWeaherDataAPI()
                            
                            print("Current Weater: \(getCurrentWeatherArray))")
                            for localization in getlocationArray
                            {
                                lat = localization.lat
                                lon = localization.lon
                                
                            }
                            
                        } catch
                        {
                            print(error)
                        }
                         getDataFromArray(WeatherArray: getCurrentWeatherArray2)
                        print(lat)
                        print(lon)
                    
                    
    }

}

#Preview {
    TypeCityView()
}
