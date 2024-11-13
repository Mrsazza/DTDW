//
//  SubscriptionOptionView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct SubscriptionOptionView: View {
    var title: String
    var subtitle: String
    var backgroundColor: Color
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 30) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(isSelected ? .white : .black)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundStyle(isSelected ? .white : .black)
                    
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundStyle(isSelected ? .white.opacity(0.5) : .black.opacity(0.5))
                }
                
                Spacer()
            }
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, maxHeight: 80)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(color: isSelected ? Color.clear : Color.black.opacity(0.15), radius: 8, x: 0, y: 1)
        }
    }
}
