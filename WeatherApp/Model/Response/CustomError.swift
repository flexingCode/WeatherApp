//
//  CustomError.swift
//  WeatherApp
//
//  Created by Carlos Dubon on 24/1/23.
//

import Foundation

class CustomError{
    var code:Int
    var message:String
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
    
}
