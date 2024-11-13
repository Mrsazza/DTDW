//
//  PremiumFeaturesView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PremiumFeaturesView: View {
    var body: some View {
        HStack(spacing: 20) {
            FeatureItem(title: "Unlimited Deals")
            FeatureItem(title: "Ads Free")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
}
