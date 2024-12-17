//
//  PurchaseTermsView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PurchaseTermsView: View {
    @EnvironmentObject var viewModel: PurchaseTermsManager
    @Bindable var propertyData: PropertyData
    
    private let numberFormatter = NumberFormatter()
    private let decimalFormatter = NumberFormatter()
    
    init(viewModel: PurchaseTermsManager, propertyData: PropertyData) {
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = 2
        self.propertyData = propertyData
    }
    
    var marketValueBinding: Binding<Int> {
            Binding(
                get: {
                    propertyData.propertyCalculatabeleData?.marketValue ?? 0
                },
                set: { newValue in
                    if propertyData.propertyCalculatabeleData == nil {
                        propertyData.propertyCalculatabeleData = PropertyCalculatableData()
                    }
                    propertyData.propertyCalculatabeleData?.marketValue = newValue
                }
            )
        }
    
    var body: some View {
        VStack(spacing: 20) {
//            VStack(spacing: 10) {
//                Text("Purchase Terms")
//                    .font(.system(size: 16))
//                    .fontWeight(.bold)
//                    .foregroundStyle(Color.colorFont)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.top, 20)
//                
//                RoundedRectangle(cornerRadius: 20)
//                    .frame(maxWidth: .infinity, maxHeight: 1)
//                    .foregroundColor(Color.black.opacity(0.1))
//            }
            
            VStack(spacing: 10) {
                HStack {
                    Text("Market Value")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    TextField("$", value: marketValueBinding, formatter: NumberFormatter())
                        .font(.system(size: 13))
                        .keyboardType(.decimalPad)
                        .foregroundColor(.black)
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
//                HStack {
//                    Text("Purchase Price")
//                        .font(.system(size: 13))
//                        .foregroundStyle(.black)
//                    
//                    Spacer()
//                    
//                    TextField("$", value: $viewModel.purchasePriceValue, formatter: NumberFormatter())
//                        .font(.system(size: 13))
//                        .keyboardType(.decimalPad)
//                        .foregroundColor(.black)
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal, 5)
//                        .minimumScaleFactor(0.05)
//                        .frame(width: 100, height: 30)
//                        .background(Color.white)
//                        .cornerRadius(5)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
//                        )
//                    
//                    
//                }
//                HStack {
//                    Text("Down Payment (%)")
//                        .font(.system(size: 13))
//                        .foregroundStyle(.black)
//                    
//                    Spacer()
//                    
//                    TextField("$", value: $viewModel.downPaymentValue, formatter: NumberFormatter())
//                        .font(.system(size: 13))
//                        .keyboardType(.decimalPad)
//                        .foregroundColor(.black)
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal, 5)
//                        .minimumScaleFactor(0.05)
//                        .frame(width: 100, height: 30)
//                        .background(Color.white)
//                        .cornerRadius(5)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
//                        )
//                    
//                    
//                }
//                HStack {
//                    Text("Interest Rate (%)")
//                        .font(.system(size: 13))
//                        .foregroundStyle(.black)
//                    
//                    Spacer()
//                    
//                    TextField("$", value: $viewModel.interestRateValue, formatter: decimalFormatter)
//                        .font(.system(size: 13))
//                        .keyboardType(.decimalPad)
//                        .foregroundColor(.black)
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal, 5)
//                        .minimumScaleFactor(0.05)
//                        .frame(width: 100, height: 30)
//                        .background(Color.white)
//                        .cornerRadius(5)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
//                        )
//                    
//                    
//                }
//                HStack {
//                    Text("Mortgage Length (years)")
//                        .font(.system(size: 13))
//                        .foregroundStyle(.black)
//                    
//                    Spacer()
//                    
//                    TextField("$", value: $viewModel.mortgageLengthValue, formatter: NumberFormatter())
//                        .font(.system(size: 13))
//                        .keyboardType(.decimalPad)
//                        .foregroundColor(.black)
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal, 5)
//                        .minimumScaleFactor(0.05)
//                        .frame(width: 100, height: 30)
//                        .background(Color.white)
//                        .cornerRadius(5)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
//                        )
//                     
//                }
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}
