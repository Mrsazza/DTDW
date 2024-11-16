//
//  FeatureItem.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct FeatureItem: View {
    var title: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "checkmark")
                .foregroundStyle(Color.deepPurpelColor)
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.black)
        }
    }
}
