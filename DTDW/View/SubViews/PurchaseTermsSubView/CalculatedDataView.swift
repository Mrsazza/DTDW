//
//  CalculatedDataView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct CalculatedDataView: View {
    @EnvironmentObject var viewModel: PurchaseTermsManager
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text("Calculated Data")
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
                // Discount / Profit Row
                HStack {
                    Text("Discount/ Profit")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(((Double(viewModel.marketValue ?? 0) - Double(viewModel.purchasePriceValue ?? 0)) / Double(viewModel.marketValue ?? 1)) * 100, specifier: "%.1f")%")
                        .frame(width: 80, alignment: .trailing)
                    
                    Text("$\(viewModel.discountProfit, specifier: "%.2f")")
                        .frame(width: 100, alignment: .trailing)
                }

                // Down Payment Row
                HStack {
                    Text("Down Payment")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("")
                        .frame(width: 80, alignment: .trailing)
                    
                    Text("$\(viewModel.downPaymentAmount, specifier: "%.2f")")
                        .frame(width: 100, alignment: .trailing)
                }

                HStack {
                    Text("Amount Financed")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Dynamically calculate the financed percentage
                    Text("\(String(format: "%.1f", 100.0 - (Double(viewModel.downPaymentValue ?? 0))))%")
                    
                    Text("$\(viewModel.amountFinanced, specifier: "%.2f")")
                        .frame(width: 100, alignment: .trailing)
                }

                // Mortgage Payment Row
                HStack {
                    Text("Mortgage Payment")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("$\(viewModel.monthlyMortgagePayment, specifier: "%.2f")")
                        .frame(width: 80, alignment: .trailing)
                    
                    Text("$\(viewModel.monthlyMortgagePayment * 12, specifier: "%.2f")") // Annual Payment
                        .frame(width: 100, alignment: .trailing)
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.system(size: 13))
            .foregroundStyle(Color.black)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}
