//
//  SettingOptionRow.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct SettingOptionRow: View {
    var title: String
    var icon: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32)
            Text(title)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color.black)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(Color.colorFont)
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .onTapGesture(perform: action)
    }
}
