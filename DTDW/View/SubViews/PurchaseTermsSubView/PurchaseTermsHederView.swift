//
//  PurchaseTermsHederView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PurchaseTermsHederView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.purchaseHeaderButtonFillColor) // Sets the background color of the circle
                        .frame(width: 44, height: 44)
                        .shadow(color:Color.purchaseHeaderButtonShadowColor ,radius: 4, x: 2, y: 2) // Adds shadow to the circle
                    
                    Circle()
                        .stroke(Color.purchaseHeaderButtonStrokeColor,lineWidth: 1) // Adds a stroke outline around the circle
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.colorFont)
                }
            }
            
            Spacer()
            
            HStack(spacing: 2) {
                Text("Land Landy Apt.")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Button {
                    
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                }
                .padding(.top, 3)
            }
            Spacer()
            
            Button {
                
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.purchaseHeaderButtonFillColor) // Sets the background color of the circle
                        .frame(width: 44, height: 44)
                        .shadow(color:Color.purchaseHeaderButtonShadowColor ,radius: 4, x: 2, y: 2) // Adds shadow to the circle
                    
                    Circle()
                        .stroke(Color.purchaseHeaderButtonStrokeColor,lineWidth: 1) // Adds a stroke outline around the circle
                        .frame(width: 44, height: 44)
                    
                    Image("cameraImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 24)
                }
            }
            
        }
        .padding(.leading, 10)
        .padding(.trailing, 20)
        .padding(.bottom, 20)
        .background(Color.purchaseHeaderButtonBackgroundColor)
    }
}
