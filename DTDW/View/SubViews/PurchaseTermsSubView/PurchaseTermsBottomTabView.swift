//
//  PurchaseTermsBottomTabView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct PurchaseTermsBottomTabView: View {
    @Bindable var propertyData: PropertyData
    @StateObject var viewModel: PurchaseTermsViewModel
    
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            VStack(spacing: 20) {
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
                            .foregroundStyle(Color.black)
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
                            .foregroundStyle(Color.black)
                        Text("Monthly Cash flow")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                    }
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text(String(format: "$%.2f", viewModel.annualCashFlow))
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                        Text("Annual Cash Flow")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                    }
                }
            }
            .padding(.horizontal, 20)
            .tag(0)
            
            VStack(spacing: 20) {
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
                        Text("\(viewModel.capRate, specifier: "%.2f")%")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
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
                            .foregroundStyle(Color.black)
                        Text("Annual NOI")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("$\(viewModel.anualDebtService, specifier: "%.2f")")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                        Text("Annual Debt Service")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.purchaseBottomTabViewSecoundrayFontColor)
                    }
                }
            }
            .padding(.horizontal, 20)
            .tag(1)
        }
        .overlay(alignment: .bottom) {
            HStack(spacing: 8) {
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(currentPage == 0 ? Color.deepPurpelColor : Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 0.1)))
                Circle()
                    .frame(width: 5, height: 5)
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
