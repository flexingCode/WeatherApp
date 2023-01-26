//
//  CloudAnimated.swift
//  WeatherApp
//
//  Created by Carlos Dubon on 25/1/23.
//

import SwiftUI

struct CloudAnimated: View {
    @State var circularMovment:Bool = false

    
    var body: some View {
        Image(systemName: "cloud.fill")
            .font(.system(size: 64))
            .offset(x:circularMovment ? -10 : 10,y:circularMovment ? -10 : 10)
            .animation(.easeInOut(duration: 5).repeatForever(autoreverses: true), value: circularMovment)
            .onAppear{
                circularMovment = true
            }
            .foregroundColor(.gray)
    }
}

struct CloudAnimated_Previews: PreviewProvider {
    static var previews: some View {
        CloudAnimated()
    }
}
