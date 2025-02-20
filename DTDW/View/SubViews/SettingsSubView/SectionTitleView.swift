//
//  SectionTitleView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct SectionTitleView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.system(size: 22, weight: .semibold))
            .foregroundColor(Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 1)))
            .padding(.top)
    }
}
