//
//  PremiumSectionTitleView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PremiumSectionTitleView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 22, weight: .semibold))
    }
}
