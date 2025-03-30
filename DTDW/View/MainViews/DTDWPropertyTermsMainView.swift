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
    
    private let buttonImageSize: CGSize = CGSize(width: 60, height: 20)
    private let buttonFrameSize: CGSize = CGSize(width: 60, height: 40)
    private let cornerRadius: CGFloat = 10
    private let shadowRadius: CGFloat = 2
    private let shadowColor = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1))
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    // MARK: Top Header
                    PropertyTermsHeaderView(propertyData: propertyData)
                    
                    PropertyTermsButtonRowView(buttonTypes: ButtonType.allCases, selectedButton: $selectedButton)
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
                    case .none:
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

struct PropertyTermsButtonRowView: View {
    let buttonTypes: [ButtonType]
    @Binding var selectedButton: ButtonType?
    
    var buttonImageSize: CGSize = CGSize(width: 60, height: 20)
    var buttonFrameSize: CGSize = CGSize(width: 60, height: 40)
    var cornerRadius: CGFloat = 10
    var strokeColor: Color = Color.buttonBackgroundColor
    var backgroundColor: Color = Color.white
    var shadowColor: Color = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1))
    var shadowRadius: CGFloat = 2
    
    var body: some View {
        HStack {
            ForEach(0..<buttonTypes.count, id: \.self) { index in
                let buttonType = buttonTypes[index]
                Button {
                    selectedButton = buttonType
                } label: {
                    Image(selectedButton == buttonType ? "\(buttonType.imageName)White" : "\(buttonType.imageName)Black")
                        .resizable()
                        .scaledToFit()
                        .frame(width: buttonImageSize.width, height: buttonImageSize.height)
                }
                .frame(width: buttonFrameSize.width, height: buttonFrameSize.height)
                .background(selectedButton == buttonType ? Color.buttonBackgroundColor : backgroundColor)
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(strokeColor, lineWidth: 1)
                )
                .contentShape(Rectangle())
                
                if index < buttonTypes.count - 1 {
                    Spacer()
                }
            }
        }
        .padding()
        .background(backgroundColor)
        .clipShape(RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 20))
        .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: 1)
    }
}
