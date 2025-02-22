//
//  PurchaseTermsBottomTabView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PropertyTermsBottomTabView: View {
    @Bindable var propertyData: PropertyDataModel
    @StateObject var viewModel: PropertyTermsViewModel
    
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            VStack(spacing: 35) {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(String(format: "$%.2f", viewModel.pricePerUnit))
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                        Text("Price per Unit")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                    }
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text(String(format: "$%.2f", viewModel.cashOnCashReturn))
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(viewModel.cashOnCashReturn < 0 ? .red : .black)
                            .onChange(of: viewModel.cashOnCashReturn) { oldValue, newValue in
                                propertyData.cashOnCashReturn = newValue
                            }
                            .onChange(of: viewModel.capRateFinal) { oldValue, newValue in
                                propertyData.capRate = newValue
                            }
                        Text("Cash on Cash Return")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(String(format: "$%.2f", viewModel.monthlyCashFlow))
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(viewModel.monthlyCashFlow < 0 ? .red : .black)
                        Text("Monthly Cash flow")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                    }
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text(String(format: "$%.2f", viewModel.annualCashFlow))
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(viewModel.annualCashFlow < 0 ? .red : .black)
                        Text("Annual Cash Flow")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                    }
                }
            }
            .padding(.horizontal, 20)
            .tag(0)
            
            VStack(spacing: 35) {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(String(format: "%.2f", viewModel.dSCR))
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                        Text("DSCR")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                        
                    }
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("\(viewModel.capRateFinal, specifier: "%.2f")%")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(viewModel.capRateFinal < 0 ? .red : .black)
                            .onChange(of: viewModel.capRateFinal) { oldValue, newValue in
                                propertyData.capRate = newValue
                            }
                            .onChange(of: viewModel.cashOnCashReturn) { oldValue, newValue in
                                propertyData.cashOnCashReturn = newValue
                            }
                        Text("Cap Rate")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("$\(viewModel.anualNOI, specifier: "%.2f")")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(viewModel.anualNOI < 0 ? .red : .black)
                        Text("Annual NOI")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("$\(viewModel.anualDebtService, specifier: "%.2f")")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(viewModel.anualDebtService < 0 ? .red : .black)
                        Text("Annual Debt Service")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                    }
                }
            }
            .padding(.horizontal, 20)
            .tag(1)
        }
        .overlay(alignment: .center) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(currentPage == 1 ? Color.deepPurpelColor : Color.clear)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .padding()
                    .background(currentPage == 1 ? Color.purchaseHeaderButtonFillColor : Color.clear)
                    .frame(width: 24, height: 24)
                    .cornerRadius(50)
                    .shadow(color: Color.purchaseHeaderButtonShadowColor, radius: 4, x: 2, y: 2)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(currentPage == 0 ? Color.deepPurpelColor : Color.clear)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .padding()
                    .background(currentPage == 0 ? Color.purchaseHeaderButtonFillColor : Color.clear)
                    .frame(width: 24, height: 24)
                    .cornerRadius(50)
                    .shadow(color: Color.purchaseHeaderButtonShadowColor, radius: 4, x: 2, y: 2)
            }
            .padding(.horizontal, 10)
        }
        .overlay(alignment: .bottom) {
            HStack(spacing: 8) {
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(currentPage == 0 ? Color.deepPurpelColor : Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 0.1)))
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(currentPage == 1 ? Color.deepPurpelColor : Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 0.1)))
            }
            .padding(.bottom, 5)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: .infinity, maxHeight: 160)
        .background(Color.mimiPinkColor)
        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)), radius: 10, x: 0, y: -2)
    }
}
