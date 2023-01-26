//
//  ContentView.swift
//  WeatherApp
//
//  Created by Carlos Dubon on 23/1/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = WeatherViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                VStack(spacing:16){
                    if(vm.time == 1){
                        CloudAnimated()
                    }else{
                        SunAnimated()
                    }
                    
                    HStack{
                        Text("\(vm.getWeatherByUnits(cityData: vm.currentCity),specifier:"%.2f")")
                            .bold()
                            .font(.system(size:75))
                        Text("°\(vm.currentUnits)")
                            .font(.system(size:50))
                    }
                    Text("\(vm.currentCity?.city ?? "")")
                        .font(.title)
                        .foregroundColor(.gray)
                }.frame(maxHeight: .infinity)
                FullPrimaryButton(text:"Cambiar unidades de temperatura")
                    .onTapGesture {
                        vm.changeUnits()
                    }

            }.padding()
            
            
        }.searchable(text: $vm.searchValue,suggestions: {
            ForEach(vm.suggestCity, id: \.self){ city in
                Button("\(city.name) , \(city.country)"){
                    vm.selectedCity = city
                    vm.getWeather(city: city)
                }
            }
        })
        .onChange(of: vm.searchValue) { newValue in
            vm.getLatLong(search: vm.searchValue)
            
        }
        .onAppear{
            vm.initData()
        }
            
    }
}

struct FullPrimaryButton: View {
    @State var text:String
    var body: some View {
        Text(text)
            .bold()
            .textCase(.uppercase)
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.black)
            )
            .clipShape(Rectangle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
