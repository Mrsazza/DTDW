//
//  ContentView.swift
//  DTDW
//
//  Created by Sazza on 5/11/24.
//

import SwiftUI

struct ContentView: View {
    @Bindable var propertyData: PropertyData
    var body: some View {
        DTDWTabView(propertyData: propertyData)
    }
}

