//
//  GradientButton.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color(#colorLiteral(red: 0.979, green: 0.924, blue: 0.857, alpha: 1)))
                .padding()
                .frame(maxWidth: 236, maxHeight: 38)
                .background(Color.buttonLinierGradientColor)
                .overlay {
                    RoundedRectangle(cornerRadius: 43.85)
                        .stroke(LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1491629464)),Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1491629464))], startPoint: .leading, endPoint: .trailing),lineWidth: 1)
                }
                .cornerRadius(43.85)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.01)),radius: 15, x: 0, y: 4)
        }
    }
}
