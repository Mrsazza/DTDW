//
//  PremiumGradientButton.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PremiumGradientButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color(#colorLiteral(red: 0.979, green: 0.924, blue: 0.857, alpha: 1)))
                .padding()
                .frame(maxWidth: 321, maxHeight: 50)
                .background(Color.buttonLinierGradientColor)
                .cornerRadius(35)
        }
        .padding(.top, 10)
    }
}
