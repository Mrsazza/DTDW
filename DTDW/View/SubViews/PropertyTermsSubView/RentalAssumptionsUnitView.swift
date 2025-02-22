//
//  RentalAssumptionsUnitView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 10/11/24.
//
import SwiftUI

struct RentalAssumptionsUnitView: View {
    @Bindable var propertyData: PropertyDataModel

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
                    ForEach(propertyData.propertyCalculatabeleData.units.indices, id: \.self) { index in
                        HStack {
                            Text("\(propertyData.propertyCalculatabeleData.units[index])")
                                .font(.system(size: 13))
                                .foregroundStyle(Color.black)

                            Spacer()

                            TextField("$0", text: Binding(
                                get: { propertyData.propertyCalculatabeleData.amounts[index] },
                                set: { newValue in
                                    propertyData.propertyCalculatabeleData.amounts[index] = newValue
                                }
                            ))
                            .font(.system(size: 13))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .keyboardType(.decimalPad)
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
                // Add Unit Button
                Button {
                    addUnit()
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
                        .stroke(Color.addUnitButtonStrokeColor, lineWidth: 1)
                    )
                    .shadow(color: Color.addUnitButtonShadowColor, radius: 15, x: 0, y: 4)
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
                    ForEach(propertyData.propertyCalculatabeleData.units.indices, id: \.self) { index in
                        let yearlyAmount = (Double(propertyData.propertyCalculatabeleData.amounts[index]) ?? 0) * 12
                        HStack {
                            Text("\(propertyData.propertyCalculatabeleData.units[index])")
                                .font(.system(size: 13))
                                .foregroundStyle(Color.black)
                                .fontWeight(.regular)

                            Spacer()

                            Text("$\(yearlyAmount, specifier: "%.0f")")
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
                        Text("$\(totalMonthly(), specifier: "%.0f")")
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
                        Text("$\(totalYearly(), specifier: "%.0f")")
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
        .onAppear {
            preloadDefaultData()
        }
    }

    private func preloadDefaultData() {
        if propertyData.propertyCalculatabeleData.units.isEmpty && propertyData.propertyCalculatabeleData.amounts.isEmpty {
            propertyData.propertyCalculatabeleData.units = [1, 2, 3, 4, 5, 6]
            propertyData.propertyCalculatabeleData.amounts = ["1200", "1200", "600", "0", "0", "0"]
        }
    }

    private func addUnit() {
        let newUnitNumber = propertyData.propertyCalculatabeleData.units.count + 1
        propertyData.propertyCalculatabeleData.units.append(newUnitNumber)
        propertyData.propertyCalculatabeleData.amounts.append("0")
    }

    private func totalMonthly() -> Double {
        propertyData.propertyCalculatabeleData.amounts.compactMap {
            Double($0) ?? 0
        }.reduce(0, +)
    }

    private func totalYearly() -> Double {
        totalMonthly() * 12
    }
}
