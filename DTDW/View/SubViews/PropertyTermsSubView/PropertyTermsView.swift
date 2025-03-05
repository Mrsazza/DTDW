//
//  PurchaseTermsView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PropertyTermsView: View {
    @Bindable var propertyData: PropertyDataModel
    
    private let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 20) {
            // Purchase Terms Header
            VStack(spacing: 10) {
                Text("Purchase Terms")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.colorFont)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                Divider()
                    .background(Color.black.opacity(0.1))
            }
            
            // Purchase Terms Input Fields
            VStack(spacing: 10) {
                // Market Value
                PropertyTermRow(label: "Market Value", value: $propertyData.propertyCalculatabeleData.marketValue, isCurrency: true)
                
                // Purchase Price
                PropertyTermRow(label: "Purchase Price", value: $propertyData.propertyCalculatabeleData.purchasePriceValue, isCurrency: true)
                
                // Down Payment (%)
                PropertyTermRow(label: "Down Payment (%)", value: $propertyData.propertyCalculatabeleData.downPaymentValue, isCurrency: false)
                
                // Interest Rate (%)
                PropertyTermRow(label: "Interest Rate (%)", value: $propertyData.propertyCalculatabeleData.interestRateValue, isCurrency: false)
                
                // Mortgage Length (years)
                PropertyTermRow(label: "Mortgage Length (years)", value: $propertyData.propertyCalculatabeleData.mortgageLengthValue, isCurrency: false)
            }
            .padding(.bottom, 15)
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

// Custom View for Property Term Rows
struct PropertyTermRow: View {
    let label: String
    @Binding var value: Double // Non-optional Double
    let isCurrency: Bool
    
    @State private var textValue: String = "0" // Default to "0"
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(.black)
            
            Spacer()
            
            TextField(isCurrency ? "$0" : "", text: $textValue)
                .formattedTextField()
                .keyboardType(.decimalPad)
                .onChange(of: textValue) {
                    // Handle empty string case
                    if textValue.isEmpty {
                        textValue = "0" // Set to "0" if empty
                        value = 0
                    } else {
                        // Convert the text input to a Double, or set to 0 if the conversion fails
                        value = Double(textValue) ?? 0
                    }
                }
                .onAppear {
                    // Initialize the text value with the current Double value
                    textValue = String(format: "%.0f", value)
                }
        }
    }
}

// Modifier to style text fields
extension View {
    func formattedTextField() -> some View {
        self
            .font(.system(size: 13))
            .foregroundStyle(Color.black)
            .keyboardType(.decimalPad)
            .frame(width: 80)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.3)
            .padding(.horizontal, 5)
            .frame(height: 30)
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
            )
    }
}
