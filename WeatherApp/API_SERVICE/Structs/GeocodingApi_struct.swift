import Foundation

//struct GeoResponse : Decodable
//{
//    let result : GeoLocation
//}
struct GeoLocation : Decodable
{
    let name: String
    let localNames: [LocalNames]?
    let lat, lon: Double
    let country, state: String
}
struct LocalNames: Decodable  {
            let ja, fr, sk, pl: String
            let yi, de, mk, es: String
            let bg, sr, en, hu: String
            let he, lv, be, eo: String
            let zh, lt, ar, cs: String
            let uk, it, pt, ru: String
            let la: String
        }
    
