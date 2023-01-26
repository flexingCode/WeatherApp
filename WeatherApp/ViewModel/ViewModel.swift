//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Carlos Dubon on 23/1/23.
//

import Foundation

class WeatherViewModel : ObservableObject{
    @Published var searchValue:String = ""
    @Published var suggestCity:[GeoResponse] = [GeoResponse]();
    @Published var selectedCity:GeoResponse = GeoResponse(name: "San Salvador", lat: 13.676809, lon: -89.237787, country: "SV")
    @Published var currentCity:WeatherResponse?
    @Published var currentUnits:String = "C"
    @Published var time:Int = 0
    

    public func initData(){
        getWeather(city: selectedCity)
    }
    
    public func getLatLong(search:String){
        WeatherService.WeatherRequest(path: "/geo/1.0/direct",params:["q":search,"limit":"10"], type: [GeoResponse].self) { data, error in
            if let merror = error {
                print(merror.code)
                print(merror.message)
                return
            }
            
            if let mdata = data{
                self.suggestCity = mdata
            }
        }
    }
    
    public func getWeather(city:GeoResponse){
        WeatherService.WeatherRequest(path: "/data/2.5/weather",params: ["lat":"\(city.lat)","lon":"\(city.lon)","units":"imperial"], type: WeatherResponse.self) { data, error in
            if let merror = error {
                print(merror.code)
                print(merror.message)
                return
            }
            if let mdata = data{
                self.currentCity = mdata
                if(self.currentCity != nil){
                    self.currentCity?.city = city.name
                    self.currentCity?.main.f = self.currentCity?.main.temp
                    self.currentCity?.main.c = Utils.fToC(F: (self.currentCity?.main.temp)!)
                }
                let randomInt = Int.random(in: 1...2)
                self.time = randomInt
            }
            
        }
    }
    
    
    func getWeatherByUnits(cityData:WeatherResponse?)-> Float{
        if(currentCity != nil){
            if(currentUnits == "C"){
                return cityData?.main.c ?? 0
            }
            return cityData?.main.f ?? 0
        }
        return 0
    }
    
    public func changeUnits(){
        if(self.currentUnits == "C"){
            self.currentUnits = "F"
        }else{
            self.currentUnits = "C"
        }
    }
    
    
}
