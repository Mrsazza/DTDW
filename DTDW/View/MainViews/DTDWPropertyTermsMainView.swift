//
//  PurchaseTerms.swift
//  DTDW
//
//  Created by Sopnil Sohan on 9/11/24.
//

import SwiftUI

struct DTDWPropertyTermsMainView: View {
    @Bindable var propertyData: PropertyDataModel
    @State private var selectedButton: ButtonType? = .cart
    
    enum ButtonType: CaseIterable {
        case cart, medical, rental, income, expenses
    }
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    //MARK: Top Header
                    PropertyTermsHeaderView(propertyData: propertyData)
                    
                    HStack {
                        ForEach(ButtonType.allCases, id: \.self) { buttonType in
                            Button {
                                selectedButton = buttonType
                            } label: {
                                Image(selectedButton == buttonType ? "\(buttonType)White" : "\(buttonType)Black")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 20)
                            }
                            .frame(width: 60, height: 40)
                            .background(selectedButton == buttonType ? Color.buttonBackgroundColor : Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.buttonBackgroundColor, lineWidth: 1)
                            )
                            .contentShape(Rectangle())
                            
                            if buttonType != .expenses {
                                Spacer()
                            }
                        }
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
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < 0 {
                                withAnimation {
                                    swipeToNext()
                                }
                            } else if value.translation.width > 0 {
                                withAnimation {
                                    swipeToPrevious()
                                }
                            }
                        }
                )
                
                PropertyTermsBottomTabView(propertyData: propertyData, viewModel: PropertyTermsViewModel(propertyData: propertyData))
            }
        }
    }
    
    private func swipeToNext() {
        guard let currentIndex = ButtonType.allCases.firstIndex(of: selectedButton ?? .cart) else { return }
        let nextIndex = (currentIndex + 1) % ButtonType.allCases.count
        selectedButton = ButtonType.allCases[nextIndex]
    }
    
    private func swipeToPrevious() {
        guard let currentIndex = ButtonType.allCases.firstIndex(of: selectedButton ?? .cart) else { return }
        let previousIndex = (currentIndex - 1 + ButtonType.allCases.count) % ButtonType.allCases.count
        selectedButton = ButtonType.allCases[previousIndex]
    }
}

// Add this helper function to dismiss the keyboard
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
