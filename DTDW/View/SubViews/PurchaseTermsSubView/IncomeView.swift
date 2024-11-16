//
//  IncomeView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 10/11/24.
//

import SwiftUI

struct IncomeView: View {
    @State private var administrativeFees: Int? = nil
    @State private var applianceRentals: Int? = nil
    @State private var furnitureRental: Int? = nil
    @State private var parking: Int? = nil
    @State private var laundryIncome: Int? = nil
    @State private var otherIncome: Int? = nil

    // Formatter for numbers without decimals
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    // Computed property for total income
    private var totalIncome: Int {
        [administrativeFees, applianceRentals, furnitureRental, parking, laundryIncome, otherIncome]
            .compactMap { $0 }
            .reduce(0, +)
    }
    
    var body: some View {
        VStack {
            SectionView(title: "Rental Assumptions") {
                VStack(spacing: 10) {
                    IncomeInputRow(label: "Administrative fees", value: $administrativeFees, formatter: numberFormatter)
                    IncomeInputRow(label: "Appliance rentals", value: $applianceRentals, formatter: numberFormatter)
                    IncomeInputRow(label: "Furniture rental", value: $furnitureRental, formatter: numberFormatter)
                    IncomeInputRow(label: "Parking", value: $parking, formatter: numberFormatter)
                    IncomeInputRow(label: "Laundry Income", value: $laundryIncome, formatter: numberFormatter)
                    IncomeInputRow(label: "Other Income", value: $otherIncome, formatter: numberFormatter)
                }
            }
            
            SectionView(title: "Calculated Data") {
                VStack(spacing: 15) {
                    // Pass both monthly and yearly values
                    HStack {
                        Spacer()
                        
                        Text("Month")
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                            .fontWeight(.bold)
                            .frame(width: 80, alignment: .trailing)
                        
                        Text("Year")
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                            .fontWeight(.bold)
                            .frame(width: 80, alignment: .trailing)
                    }
                    
                    SummaryRow(label: "Monthly Rent", monthly: 3000, yearly: 36000)
                    
                    // For other rows, only pass monthly if yearly isn't required
                    SummaryRow(label: "Administrative fees", monthly: administrativeFees ?? 0, yearly: (administrativeFees ?? 0) * 12)
                    SummaryRow(label: "Appliance rentals", monthly: applianceRentals ?? 0, yearly: (applianceRentals ?? 0) * 12)
                    SummaryRow(label: "Furniture rental", monthly: furnitureRental ?? 0, yearly: (furnitureRental ?? 0) * 12)
                    SummaryRow(label: "Parking", monthly: parking ?? 0, yearly: (parking ?? 0) * 12)
                    SummaryRow(label: "Laundry Income", monthly: laundryIncome ?? 0, yearly: (laundryIncome ?? 0) * 12)
                    SummaryRow(label: "Other Income", monthly: otherIncome ?? 0, yearly: (otherIncome ?? 0) * 12)
                    
                    // Pass totalIncome with yearly value directly
                    SummaryRow(label: "Total Income", monthly: totalIncome, yearly: totalIncome * 12)
                }
            }

        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
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
                .multilineTextAlignment(.trailing)
                .frame(width: 80)
                .textFieldStyle(PlainTextFieldStyle())
        }
    }
}

// Summary Row
// Summary Row
struct SummaryRow: View {
    let label: String
    let monthly: Int
    let yearly: Int? // Optional yearly value
    
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


//#Preview {
//    IncomeView()
//}
