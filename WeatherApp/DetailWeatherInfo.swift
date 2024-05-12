//
//  DetailWeatherInfo.swift
//  WeatherApp
//
//  Created by Ziemowit Korzeniewski on 11/05/2024.
//

import SwiftUI
import Foundation
struct DetailWeatherInfo: View {
    
    var cityName : String
    @State public var conditions = ""
    @State public var description = ""
    @State public var country = ""
    @State public var name = ""
    @State public var state  = ""
    @State var tempMax = 0.0
    @State var tempMin = 0.0
    @State var feelslike  = 0.0
    @State var temp = 0.0
    @State var windSpeed = 0.0
    @State var pressure = 0
    @State var visibility = 0
    @State var humidity = 0
    @State var windDeg = 0
    @State var conditions_id : Int
    @State var conditions_icon  : String
    @State var sunrise = 0
    @State var sunset = 0
    @State var date = 0
    
    var body: some View {
        NavigationView{
            
        ZStack{
            LinearGradient(colors: [.black,.gray], startPoint: .bottomLeading, endPoint: .topTrailing).ignoresSafeArea().opacity(1)
         
                VStack{
//                    HStack
//                    {
//                        Button(action:{
//
//                        },label:{
//                            NavigationLink(destination: TypeCityView()) {Text("\(Image(systemName: "chevron.backward"))Back")}.foregroundColor(.white)
//                        })
//                    }.frame(width: 340,alignment: .leading)
                    VStack{
                        VStack{
                            Text("\(fromUnixToDate(time: date))")
                                .foregroundColor(.white)
                                .font(.system(size: 10, weight: .light))
                            Text("\(cityName):")
                                .font(.system(size: 36, weight: .medium, design: .default))
                                .foregroundColor(.white)
                            Text("\(country), \(state)").foregroundColor(.white).font(.system(size: 16, weight: .thin))
                            Text("Lon: \(lon)º, Lat: \(lat)º")
                                .font(.system(size: 13, weight: .ultraLight))
                                .foregroundColor(.white)
                        }.padding()
                            .frame(width: 350, height: 150)
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(15)
                        
                        VStack(spacing: 10)
                        {
                            HStack{
                                Image(systemName: "\(conditions_icon)")
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100, alignment: .top)
                                    .opacity(0.7).padding()
                                    .foregroundColor(.white)
                                Text("\(roundeDouble(x: temp))℃")
                                    .foregroundColor(.white)
                                    .frame(width: 130)
                                    .font(.system(size:28, weight: .bold, design: .default))
                            }
                            Text("Today is: \(conditions) ")
                                .foregroundColor(.white)
                                .font(.system(size:16, weight: .thin))
                            ProgressView(value: temp, total: 40).frame(width: 300)
                            
                            HStack(spacing: 20)
                            {
                                Text("\(Image(systemName: "thermometer.low" )) \(roundeDouble(x: tempMin))℃")
                                    .foregroundColor(.cyan)
                                    .font(.system(size: 14, weight: .thin))
                                Text("\(Image(systemName: "thermometer.high" )) \(roundeDouble(x: tempMax))℃")
                                    .foregroundColor(.red)
                                    .font(.system(size: 14, weight: .thin))
                                Text("\(Image(systemName: "wind" )) \(roundeDouble(x: windSpeed))km/h")
                                    .foregroundColor(.green)
                                    .font(.system(size: 14, weight: .thin))
                                Text("\(Image(systemName: "location.fill" )) \(windDeg)º")
                                    .foregroundColor(.green)
                                    .font(.system(size: 14, weight: .thin))
                            }
                        }
                        
                        .frame(width: 350, height: 250)
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(15)
                    }
                        VStack
                        {
                            VStack
                            {
                                HStack(spacing: 30)
                                {
                                    VStack
                                    {
                                        HStack{
                                            Text("Today is:")
                                                .foregroundColor(.white)
                                            Text(" \(description)")
                                                .foregroundColor(.cyan)
                                        }
                                        HStack
                                        {
                                            Text("Conditions: ")
                                            Text("\(Image(systemName: conditions_icon))")
                                                .foregroundColor(.cyan)
                                        }
                                    }.frame(width: 170,height: 100,alignment: .center)
                                        .background(Color.white.opacity(0.05))
                                        .cornerRadius(15)
                                        
                                    VStack
                                    {
                                        HStack{
                                            Text("Feels Like: ")
                                            Text("\(roundeDouble(x: feelslike))℃")
                                                .foregroundColor(.green)
                                        }
                                        HStack
                                        {
                                            Text("Humidity: ")
                                            Text("\(humidity)%")
                                                .foregroundColor(.blue)
                                        }
                                        
                                    }.frame(width: 170,height: 100,alignment: .center)
                                        .background(Color.white.opacity(0.05))
                                        .cornerRadius(15)
                                }.frame(height: 130)
                            } .foregroundColor(.white)
                            HStack(spacing: 30){
                                VStack
                                {
                                    HStack
                                    {
                                        Text("Pressure: ")
                                        Text(" \(pressure)hPa").foregroundColor(.yellow)
                                    }
                                    HStack
                                    {
                                        Text("Visibility: ")
                                        Text(" \(visibility)m").foregroundColor(.indigo)
                                    }
                                }.frame(width: 170,height: 100,alignment: .center)
                                    .background(Color.white.opacity(0.05))
                                    .cornerRadius(15)
                                VStack{
                                    HStack
                                    {
                                        Text("Sunset: ")
                                        Text(" \(fromUnixToHoure(time: sunset))").foregroundColor(.orange)
                                        
                                    }
                                    HStack
                                    {
                                        Text("Sunrise: ")
                                        Text(" \(fromUnixToHoure(time: sunrise))").foregroundColor(.yellow.opacity(0.9))
                                    }
                                }.frame(width: 170,height: 100,alignment: .center)
                                    .background(Color.white.opacity(0.05))
                                    .cornerRadius(15)
                            }.frame(height: 130)
                            
                            
                            
                           Spacer()
                        }.foregroundColor(.white)
                        
                        
                    
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
                            //SkyConditions()
                        } catch
                        {
                            print(error)
                        }
                        print(lat)
                        print(lon)
                        
                    }
                }
        }//.onAppear{Task{refreshData}}
        
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                Text("Weather App")
                    .font(.largeTitle.bold())
                    .accessibilityAddTraits(.isHeader)
                    .toolbarTitleDisplayMode(.inline)
                    
                    
            }
        }
        }
        //.navigationBarBackButtonHidden(true)
            
            
            .task {
                do {
                    _ = try await fetchGeolocationFromAPI(name: cityName)
                    print("GeoLocationArray: \(getlocationArray)")
                    _ = try await fetchWeaherDataAPI()
                    print("Current Weater: \(getCurrentWeatherArray))")
                    _ = getDataFromLocalNames
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
            
            
        
    }
    func fromUnixToHoure(time: Int) -> String
    {
        let unixTime: TimeInterval = TimeInterval(time) // Twój czas UIX
        let date = Date(timeIntervalSince1970: unixTime)

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        return("\(hour):\(minute)")
    }
    func fromUnixToDate(time:Int) -> NSDate
    {
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        return date
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
    
    
    func getDataFromArray(CurrentWeatherArray: [CurrentWeather], GeoLocationArray: [GeoLocation], WeatherArray: [Weather])
    {
            for i in CurrentWeatherArray
            {
                //String:
                country = i.sys.country
                
                name = i.name
                //Double:
                temp = i.main.temp
                tempMax = i.main.tempMax
                tempMin = i.main.tempMin
                feelslike = i.main.feelsLike
                windSpeed = i.wind.speed
                //Int:
                pressure = i.main.pressure
                humidity = i.main.humidity
                visibility = i.visibility
                windDeg = i.wind.deg
                sunrise=i.sys.sunrise
                sunset=i.sys.sunset
                date = i.dt
                
            }
        
            for i in GeoLocationArray
            {
                state = i.state
                lat = i.lat
                lon = i.lon
            }
            for i in WeatherArray
            {
                description=i.description
                conditions = i.main
                conditions_id = i.id
                
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
            getDataFromArray(CurrentWeatherArray: getCurrentWeatherArray,GeoLocationArray: getlocationArray, WeatherArray: getCurrentWeatherArray2)
            _ = getDataFromLocalNames
            print(lat)
            print(lon)
        
        
    }
    func roundeDouble(x : Double) -> String
    {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        let roundedX = formatter.string(from: x as NSNumber)!
        
        //Float((x*100).rounded()/100)
        
        return roundedX
    }
}


#Preview {
    DetailWeatherInfo(cityName: "Warszawa", conditions_id: 800, conditions_icon: "\(Constans.defaultCondition)")
}
