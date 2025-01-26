//
//  HomeCardModel.swift
//  DTDW
//
//  Created by Sopnil Sohan on 26/1/25.
//

import SwiftUI

struct HomeCardModel: Identifiable {
    var id = UUID()
    var imageName: Data?
    var title: String
    var cashOnReturn: String
    var cashOnReturnData: Double
    var capRate: String
    var capRateData: Double
    var buttonAction: () -> Void
}
