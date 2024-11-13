//
//  OngoingExpenses.swift
//  DTDW
//
//  Created by Sopnil Sohan on 11/11/24.
//

import SwiftUI

struct OngoingExpenses: View {
    @State private var VacancyOfTotalIncome: Int?
    @State private var marketValue: Int?
    @State private var purchasePriceValue: Int?
    @State private var downPaymentValue: Int?
    @State private var interestRateValue: Double?
    @State private var mortgageLengthValue: Int?
    
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
                    // Ongoing Expenses Section
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
                            
                            InputRow(label: "Vacancy (% of total Income)", placeholder: "5.0%", value: $VacancyOfTotalIncome, formatter: numberFormatter)
                        }
                        
                        VStack(spacing: 10) {
                            VStack(spacing: 10) {
                                Text("Property Expenses (Per Month)")
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(maxWidth: .infinity, maxHeight: 1)
                                    .foregroundColor(Color.black.opacity(0.1))
                            }
                            
                            InputRow(label: "Property Management", placeholder: "$50", value: $marketValue, formatter: numberFormatter)
                                .padding(.top, 5)
                            InputRow(label: "Leasing Costs", placeholder: "$0", value: $purchasePriceValue, formatter: numberFormatter)
                            InputRow(label: "Maintenance", placeholder: "$100%", value: $downPaymentValue, formatter: numberFormatter)
                            InputRow(label: "Utilities", placeholder: "$500", value: $interestRateValue, formatter: decimalFormatter)
                            InputRow(label: "Property Taxes", placeholder: "$412", value: $mortgageLengthValue, formatter: numberFormatter)
                            InputRow(label: "Insurance", placeholder: "$121", value: $mortgageLengthValue, formatter: numberFormatter)
                            InputRow(label: "Other", placeholder: "$0", value: $mortgageLengthValue, formatter: numberFormatter)
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
                        // Header
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
                        
                        // Column Headers
                        HStack(alignment: .bottom) {
                            Text("Property Expenses")
                                .font(.system(size: 13))
                                .fontWeight(.bold)
                            //                                .frame(width: 150, alignment: .leading)
                            
                            Spacer()
                            
                            Text("Year")
                                .font(.system(size: 13))
                                .fontWeight(.bold)
                                .frame(width: 80, alignment: .center)
                            
                            Text("% of \nTotal Income")
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .frame(width: 80, alignment: .trailing)
                                .lineLimit(2)
                        }
                        .padding(.bottom, 10)
                        
                        // Data Rows
                        Group {
                            ForEach([("Property Management", "$600", "1.7%"),
                                     ("Leasing Costs", "$0", "0.0%"),
                                     ("Maintenance", "$1,200", "0.3%"),
                                     ("Utilities", "$6,000", "1.5%"),
                                     ("Property Taxes", "$1,200", "0.3%"),
                                     ("Insurance", "$1,200", "0.3%"),
                                     ("Other", "$1,200", "0.3%"),
                                     ("Total Expenses & Vacancy", "$15,996", "10.1%")], id: \.0) { item in
                                HStack {
                                    Text(item.0)
                                        .font(.system(size: 13))
                                    //                                        .frame(width: 150, alignment: .leading)
                                    
                                    Spacer()
                                    
                                    Text(item.1)
                                        .font(.system(size: 13))
                                        .frame(width: 80, alignment: .center)
                                    
                                    Text(item.2)
                                        .font(.system(size: 13))
                                        .frame(width: 80, alignment: .trailing)
                                }
                            }
                        }
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .foregroundColor(Color.black.opacity(0.1))
                        
                        VStack(spacing: 20) {
                            HStack {
                                Text("Expenses")
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                //                                    .frame(width: 150, alignment: .leading)
                                
                                Spacer()
                                
                                Text("Year")
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                    .frame(width: 80, alignment: .center)
                                
                                Text("Month")
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 80, alignment: .trailing)
                                    .lineLimit(2)
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Vacancy")
                                        .font(.system(size: 13))
                                    //                                        .frame(width: 150, alignment: .leading)
                                    
                                    Spacer()
                                    
                                    Text("$1,200")
                                        .font(.system(size: 13))
                                        .frame(width: 80, alignment: .center)
                                    
                                    Text("0.3%")
                                        .font(.system(size: 13))
                                        .frame(width: 80, alignment: .trailing)
                                }
                                
                                HStack {
                                    Text("Net Operating Income")
                                        .font(.system(size: 13))
                                    //                                        .frame(width: 150, alignment: .leading)
                                    
                                    Spacer()
                                    
                                    Text("$20,004")
                                        .font(.system(size: 13))
                                        .frame(width: 80, alignment: .center)
                                    
                                    Text("$1,667")
                                        .font(.system(size: 13))
                                        .frame(width: 80, alignment: .trailing)
                                }
                                
                                HStack(alignment: .top) {
                                    Text("Total Expenses & Vacancy")
                                        .font(.system(size: 13))
                                    //                                        .frame(width: 150, alignment: .leading)
                                        .lineLimit(2)
                                    
                                    Spacer()
                                    
                                    Text("$1,333")
                                        .font(.system(size: 13))
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

#Preview {
    OngoingExpenses()
}
