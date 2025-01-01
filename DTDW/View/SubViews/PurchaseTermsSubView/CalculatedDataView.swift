//
//  CalculatedDataView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct CalculatedDataView: View {
    @Bindable var propertyData: PropertyData // Use SwiftData's property
    
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

                    // Percentage Calculation
                    Text("\(discountProfitPercentage(), specifier: "%.1f")%")
                        .frame(width: 80, alignment: .trailing)

                    // Absolute Profit
                    Text("$\(discountProfit(), specifier: "%.2f")")
                        .frame(width: 100, alignment: .trailing)
                }

                // Down Payment Row
                HStack {
                    Text("Down Payment")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("")
                        .frame(width: 80, alignment: .trailing)

                    Text("$\(downPaymentAmount(), specifier: "%.2f")")
                        .frame(width: 100, alignment: .trailing)
                }

                // Amount Financed Row
                HStack {
                    Text("Amount Financed")
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Dynamically calculate financed percentage
                    Text("\(financedPercentage(), specifier: "%.1f")%")

                    Text("$\(amountFinanced(), specifier: "%.2f")")
                        .frame(width: 100, alignment: .trailing)
                }

                // Mortgage Payment Row
                HStack {
                    Text("Mortgage Payment")
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Monthly Payment
                    Text("$\(monthlyMortgagePayment(), specifier: "%.2f")")
                        .frame(width: 80, alignment: .trailing)

                    // Annual Payment
                    Text("$\(monthlyMortgagePayment() * 12, specifier: "%.2f")")
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

    // MARK: - Helper Calculations
    private func discountProfit() -> Double {
        let marketValue = Double(propertyData.propertyCalculatabeleData.marketValue)
        let purchasePrice = Double(propertyData.propertyCalculatabeleData.purchasePriceValue)
        return max(0, marketValue - purchasePrice)
    }

    private func discountProfitPercentage() -> Double {
        let marketValue = Double(propertyData.propertyCalculatabeleData.marketValue) // Avoid division by zero
        return discountProfit() / marketValue * 100
    }

    private func downPaymentAmount() -> Double {
        let purchasePrice = Double(propertyData.propertyCalculatabeleData.purchasePriceValue)
        let downPayment = Double(propertyData.propertyCalculatabeleData.downPaymentValue) / 100
        return purchasePrice * downPayment
    }

    private func amountFinanced() -> Double {
        let purchasePrice = Double(propertyData.propertyCalculatabeleData.purchasePriceValue)
        return purchasePrice - downPaymentAmount()
    }

    private func financedPercentage() -> Double {
        return 100.0 - Double((propertyData.propertyCalculatabeleData.downPaymentValue))
    }

    private func monthlyMortgagePayment() -> Double {
        let interestRate = Double(propertyData.propertyCalculatabeleData.interestRateValue) / 100 / 12
        let loanTermMonths = Double((propertyData.propertyCalculatabeleData.mortgageLengthValue) * 12)
        let principal = amountFinanced()

        guard interestRate > 0 else { return principal / loanTermMonths }
        return principal * (interestRate * pow(1 + interestRate, loanTermMonths)) / (pow(1 + interestRate, loanTermMonths) - 1)
    }
}
