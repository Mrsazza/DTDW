//
//  PurchaseTermsView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PurchaseTermsView: View {
    @State private var marketValue: Int?
    @State private var purchasePriceValue: Int?
    @State private var downPaymentValue: Int?
    @State private var interestRateValue: Double?
    @State private var mortgageLengthValue: Int?
    
    // Formatter for numbers without decimals
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    // Formatter for percentages and rates with decimals
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
                InputRow(label: "Market Value", placeholder: "$400,000", value: $marketValue, formatter: numberFormatter)
                InputRow(label: "Purchase Price", placeholder: "$250,000", value: $purchasePriceValue, formatter: numberFormatter)
                InputRow(label: "Down Payment (%)", placeholder: "10%", value: $downPaymentValue, formatter: numberFormatter)
                InputRow(label: "Interest Rate (%)", placeholder: "6.50", value: $interestRateValue, formatter: decimalFormatter)
                InputRow(label: "Mortgage Length (years)", placeholder: "30", value: $mortgageLengthValue, formatter: numberFormatter)
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.blackOnePercentColor, radius: 4, x: 1, y: 1)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}
