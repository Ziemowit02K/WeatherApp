import Foundation

let apiKey = ""
var getlocationArray : [GeoLocation] = []
var getCurrentWeatherArray : [CurrentWeather] = []
var getCurrentWeatherArray2 : [Weather] = []
var getlocalNamesArray : [LocalNames] = []
var lat = 0.00
var lon = 0.00
func fetchGeolocationFromAPI(name : String) async throws-> [GeoLocation]
{
    let url = URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(name)&limit=2&appid=\(apiKey)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decoded  = try JSONDecoder().decode([GeoLocation].self, from: data)
    getDataFromLocation(decoded: decoded)
    return decoded
    
}
func fetchWeaherDataAPI() async throws -> CurrentWeather
{
    
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decoded  = try JSONDecoder().decode(CurrentWeather.self, from: data)
    getCurrentWeather(decoded: decoded)
    return decoded
}
func getDataFromLocation(decoded: [GeoLocation])
{
    for location in decoded
    {
        getlocationArray = [GeoLocation(name: location.name, localNames: location.localNames, lat: location.lat, lon: location.lon, country: location.country, state: location.state)]
        lon = location.lon
        lat = location.lat
 
        
    }
}
func getDataFromLocalNames(decoded: [LocalNames])
{
    for i in decoded
    {
        getlocalNamesArray = [LocalNames(ja: i.ja, fr: i.fr, sk: i.sk, pl: i.pl, yi: i.yi, de: i.de, mk: i.mk, es: i.es, bg: i.bg, sr: i.sr, en: i.en, hu: i.hu, he: i.he, lv: i.lv, be: i.be, eo: i.eo, zh: i.zh, lt: i.lt, ar: i.ar, cs: i.cs, uk: i.uk, it: i.it, pt: i.pt, ru: i.ru, la: i.la)]
    }
}
func getCurrentWeather(decoded: CurrentWeather)
{
    for weather in decoded.weather
    {
        getCurrentWeatherArray = [CurrentWeather(coord: decoded.coord, weather: decoded.weather, base: decoded.base, main: decoded.main, visibility: decoded.visibility, wind: decoded.wind, clouds: decoded.clouds, dt: decoded.dt, sys: decoded.sys, timezone: decoded.timezone, id: decoded.id, name: decoded.name, cod: decoded.cod)]
        
        getCurrentWeatherArray2 = [Weather(id: weather.id, main: weather.main, description: weather.description, icon: weather.icon)]
        
        
    }
}



