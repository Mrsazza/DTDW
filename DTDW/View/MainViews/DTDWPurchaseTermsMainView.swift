//
//  PurchaseTerms.swift
//  DTDW
//
//  Created by Sopnil Sohan on 9/11/24.
//

import SwiftUI
import SwiftData

struct DTDWPurchaseTermsMainView: View {
    @State private var selectedButton: ButtonType? = .cart
    @Bindable var propertyData: PropertyData
    
    enum ButtonType {
        case cart, medical, rental, income, expenses
    }
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    //MARK: Top Header
                    PurchaseTermsHederView(propertyData: propertyData)
                    
                    HStack {
                        Button {
                            selectedButton = .cart
                        } label: {
                            Image(selectedButton == .cart ? "cartWhite" : "cartBlack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 20)
                        }
                        .frame(width: 60, height: 40)
                        .background(selectedButton == .cart ? Color.buttonBackgroundColor : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.buttonBackgroundColor, lineWidth: 1)
                        )
//                        .onTapGesture {
//                            selectedButton = .cart
//                        }
                        .contentShape(Rectangle())
                        
                        Spacer()
                        
                        Button {
                            selectedButton = .medical
                        } label: {
                            Image(selectedButton == .medical ? "medicalWhite" : "medicalBlack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 20)
                            
                        }
                        .frame(width: 60, height: 40)
                        .background(selectedButton == .medical ? Color.buttonBackgroundColor : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.buttonBackgroundColor, lineWidth: 1)
                        )
                        .contentShape(Rectangle())
//                        .onTapGesture {
//                            selectedButton = .medical
//                        }
                        
                        Spacer()
                        
                        Button {
                            selectedButton = .rental
                        } label: {
                            Image(selectedButton == .rental ? "rentalWhite" : "rentalBlack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 20)
                        }
                        .frame(width: 60, height: 40)
                        .background(selectedButton == .rental ? Color.buttonBackgroundColor : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.buttonBackgroundColor, lineWidth: 1)
                        )
                        .contentShape(Rectangle())
                        
                        Spacer()
                        
                        Button {
                            selectedButton = .income
                        } label: {
                            Image(selectedButton == .income ? "incomeWhite" : "incomeBlack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 20)
                        }
                        .frame(width: 60, height: 40)
                        .background(selectedButton == .income ? Color.buttonBackgroundColor : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.buttonBackgroundColor, lineWidth: 1)
                        )
                        .contentShape(Rectangle())
                        
                        Spacer()
                        
                        Button {
                            selectedButton = .expenses
                        } label: {
                            Image(selectedButton == .expenses ? "expensesWhite" : "expensesBlack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 20)
                        }
                        .frame(width: 60, height: 40)
                        .background(selectedButton == .expenses ? Color.buttonBackgroundColor : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.buttonBackgroundColor, lineWidth: 1)
                        )
                        .contentShape(Rectangle())
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 20))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)), radius: 2, x: 0, y: 1)
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    switch selectedButton {
                    case .cart:
                        PurchaseTermsView(propertyData: propertyData)
                        
                        PurchaseTermsCalculatedDataView(viewModel: PurchaseTermsViewModel(propertyData: propertyData))
                    case .medical:
                        InitialExpensesDataView(propertyData: propertyData)
                        
                        InitialExpensesCalculatedDataView(viewModel: PurchaseTermsViewModel(propertyData: propertyData))
                    case .rental:
                        RentalAssumptionsUnitView(propertyData: propertyData)
                    case .income:
                        IncomeView(propertyData: propertyData, viewModel: PurchaseTermsViewModel(propertyData: propertyData))
                    case .expenses:
                        OngoingExpensesView(propertyData: propertyData, viewModel: PurchaseTermsViewModel(propertyData: propertyData))
                    case nil:
                        //inpute as a default
                        PurchaseTermsView(propertyData: propertyData)
                        
                        PurchaseTermsCalculatedDataView(viewModel: PurchaseTermsViewModel(propertyData: propertyData))
                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
                
                PurchaseTermsBottomTabView(propertyData: propertyData, viewModel: PurchaseTermsViewModel(propertyData: propertyData))
            }
        }
    }
}

// Add this helper function to dismiss the keyboard
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
