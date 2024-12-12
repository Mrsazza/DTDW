//
//  IncomeView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 10/11/24.
//

import SwiftUI

struct IncomeView: View {
    @EnvironmentObject var viewModel: PurchaseTermsManager
    
    var body: some View {
        VStack(spacing: 20) {
            // Income Input Section
            SectionView(title: "Income") {
                VStack(spacing: 10) {
                    HStack {
                        Spacer()
                        Text("Month")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .frame(width: 100, alignment: .center)
                    }
                    IncomeInputRow(label: "Administrative fees", value: $viewModel.administrativeFees, formatter: viewModel.numberFormatter)
                    IncomeInputRow(label: "Appliance rentals", value: $viewModel.applianceRentals, formatter: viewModel.numberFormatter)
                    IncomeInputRow(label: "Furniture rental", value: $viewModel.furnitureRental, formatter: viewModel.numberFormatter)
                    IncomeInputRow(label: "Parking", value: $viewModel.parking, formatter: viewModel.numberFormatter)
                    IncomeInputRow(label: "Laundry Income", value: $viewModel.laundryIncome, formatter: viewModel.numberFormatter)
                    IncomeInputRow(label: "Other Income", value: $viewModel.otherIncome, formatter: viewModel.numberFormatter)
                }
            }
            // Calculated Data Section
            SectionView(title: "Calculated Data") {
                VStack(spacing: 15) {
                    HStack {
                        Spacer()
                        Text("Month")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .frame(width: 80, alignment: .trailing)
                        
                        Text("Year")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .frame(width: 80, alignment: .trailing)
                    }
                    // Display individual incomes and totals
                    SummaryRow(label: "Monthly Rent", monthly: Int(viewModel.totalMonthly), yearly: Int((viewModel.totalMonthly)) * 12)
                    
                    SummaryRow(label: "Administrative fees", monthly: viewModel.administrativeFees ?? 0, yearly: (viewModel.administrativeFees ?? 0) * 12)
                    SummaryRow(label: "Appliance rentals", monthly: viewModel.applianceRentals ?? 0, yearly: (viewModel.applianceRentals ?? 0) * 12)
                    SummaryRow(label: "Furniture rental", monthly: viewModel.furnitureRental ?? 0, yearly: (viewModel.furnitureRental ?? 0) * 12)
                    SummaryRow(label: "Parking", monthly: viewModel.parking ?? 0, yearly: (viewModel.parking ?? 0) * 12)
                    SummaryRow(label: "Laundry Income", monthly: viewModel.laundryIncome ?? 0, yearly: (viewModel.laundryIncome ?? 0) * 12)
                    SummaryRow(label: "Other Income", monthly: viewModel.otherIncome ?? 0, yearly: (viewModel.otherIncome ?? 0) * 12)
                    SummaryRow(label: "Total Income",
                               monthly: Int(Double(viewModel.totalIncome) + viewModel.totalMonthly), // Total monthly income (additional + rental assumptions)
                               yearly: Int(Double(viewModel.totalIncome) + viewModel.totalMonthly) * 12 // Total yearly income
                    )
                }
            }
        }
        .padding()
    }
}

// MARK: - Reusable Components

// Section title and container
struct SectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color.deepPurpelColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color.black.opacity(0.1))
            
            content
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
    }
}

// Income Input Row
struct IncomeInputRow: View {
    let label: String
    @Binding var value: Int?
    let formatter: NumberFormatter
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(Color.black)
            Spacer()
            
            TextField("$0", value: $value, formatter: formatter)
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
}

// Summary Row
struct SummaryRow: View {
    let label: String
    let monthly: Int
    let yearly: Int?
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(Color.black)
            Spacer()
            Text("$\(NSNumber(value: monthly), formatter: numberFormatter)") // Format the monthly value
                .font(.system(size: 13))
                .foregroundStyle(Color.black)
                .frame(width: 80, alignment: .trailing)
            
            // Only show yearly if it's not nil
            if let yearly = yearly {
                Text("$\(NSNumber(value: yearly), formatter: numberFormatter)") // Format the yearly value
                    .font(.system(size: 13))
                    .foregroundStyle(Color.black)
                    .frame(width: 80, alignment: .trailing)
            }
        }
    }
}

// Global number formatter for dollar amounts
private let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0
    return formatter
}()
