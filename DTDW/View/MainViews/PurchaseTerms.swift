//
//  PurchaseTerms.swift
//  DTDW
//
//  Created by Sopnil Sohan on 9/11/24.
//

import SwiftUI

struct PurchaseTerms: View {
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
                    PurchaseTermsHederView()
                    
                    HStack {
                        Button {
                            selectedButton = .cart
                        } label: {
                            Image(selectedButton == .cart ? "cartWhite" : "cartBlack")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                        }
                        .frame(width: 60, height: 40)
                        .background(selectedButton == .cart ? Color.buttonBackgroundColor : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.buttonBackgroundColor, lineWidth: 1)
                        )
                        
                        Spacer()
                        
                        Button {
                            selectedButton = .medical
                        } label: {
                            Image(selectedButton == .medical ? "medicalWhite" : "medicalBlack")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                            
                        }
                        .frame(width: 60, height: 40)
                        .background(selectedButton == .medical ? Color.buttonBackgroundColor : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.buttonBackgroundColor, lineWidth: 1)
                        )
                        
                        Spacer()
                        
                        Button {
                            selectedButton = .rental
                        } label: {
                            Image(selectedButton == .rental ? "rentalWhite" : "rentalBlack")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                        }
                        .frame(width: 60, height: 40)
                        .background(selectedButton == .rental ? Color.buttonBackgroundColor : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.buttonBackgroundColor, lineWidth: 1)
                        )
                        
                        Spacer()
                        
                        Button {
                            selectedButton = .income
                        } label: {
                            Image(selectedButton == .income ? "incomeWhite" : "incomeBlack")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                        }
                        .frame(width: 60, height: 40)
                        .background(selectedButton == .income ? Color.buttonBackgroundColor : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.buttonBackgroundColor, lineWidth: 1)
                        )
                        
                        Spacer()
                        
                        Button {
                            selectedButton = .expenses
                        } label: {
                            Image(selectedButton == .expenses ? "expensesWhite" : "expensesBlack")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                        }
                        .frame(width: 60, height: 40)
                        .background(selectedButton == .expenses ? Color.buttonBackgroundColor : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.buttonBackgroundColor, lineWidth: 1)
                        )
                        
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 20))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)), radius: 2, x: 0, y: 1)
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    if selectedButton == .cart {
                        PurchaseTermsView() 
                        
                        CalculatedDataView()
                    } else if selectedButton == .medical {
                        InitialExpensesCOPData()
                            
                        
                        InitialExpemsesCOPCalculatedDataView()
                           
                    } else if selectedButton == .rental {
                        
                        RentalAssumptionsUnitView()
                        
                    } else if selectedButton == .income {
                        
                        IncomeView()
                        
                    } else if selectedButton == .expenses {
                        
                        OngoingExpenses()
                        
                    } else {
                        //inpute as a default
                        PurchaseTermsView()
                        
                        CalculatedDataView()
                    }
                }
                
                PurchaseTermsBottomTabView()
            }
        }
    }
}

#Preview {
    PurchaseTerms()
}
