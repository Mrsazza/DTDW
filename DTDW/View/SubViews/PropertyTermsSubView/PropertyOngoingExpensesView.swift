//
//  OngoingExpenses.swift
//  DTDW
//
//  Created by Sopnil Sohan on 11/11/24.
//

import SwiftUI

struct PropertyOngoingExpensesView: View {
    @Bindable var propertyData: PropertyDataModel
    @StateObject var viewModel: PropertyTermsViewModel
    
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
                            
                            InputRow(label: "Vacancy (% of total Income)", placeholder: "5.0%", value: Binding($propertyData.propertyCalculatabeleData.vacancyOfTotalIncome), formatter: decimalFormatter)

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
                            
                            InputRow(label: "Property Management", placeholder: "$50", value: Binding($propertyData.propertyCalculatabeleData.propertyManagement), formatter: decimalFormatter)
                                .padding(.top, 5)
                            InputRow(label: "Leasing Costs", placeholder: "$0", value: Binding($propertyData.propertyCalculatabeleData.leasingCosts), formatter: decimalFormatter)
                            InputRow(label: "Maintenance", placeholder: "$100%", value: Binding($propertyData.propertyCalculatabeleData.maintenance), formatter: decimalFormatter)
                            InputRow(label: "Utilities", placeholder: "$500", value: Binding($propertyData.propertyCalculatabeleData.utilities), formatter: decimalFormatter)
                            InputRow(label: "Property Taxes", placeholder: "$412", value: Binding($propertyData.propertyCalculatabeleData.propertyTaxes), formatter: decimalFormatter)
                            InputRow(label: "Insurance", placeholder: "$121", value: Binding($propertyData.propertyCalculatabeleData.insurance), formatter: decimalFormatter)
                            InputRow(label: "Other", placeholder: "$0", value: Binding($propertyData.propertyCalculatabeleData.otherOngoingExpenses), formatter: decimalFormatter)
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
                                yearAmount: "$\(String(format: "%.0f",(viewModel.propertyManagementYearAmount)))",
                                percentage: viewModel.propertyManagementPercentage
                            )
                            
                            PropertyExpenseRow(
                                name: "Leasing Costs",
                                yearAmount: "$\(String(format: "%.0f",(viewModel.leasingCostsYearAmount)))",
                                percentage: viewModel.leasingCostsPercentage
                            )

                            
                            PropertyExpenseRow(
                                name: "Maintenance", yearAmount: "$\(String(format: "%.0f",(viewModel.maintenanceYearAmount)))",
                                percentage: viewModel.maintenancePercentage
                            )
                            
                            PropertyExpenseRow(
                                name: "Utilities", yearAmount: "$\(String(format: "%.0f",(viewModel.utilitiesYearAmount)))",
                                percentage: viewModel.utilitiesPercentage
                                )
                            
                            PropertyExpenseRow(name: "Property Taxes", yearAmount: "$\(String(format: "%.0f",(viewModel.propertyTaxesYearAmount)))", percentage: viewModel.propertyTaxesPercentage
                            )
                            
                            PropertyExpenseRow(name: "Insurance", yearAmount: "$\(String(format: "%.0f",(viewModel.insuranceYearAmount)))", percentage: viewModel.insurancePercentage
                            )
                            
                            PropertyExpenseRow(name: "Other", yearAmount: "$\(String(format: "%.0f",(viewModel.otherYearAmount)))", percentage: viewModel.otherPercentage
                            )
                            
                            PropertyExpenseRow(
                                name: "Total Expenses & Vacancy",
                                yearAmount: "$\(String(format: "%.0f",(viewModel.totalExpenses)))",
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
                                    yearAmount: ("$\(String(format: "%.0f",(viewModel.vacancyYearAmount)))"),
                                    monthAmount: ("$\(String(format: "%.0f",(viewModel.vacancyMonthAmount)))")
                                )
                                ExpenseRow(
                                    name: "Net Operating Income",
                                    yearAmount: ("$\(String(format: "%.0f",(viewModel.netOperatingIncomeYearAmount)))"),
                                    monthAmount: ("$\(String(format: "%.0f",(viewModel.netOperatingIncomeMonthAmount)))")
                                )
                                HStack {
                                    Text("Total Expenses & Vacancy")
                                        .font(.system(size: 13))
                                        .foregroundStyle(Color.black)
                                    
                                    Spacer()
                                   
                                    Text("$\(String(format: "%.0f",(viewModel.totalExpensesAndVacancyMonthAmount)))")
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
