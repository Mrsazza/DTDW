//
//  PurchaseTermsView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PurchaseTermsView: View {
    @Bindable var propertyData: PropertyData

    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    private let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text("Purchase Terms")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.colorFont)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(Color.black.opacity(0.1))
            }
            
            VStack(spacing: 10) {
                // Market Value
                HStack {
                    Text("Market Value")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    TextField("$", value: $propertyData.propertyCalculatabeleData.marketValue, format: .number)
                        .formattedTextField()
                }
                
                HStack {
                    Text("Purchase Price")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    TextField("$", value: $propertyData.propertyCalculatabeleData.purchasePriceValue, format: .number)
                        .formattedTextField()
                }
                
                HStack {
                    Text("Down Payment (%)")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    TextField("$", value: $propertyData.propertyCalculatabeleData.downPaymentValue, formatter: decimalFormatter)
                    .formattedTextField()
                }
                
                HStack {
                    Text("Interest Rate (%)")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    TextField("$", value: $propertyData.propertyCalculatabeleData.interestRateValue, formatter: decimalFormatter)
                    .formattedTextField()
                }
                
                HStack {
                    Text("Mortgage Length (years)")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    TextField("$", value: $propertyData.propertyCalculatabeleData.mortgageLengthValue, format: .number)
                    .formattedTextField()
                }
                .padding(.bottom, 15)
            }
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

extension View {
    // Modifier to style text fields
    func formattedTextField() -> some View {
        self
            .font(.system(size: 13))
            .foregroundStyle(Color.black)
            .keyboardType(.numberPad)
            .frame(width: 80)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 5)
            .minimumScaleFactor(0.05)
            .frame(width: 100, height: 30)
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
            )
    }
}

