//
//  GeoResponse.swift
//  WeatherApp
//
//  Created by Carlos Dubon on 24/1/23.
//

import Foundation

struct GeoResponse:Codable, Hashable{
    var name:String
    var lat:Float
    var lon:Float
    var country:String
}
