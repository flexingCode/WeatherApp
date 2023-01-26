//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Carlos Dubon on 24/1/23.
//

import Foundation

enum Enviroment: String,CaseIterable {
    case WeatherBaseAPI = "WeatherBaseAPI",
    WeatherTokenAPI = "WeatherTokenAPI"

}

class WeatherService {
    
    
    
    static func WeatherRequest<T:Codable>(path:String, params:[String:String]=[:],type:T.Type, compHandler: @escaping(T?, CustomError?)->()){
        guard var fullURL = ProcessInfo.processInfo.environment[Enviroment.WeatherBaseAPI.rawValue] else {
            compHandler(nil, CustomError(code:404,message:"Please set WeatherBaseAPI eviroment value."))
            return
        }
        fullURL = "\(fullURL)\(path)"
        for  (index, (key, value)) in params.enumerated(){
            if(index == 0){
                fullURL = "\(fullURL)?\(key)=\(value)"
            }else{
                fullURL = "\(fullURL)&\(key)=\(value)"
            }
            
        }
        
        guard let token = ProcessInfo.processInfo.environment[Enviroment.WeatherTokenAPI.rawValue] else {
            
            compHandler(nil, CustomError(code:404,message:"Please set WeatherTokenAPI eviroment value."))
            return
        }
        fullURL = "\(fullURL)&appid=\(token)"
        
        guard let url = URL(string: fullURL) else {
            compHandler(nil, CustomError(code:404,message:"URL Not found \(fullURL)"))
            return
        }
        
        let req = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: req){ (data, response, error) in
            DispatchQueue.main.async {
                if let res = response as? HTTPURLResponse{
                    if(res.statusCode >= 200 && res.statusCode <= 208){
                        if(res.statusCode == 204){
                            compHandler(nil,nil)
                        }else{
                            if let mdata = data{
                                do{
                                    let response = try JSONDecoder().decode(type, from: mdata)
                                        compHandler(response,nil)
                                    
                                }catch {
                                    print(error)
                                }
                            }
                        }
                        
                    }
                }
            }
            
        }.resume()
        
        
    }
}
