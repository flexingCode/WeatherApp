//
//  Utils.swift
//  WeatherApp
//
//  Created by Carlos Dubon on 26/1/23.
//

import Foundation

class Utils {
    public static func fToC(F:Float) -> Float{
        return ((F - 32) * (5/9))
    }
}
