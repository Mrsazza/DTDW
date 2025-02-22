//
//  CalculatedDataView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PropertyTermsCalculatedDataView: View {
    @StateObject var viewModel: PropertyTermsViewModel
    
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
                HStack {
                    Text("Discount/ Profit")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(viewModel.discountProfitPercentage(), specifier: "%.1f")%")
                        .frame(width: 80, alignment: .trailing)
                    
                    Text("$\(viewModel.discountProfit(), specifier: "%.0f")")
                        .frame(width: 100, alignment: .trailing)
                }
                HStack {
                    Text("Down Payment")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("")
                        .frame(width: 80, alignment: .trailing)
                    
                    Text("$\(viewModel.downPaymentAmount(), specifier: "%.0f")")
                        .frame(width: 100, alignment: .trailing)
                }
                HStack {
                    Text("Amount Financed")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(viewModel.financedPercentage(), specifier: "%.1f")%")
                    
                    Text("$\(viewModel.amountFinanced(), specifier: "%.0f")")
                        .frame(width: 100, alignment: .trailing)
                }
                HStack {
                    Text("Mortgage Payment")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("$\(viewModel.monthlyMortgagePayment(), specifier: "%.0f")")
                        .frame(width: 80, alignment: .trailing)
                    
                    Text("$\(viewModel.monthlyMortgagePayment() * 12, specifier: "%.0f")")
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
