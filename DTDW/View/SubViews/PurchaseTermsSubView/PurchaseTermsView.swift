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
//                    TextField("$", value: Binding(
//                        get: { propertyData.propertyCalculatabeleData?.marketValue ?? 0 },
//                        set: { newValue in
//                            if propertyData.propertyCalculatabeleData == nil {
//                                propertyData.propertyCalculatabeleData = PropertyCalculatableData()
//                            }
//                            propertyData.propertyCalculatabeleData?.marketValue = newValue
//                        }
//                    ), formatter: numberFormatter)
                    .formattedTextField()
                }
                
                // Purchase Price
                HStack {
                    Text("Purchase Price")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    TextField("$", value: $propertyData.propertyCalculatabeleData.purchasePriceValue, format: .number)
                        .formattedTextField()
//                    TextField("$", value: Binding(
//                        get: { propertyData.propertyCalculatabeleData?.purchasePriceValue ?? 0 },
//                        set: { newValue in
//                            if propertyData.propertyCalculatabeleData == nil {
//                                propertyData.propertyCalculatabeleData = PropertyCalculatableData()
//                            }
//                            propertyData.propertyCalculatabeleData?.purchasePriceValue = newValue
//                        }
//                    ), formatter: numberFormatter)
//                    .formattedTextField()
                }
                
//                // Down Payment (%)
                HStack {
                    Text("Down Payment (%)")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    TextField("$", value: $propertyData.propertyCalculatabeleData.downPaymentValue, formatter: decimalFormatter)
//                    TextField("%", value: Binding(
//                        get: { (propertyData.propertyCalculatabeleData?.downPaymentValue ?? 0) * 100 },
//                        set: { newValue in
//                            if propertyData.propertyCalculatabeleData == nil {
//                                propertyData.propertyCalculatabeleData = PropertyCalculatableData()
//                            }
//                            propertyData.propertyCalculatabeleData?.downPaymentValue = newValue / 100
//                        }
//                    ), formatter: decimalFormatter)
                    .formattedTextField()
                }
//                
//                // Interest Rate (%)
                HStack {
                    Text("Interest Rate (%)")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    TextField("$", value: $propertyData.propertyCalculatabeleData.interestRateValue, formatter: decimalFormatter)
//                    TextField("%", value: Binding(
//                        get: { (propertyData.propertyCalculatabeleData?.interestRateValue ?? 0) * 100 },
//                        set: { newValue in
//                            if propertyData.propertyCalculatabeleData == nil {
//                                propertyData.propertyCalculatabeleData = PropertyCalculatableData()
//                            }
//                            propertyData.propertyCalculatabeleData?.interestRateValue = newValue / 100
//                        }
//                    ), formatter: decimalFormatter)
                    .formattedTextField()
                }
//                
//                // Mortgage Length (Years)
                HStack {
                    Text("Mortgage Length (years)")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    TextField("$", value: $propertyData.propertyCalculatabeleData.mortgageLengthValue, format: .number)
//                    TextField("Years", value: Binding(
//                        get: { propertyData.propertyCalculatabeleData?.mortgageLengthValue ?? 0 },
//                        set: { newValue in
//                            if propertyData.propertyCalculatabeleData == nil {
//                                propertyData.propertyCalculatabeleData = PropertyCalculatableData()
//                            }
//                            propertyData.propertyCalculatabeleData?.mortgageLengthValue = newValue
//                        }
//                    ), formatter: numberFormatter)
                    .formattedTextField()
                }
            }
//            .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .clipShape(RoundedCornerShape(corners: [.topLeft, .topRight], radius: 20))
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
//        .onAppear {
//            if propertyData.propertyCalculatabeleData == nil {
//                propertyData.propertyCalculatabeleData = PropertyCalculatableData()
//            }
//        }
    }
}

extension View {
    // Modifier to style text fields
    func formattedTextField() -> some View {
        self
            .font(.system(size: 13))
            .keyboardType(.numbersAndPunctuation)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 10)
            .minimumScaleFactor(0.05)
            .frame(width: 120, height: 35)
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
            )
    }
}

