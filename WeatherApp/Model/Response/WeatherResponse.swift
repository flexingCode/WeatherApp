//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Carlos Dubon on 25/1/23.
//

import Foundation


struct WeatherResponse:Codable{
    var city:String?
    var main:Main
    var weather:[Weather]
    
    struct Main:Codable{
        var temp:Float
        var c:Float?
        var f:Float?
    }
    struct Weather:Codable{
        var id:Int
        var main:String
        var icon:String
    }
}
