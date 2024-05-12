import Foundation

struct WeatherData
{
    
     let conditions: Main
     let description, country, name, state: String
     let tempMin, tempMax, feelslike, temp, windSpeed: Double
     let pressure, visibility, humidity, windDeg: Int
}
