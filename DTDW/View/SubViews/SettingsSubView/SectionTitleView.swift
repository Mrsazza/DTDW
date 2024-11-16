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
            .foregroundStyle(Color.black)
            .padding(.top)
    }
}
