//
//  ColorExtensions.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

extension Color {
    static let deepPurpelColor = Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 1))
    static let mimiPinkColor = Color(#colorLiteral(red: 1, green: 0.9056817889, blue: 0.9435935616, alpha: 1))
    static let champagneColor = Color(#colorLiteral(red: 0.9794290662, green: 0.9235988259, blue: 0.8566998243, alpha: 1))
    static let androidGreenColor = Color(#colorLiteral(red: 0.6237975955, green: 0.7655177712, blue: 0.3301128149, alpha: 1))
    static let culturedColor = Color(#colorLiteral(red: 0.9688159823, green: 0.9688159823, blue: 0.9688159823, alpha: 1))
    
    static let homeSearchBarColor = Color(#colorLiteral(red: 1, green: 0.9056817889, blue: 0.9435935616, alpha: 0.3))
    static let grayDividerColor = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1))
    static let colorDivider = Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 0.15))
    
    static let blackOnePercentColor = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.01))
    static let mainBackgroundColor = LinearGradient(colors: [ Color(#colorLiteral(red: 1, green: 0.9056817889, blue: 0.9435935616, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 1))], startPoint: .top, endPoint: .bottom)
    static let secoundryBackgroundColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static let buttonBackgroundColor = Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 1))
    static let subscriptionsColorButtonBackground = Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 1))
    static let subscriptionsPlainButtonBackground = Color(#colorLiteral(red: 0.968, green: 0.968, blue: 0.968, alpha: 1))
    static let buttonLinierGradientColor = LinearGradient(colors: [Color(#colorLiteral(red: 0.668, green: 0.014, blue: 0.408, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.873, blue: 0.932, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let colorFont = Color(#colorLiteral(red: 0.682, green: 0.212, blue: 0.475, alpha: 1))
    static let dividerColor = Color(#colorLiteral(red: 0.682, green: 0.212, blue: 0.475, alpha: 0.15))
    static let purchaseHeaderButtonStrokeColor = LinearGradient(colors: [Color(#colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 0)), Color(#colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 0))], startPoint: .top, endPoint: .bottom)
    static let purchaseHeaderButtonFillColor = Color(#colorLiteral(red: 1, green: 0.9056817889, blue: 0.9435935616, alpha: 1))
    static let purchaseHeaderButtonShadowColor = Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 0.21))
    static let purchaseHeaderButtonBackgroundColor = Color(#colorLiteral(red: 1, green: 0.8779062033, blue: 0.9276540875, alpha: 1))
    static let viewDealButtonBackgroundColor = LinearGradient(colors: [Color(#colorLiteral(red: 0.6681778431, green: 0.0137046827, blue: 0.4076051712, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.8728173375, blue: 0.9318154454, alpha: 1))], startPoint: .leading, endPoint: .trailing)
    static let viewDealButtonStrokeColor = LinearGradient(colors: [Color(#colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 0.5)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25))], startPoint: .top, endPoint: .bottom)
    static let viewDealButtonShadowColor = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.01))
    static let purchaseBottomTabViewSecoundrayFontColor = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5981305804))
    static let addUnitButtonBackgroundColor =  LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.682, green: 0.212, blue: 0.475, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.906, blue: 0.944, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
    static let addUnitButtonShadowColor = Color(#colorLiteral(red: 0.682, green: 0.212, blue: 0.475, alpha: 0.15))
    static let addUnitButtonStrokeColor = LinearGradient(gradient:Gradient(colors:[Color(#colorLiteral(red: 0.6188150048, green: 0.1305246055, blue: 0.40766114, alpha: 1)), Color(#colorLiteral(red: 0.8784760833, green: 0.6453709602, blue: 0.7580710649, alpha: 1))]),startPoint: .topLeading,endPoint:.bottomTrailing)
}

