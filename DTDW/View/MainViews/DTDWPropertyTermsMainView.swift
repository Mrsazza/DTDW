//
//  PurchaseTerms.swift
//  DTDW
//
//  Created by Sopnil Sohan on 9/11/24.
//

import SwiftUI
import SwiftData

struct DTDWPropertyTermsMainView: View {
    @Bindable var propertyData: PropertyDataModel
    @State private var selectedButton: ButtonType? = .cart
   
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
                    PropertyTermsHederView(propertyData: propertyData)
                    
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
                        PropertyTermsView(propertyData: propertyData)
                        
                        PropertyTermsCalculatedDataView(viewModel: PropertyTermsViewModel(propertyData: propertyData))
                    case .medical:
                        PropertyInitialExpensesDataView(propertyData: propertyData)
                        
                        PropertyInitialExpensesCalculatedDataView(viewModel: PropertyTermsViewModel(propertyData: propertyData))
                    case .rental:
                        RentalAssumptionsUnitView(propertyData: propertyData)
                    case .income:
                        PropertyIncomeView(propertyData: propertyData, viewModel: PropertyTermsViewModel(propertyData: propertyData))
                    case .expenses:
                        PropertyOngoingExpensesView(propertyData: propertyData, viewModel: PropertyTermsViewModel(propertyData: propertyData))
                    case nil:
                        //inpute as a default
                        PropertyTermsView(propertyData: propertyData)
                        
                        PropertyTermsCalculatedDataView(viewModel: PropertyTermsViewModel(propertyData: propertyData))
                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
                
                PropertyTermsBottomTabView(propertyData: propertyData, viewModel: PropertyTermsViewModel(propertyData: propertyData))
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
