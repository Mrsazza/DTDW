//
//  OngoingExpenses.swift
//  DTDW
//
//  Created by Sopnil Sohan on 11/11/24.
//

import SwiftUI

struct OngoingExpensesView: View {
    @Bindable var propertyData: PropertyData
    @StateObject var viewModel: PurchaseTermsViewModel
    
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
        ZStack {
            ScrollView {
                VStack {
                    //Ongoing Expenses Section
                    VStack(spacing: 20) {
                        VStack(spacing: 10) {
                            Text("Ongoing Expenses")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.colorFont)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                            
                            RoundedRectangle(cornerRadius: 20)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .foregroundColor(Color.black.opacity(0.1))
                            
                            InputRow(label: "Vacancy (% of total Income)", placeholder: "5.0%", value: Binding($propertyData.propertyCalculatabeleData.vacancyOfTotalIncome), formatter: numberFormatter)

                        }
                        
                        VStack(spacing: 10) {
                            VStack(spacing: 10) {
                                Text("Property Expenses (Per Month)")
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(maxWidth: .infinity, maxHeight: 1)
                                    .foregroundColor(Color.black.opacity(0.1))
                            }
                            
                            InputRow(label: "Property Management", placeholder: "$50", value: Binding($propertyData.propertyCalculatabeleData.propertyManagement), formatter: numberFormatter)
                                .padding(.top, 5)
                            InputRow(label: "Leasing Costs", placeholder: "$0", value: Binding($propertyData.propertyCalculatabeleData.leasingCosts), formatter: numberFormatter)
                            InputRow(label: "Maintenance", placeholder: "$100%", value: Binding($propertyData.propertyCalculatabeleData.maintenance), formatter: decimalFormatter)
                            InputRow(label: "Utilities", placeholder: "$500", value: Binding($propertyData.propertyCalculatabeleData.utilities), formatter: numberFormatter)
                            InputRow(label: "Property Taxes", placeholder: "$412", value: Binding($propertyData.propertyCalculatabeleData.propertyTaxes), formatter: numberFormatter)
                            InputRow(label: "Insurance", placeholder: "$121", value: Binding($propertyData.propertyCalculatabeleData.insurance), formatter: numberFormatter)
                            InputRow(label: "Other", placeholder: "$0", value: Binding($propertyData.propertyCalculatabeleData.otherOngoingExpenses), formatter: numberFormatter)
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
                    .padding(.horizontal, 20)
                    
                    // Calculated Data Section
                    VStack(spacing: 15) {
                        // Header Section
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
                        
                        // Column Headers Section
                        HStack(alignment: .bottom) {
                            Text("Property Expenses")
                                .font(.system(size: 13))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.black)
                            
                            Spacer()
                            
                            Text("Year")
                                .font(.system(size: 13))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.black)
                                .frame(width: 80, alignment: .center)
                            
                            Text("% of \nTotal Income")
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.black)
                                .multilineTextAlignment(.center)
                                .frame(width: 80, alignment: .trailing)
                                .lineLimit(2)
                        }
                        .padding(.bottom, 10)
                        
                        // Property Expense Rows
                        VStack(spacing: 10) {
                            PropertyExpenseRow(
                                name: "Property Management",
                                yearAmount: "$\(Double(viewModel.propertyManagementYearAmount))",
                                percentage: viewModel.propertyManagementPercentage
                            )
                            
                            PropertyExpenseRow(
                                name: "Leasing Costs",
                                yearAmount: "$\(Int(viewModel.leasingCostsYearAmount))",
                                percentage: viewModel.leasingCostsPercentage
                            )

                            
                            PropertyExpenseRow(
                                name: "Maintenance", yearAmount: "$\(Int(viewModel.maintenanceYearAmount))",
                                percentage: viewModel.maintenancePercentage
                            )
                            
                            PropertyExpenseRow(
                                name: "Utilities", yearAmount: "$\(Int(viewModel.utilitiesYearAmount))",
                                percentage: viewModel.utilitiesPercentage
                                )
                            
                            PropertyExpenseRow(name: "Property Taxes", yearAmount: "$\(Int(viewModel.propertyTaxesYearAmount))", percentage: viewModel.propertyTaxesPercentage
                            )
                            
                            PropertyExpenseRow(name: "Insurance", yearAmount: "$\(Int(viewModel.insuranceYearAmount))", percentage: viewModel.insurancePercentage
                            )
                            
                            PropertyExpenseRow(name: "Other", yearAmount: "$\(Int(viewModel.otherYearAmount))", percentage: viewModel.otherPercentage
                            )
                            
                            PropertyExpenseRow(
                                name: "Total Expenses & Vacancy",
                                yearAmount: "$\(Int(viewModel.totalExpenses))",
                                percentage: viewModel.totalMonthly() > 0
                                ? viewModel.combinedExpensePercentages
                                : "\(String(format: "%.1f", propertyData.propertyCalculatabeleData.vacancyOfTotalIncome))%"
                            )
                        }
                        
                        // Divider line
                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .foregroundColor(Color.black.opacity(0.1))
                        
                        // Second Section Header (Expenses with Monthly Calculations)
                        VStack(spacing: 20) {
                            HStack {
                                Text("Expenses")
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.black)
                                
                                Spacer()
                                
                                Text("Year")
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.black)
                                    .frame(width: 80, alignment: .center)
                                
                                Text("Month")
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.black)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 80, alignment: .trailing)
                                    .lineLimit(2)
                            }
                            
                            // Expense Rows for Year and Month
                            VStack(spacing: 10) {
                                ExpenseRow(
                                    name: "Vacancy",
                                    yearAmount: "$\(Int(viewModel.vacancyYearAmount))",
                                    monthAmount: "$\(Int(viewModel.vacancyMonthAmount))"
                                )
                                ExpenseRow(
                                    name: "Net Operating Income",
                                    yearAmount: "$\(Int(viewModel.netOperatingIncomeYearAmount))",
                                    monthAmount: "$\(Int(viewModel.netOperatingIncomeMonthAmount))"
                                )
                                HStack {
                                    Text("Total Expenses & Vacancy")
                                        .font(.system(size: 13))
                                        .foregroundStyle(Color.black)
                                    
                                    Spacer()
                                    
                                   
                                    Text("$\(Int(viewModel.totalExpensesAndVacancyMonthAmount))")
                                        .font(.system(size: 13))
                                        .foregroundStyle(Color.black)
                                        .frame(width: 80, alignment: .trailing)
                                }
                                .padding(.bottom, 20)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
                    .padding(.horizontal, 20)
                }
                .padding([.top, .bottom], 20)
            }
        }
    }
}


// Custom Row for Property Expenses
struct PropertyExpenseRow: View {
    var name: String
    var yearAmount: String
    var percentage: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 13))
                .foregroundStyle(Color.black)
            
            Spacer()
            
            Text(yearAmount)
                .font(.system(size: 13))
                .foregroundStyle(Color.black)
                .frame(width: 80, alignment: .center)
            
            Text(percentage)
                .font(.system(size: 13))
                .foregroundStyle(Color.black)
                .frame(width: 80, alignment: .trailing)
        }
    }
}

// Custom Row for Expenses (Year & Month)
struct ExpenseRow: View {
    var name: String
    var yearAmount: String
    var monthAmount: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 13))
                .foregroundStyle(Color.black)
            
            Spacer()
            
            Text(yearAmount)
                .font(.system(size: 13))
                .foregroundStyle(Color.black)
                .frame(width: 80, alignment: .center)
            
            Text(monthAmount)
                .font(.system(size: 13))
                .foregroundStyle(Color.black)
                .frame(width: 80, alignment: .trailing)
        }
    }
}
