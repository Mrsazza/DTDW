//
//  RentalAssumptionsUnitView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 10/11/24.
//

import SwiftUI

struct RentalAssumptionsUnitView: View {
    @State private var units: [Int] = Array(1...5)
    @State private var amounts: [String] = Array(repeating: "$0", count: 5)
    
    private var monthlyTotals: [Double] {
        amounts.map { Double($0.replacingOccurrences(of: "$", with: "")) ?? 0 }
    }
    
    private var yearlyTotals: [Double] {
        monthlyTotals.map { $0 * 12 }
    }
    
    private var totalMonthly: Double {
        monthlyTotals.reduce(0, +)
    }
    
    private var totalYearly: Double {
        yearlyTotals.reduce(0, +)
    }

    var body: some View {
        VStack {
            // Rental Assumptions Section
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    Text("Rental Assumptions")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color.deepPurpelColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(Color.black.opacity(0.1))
                    
                    HStack {
                        Text("Unit")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                        Spacer()
                        
                        Text("Month")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                            .padding(.trailing, 20)
                    }
                }
                
                VStack(spacing: 10) {
                    ForEach(units.indices, id: \.self) { index in
                        HStack {
                            Text("\(units[index])")
                                .font(.system(size: 13))
                                .foregroundStyle(Color.black)
                            Spacer()
                            
                            TextField("$0", text: $amounts[index])
                                .font(.system(size: 13))
                                .fontWeight(.medium)
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
                    }
                }
                
                // Add Unit button
                Button {
                    // Add a new unit and corresponding amount
                    units.append(units.count + 1)
                    amounts.append("$0") // Default value for new unit's amount
                } label: {
                    HStack(spacing: 10) {
                        Text("Add Unit")
                        Image(systemName: "plus.circle.fill")
                    }
                    .padding(10)
                    .frame(width: 114, height: 32)
                    .background(Color.addUnitButtonBackgroundColor)
                    .cornerRadius(35)
                    .overlay(RoundedRectangle(cornerRadius: 35)
                        .stroke(Color.addUnitButtonStrokeColor,lineWidth: 1)
                    )
                    .shadow(color: Color.addUnitButtonShadowColor ,radius: 15,x: 0,y: 4)
                    .foregroundColor(Color.champagneColor)
                    .font(.system(size: 13.22, weight: .medium))
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
            .padding(.horizontal, 20)
            
            // Calculated Data Section
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    Text("Calculated Data")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color.deepPurpelColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(Color.black.opacity(0.1))
                    
                    HStack {
                        Text("Unit")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                        Spacer()
                        Text("Year")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                    }
                }
                
                VStack(spacing: 10) {
                    // Display Calculated Monthly and Yearly Data for each Unit
                    ForEach(units.indices, id: \.self) { index in
                        HStack {
                            Text("\(units[index])")
                                .font(.system(size: 13))
                                .foregroundStyle(Color.black)
                                .fontWeight(.regular)
                            
                            Spacer()
                            
                            Text("$\(yearlyTotals[index], specifier: "%.2f")")
                                .font(.system(size: 13))
                                .foregroundStyle(Color.black)
                                .fontWeight(.regular)
                                .frame(width: 80, alignment: .trailing)
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(Color.black.opacity(0.1))
                }
                
                // Total Section
                HStack(spacing: 10) {
                    Text("Total")
                        .font(.system(size: 13))
                        .fontWeight(.regular)
                        .foregroundStyle(Color.black)
                        .frame(maxHeight: 40, alignment: .bottom)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("Month")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                        Text("$\(totalMonthly, specifier: "%.2f")")
                            .font(.system(size: 13))
                            .foregroundStyle(Color.black)
                            .fontWeight(.regular)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                    .frame(width: 80, alignment: .trailing)
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("Year")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                        Text("$\(totalYearly, specifier: "%.2f")")
                            .font(.system(size: 13))
                            .foregroundStyle(Color.black)
                            .fontWeight(.regular)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                    .frame(width: 80, alignment: .trailing)
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
            .padding(.horizontal, 20)
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
}

#Preview {
    RentalAssumptionsUnitView()
}
