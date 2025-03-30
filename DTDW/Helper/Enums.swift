//
//  Enums.swift
//  DTDW
//
//  Created by Sazza on 13/3/25.
//

enum ButtonType: CaseIterable {
    case cart, medical, rental, income, expenses
    
    var imageName: String {
        switch self {
        case .cart: return "cart"
        case .medical: return "medical"
        case .rental: return "rental"
        case .income: return "income"
        case .expenses: return "expenses"
        }
    }
}

enum Tab {
    case home
    case plus
    case settings
}

enum innerButtonType {
    case costOfPurchase, costOfRepair
}
