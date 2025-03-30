//
//  InitialExpensesCOPData.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PropertyInitialExpensesDataView: View {
    @Bindable var propertyData: PropertyDataModel
    @State private var selectedButton: innerButtonType = .costOfPurchase

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
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text("Initial Expenses")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.colorFont)

                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .foregroundStyle(Color.grayDividerColor)
            }
            .padding(.top, 20)

            VStack(spacing: selectedButton == .costOfRepair ? 5 : 15) {
                // Button Group
                HStack(spacing: 10) {
                    Button(action: {
                        selectedButton = .costOfPurchase
                    }) {
                        Text("Cost of Purchase")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.black)
                            .frame(maxWidth: .infinity, maxHeight: 37)
                            .padding(10)
                            .background(selectedButton == .costOfPurchase ? Color.mimiPinkColor : Color.white)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.deepPurpelColor, lineWidth: 1)
                            )
                            .shadow(color: Color.blackOnePercentColor, radius: 4, x: 0, y: 1)
                    }

                    Button(action: {
                        selectedButton = .costOfRepair
                    }) {
                        Text("Cost of Repair")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.black)
                            .frame(maxWidth: .infinity, maxHeight: 37)
                            .padding(10)
                            .background(selectedButton == .costOfRepair ? Color.mimiPinkColor : Color.white)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.deepPurpelColor, lineWidth: 1)
                            )
                            .shadow(color: Color.blackOnePercentColor, radius: 4, x: 0, y: 1)
                    }
                }
                VStack(spacing: selectedButton == .costOfPurchase ? 15 : 0) {
                    if selectedButton == .costOfPurchase {
                        Text("Startup Expenses")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.black)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: .infinity, maxHeight: 2)
                            .foregroundStyle(Color.grayDividerColor)
                    }
                }

                VStack(spacing: 10) {
                    if selectedButton == .costOfPurchase {
                        // Cost of Purchase Inputs(COP)
                        InputRow(label: "Finder’s Fee", value: $propertyData.propertyCalculatabeleData.findersFees)
                        InputRow(label: "Inspection", value: $propertyData.propertyCalculatabeleData.inspection)
                        InputRow(label: "Title Search Fee", value: $propertyData.propertyCalculatabeleData.titleSearchFee)
                        InputRow(label: "Title Insurance", value: $propertyData.propertyCalculatabeleData.titleInsurance)
                        InputRow(label: "Appraisal", value: $propertyData.propertyCalculatabeleData.appraisal)
                        InputRow(label: "Deed Recording Fee", value: $propertyData.propertyCalculatabeleData.deedRecordingFee)
                        InputRow(label: "Loan Origination Fee", value: $propertyData.propertyCalculatabeleData.loanOriginationFee)
                        InputRow(label: "Survey", value: $propertyData.propertyCalculatabeleData.survey)
                        InputRow(label: "Other", value: $propertyData.propertyCalculatabeleData.copOther)
                            .padding(.bottom, 15)
                    } else if selectedButton == .costOfRepair {
                        // Cost of Repair Inputs(COR)
                        InputRow(label: "Cosmetic Minor", value: $propertyData.propertyCalculatabeleData.cosmeticMinor)
                            .padding(.top, selectedButton == .costOfRepair ? 10 : 0)
                        InputRow(label: "Cosmetic Major", value: $propertyData.propertyCalculatabeleData.cosmeticMajor)
                        InputRow(label: "Structural", value: $propertyData.propertyCalculatabeleData.structural)
                        InputRow(label: "Fixtures/Appliances", value: $propertyData.propertyCalculatabeleData.fixtures)
                        InputRow(label: "Landscaping", value: $propertyData.propertyCalculatabeleData.landscaping)
                        InputRow(label: "Other", value: $propertyData.propertyCalculatabeleData.corOther)
                        InputRow(label: "Contingency Factor (%)", value: $propertyData.propertyCalculatabeleData.contingencyFactor)
                            .padding(.bottom, 15)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}
