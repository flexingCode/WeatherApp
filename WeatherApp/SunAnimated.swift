//
//  SunAnimated.swift
//  WeatherApp
//
//  Created by Carlos Dubon on 25/1/23.
//

import SwiftUI

struct SunAnimated: View {
    @State private var isRotating = 0.0

    var body: some View {
        Image(systemName: "sun.min")
            .font(.system(size: 64))
            .rotationEffect(.degrees(isRotating))
            .onAppear{
                withAnimation(.linear(duration: 1)
                            .speed(0.1).repeatForever(autoreverses: false)) {
                        isRotating = 360.0
                    }

            }
            .foregroundColor(.gray)
    }
}

struct SunAnimated_Previews: PreviewProvider {
    static var previews: some View {
        SunAnimated()
    }
}
