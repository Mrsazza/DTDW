//
//  IncomeView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 10/11/24.
//

import SwiftUI

struct IncomeView: View {
    @Bindable var propertyData: PropertyData
    @StateObject var viewModel: PurchaseTermsViewModel
    
    var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
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
                    InputRow(label: "Administrative fees", placeholder: "$0", value: $propertyData.propertyCalculatabeleData.administrativeFees, formatter: numberFormatter)
                    InputRow(label: "Appliance rentals", placeholder: "$0", value: $propertyData.propertyCalculatabeleData.applianceRentals, formatter: numberFormatter)
                    InputRow(label: "Furniture rental", placeholder: "$0", value: $propertyData.propertyCalculatabeleData.furnitureRental, formatter: numberFormatter)
                    InputRow(label: "Parking", placeholder: "$0", value: $propertyData.propertyCalculatabeleData.parking, formatter: numberFormatter)
                    InputRow(label: "Laundry Income", placeholder: "$0", value: $propertyData.propertyCalculatabeleData.laundryIncome, formatter: numberFormatter)
                    InputRow(label: "Other Income", placeholder: "$0", value: $propertyData.propertyCalculatabeleData.otherIncome, formatter: numberFormatter)
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
                    SummaryRow(label: "Monthly Rent",monthly: viewModel.totalMonthlyRentalIncome(), yearly: Double(Int(viewModel.totalMonthlyRentalIncome())) * 12)
                    SummaryRow(label: "Administrative fees", monthly: viewModel.monthlyAdministrativeFees(), yearly: viewModel.yearlyAdministrativeFees())
                    SummaryRow(label: "Appliance rentals", monthly: viewModel.monthlyApplianceRentals(),
                               yearly: viewModel.yearlyApplianceRentals())
                    SummaryRow(label: "Furniture rental",
                               monthly: viewModel.monthlyFurnitureRental(),
                               yearly: viewModel.yearlyFurnitureRental())
                    SummaryRow(label: "Parking",
                               monthly: viewModel.monthlyParkingIncome(),
                               yearly: viewModel.yearlyParkingIncome())
                    SummaryRow(label: "Laundry Income",
                               monthly: viewModel.monthlyLaundryIncome(),
                               yearly: viewModel.yearlyLaundryIncome())
                    SummaryRow(label: "Other Income",
                               monthly: viewModel.monthlyOtherIncome(),
                               yearly: viewModel.yearlyOtherIncome())
                    
                    SummaryRow(label: "Total Income",
                               monthly: viewModel.totalMonthlyIncome(),
                               yearly: viewModel.totalMonthlyIncome() * 12)
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


// Summary Row
struct SummaryRow: View {
    let label: String
    let monthly: Double
    let yearly: Double?
    
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
