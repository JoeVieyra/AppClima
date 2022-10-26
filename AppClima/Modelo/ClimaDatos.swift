

import Foundation

struct Principal: Codable {
    let data: [ClimaDatos]
    let count: Int
    let minutely: [Minutely]
}

struct ClimaDatos: Codable {
    let city_name: String
    let temp: Double
    let lon:Double
    let weather: Weather
    
    var tempString: String{
        return String(format: "%.1f", temp)
    }
    
}
enum CodingKeys: String, CodingKey {
    
    case temp
    case city_name = "city_name"
}

struct Weather: Codable {
    let icon: String
    let code: Int
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case icon, code
        case weatherDescription = "description"
    }
    var condicionClima: String{
        switch code {
        case 200...233:
            return "cloud.heavyrain"
        case 300...302:
            return "cloud.drizzle"
        case 800:
            return "sun.max"
        case 801...803:
            return "cloud.sun"
        case 804:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }
    
}

struct Minutely: Codable {
    let timestamp_utc: String
    let snow: Int
    let temp: Double
    let timestampLocal: String
    let ts: Int
    let precip: Double

    var tsString: String{
        return String(format: "%d", ts)
    }
    
    enum CodingKeys: String, CodingKey {
        case timestamp_utc = "timestamp_utc"
        case snow, temp
        case timestampLocal = "timestamp_local"
        case ts, precip
    }
}


  


   

