//
//  OngoingExpensesViewModel.swift
//  DTDW
//
//  Created by Sopnil Sohan on 25/11/24.
//

import SwiftUI
import Combine

class OngoingExpensesManager: ObservableObject {
    @Published var vacancyOfTotalIncome: Double = 5.0
    @Published var propertyManagement: Double = 50
    @Published var leasingCosts: Double = 0
    @Published var maintenance: Double = 100
    @Published var utilities: Double = 500.0
    @Published var propertyTaxes: Double = 412
    @Published var insurance: Double = 121
    @Published var otherOngoingExpenses: Double = 0
    
    @Published var cashOnCashReturn: Double = 83333.33
    
    var purchaseTermsManager: PurchaseTermsManager
    
    init(purchaseTermsManager: PurchaseTermsManager = PurchaseTermsManager()) {
        self.purchaseTermsManager = purchaseTermsManager
    }
    
    // **1. Computed Properties for Total Ongoing Income**
    var totalOngoingIncome: Double {
        Double(purchaseTermsManager.totalIncome) + purchaseTermsManager.totalMonthly * 12
    }
    
    var totalOngoingIncomeMonthly: Double {
        Double(purchaseTermsManager.totalIncome) + purchaseTermsManager.totalMonthly
    }

    // **2. Dynamic Calculations for Yearly and Monthly Amounts**
    private func yearlyAmount(for monthlyValue: Double) -> Double {
        monthlyValue * 12
    }
    
    private func percentage(for amount: Double, base: Double) -> String {
        guard base > 0 else { return "0.0%" }
        return String(format: "%.1f%%", (amount / base) * 100)
    }

    // Yearly Amounts
    var vacancyYearAmount: Double {
        (vacancyOfTotalIncome / 100) * totalOngoingIncome
    }
    
    var propertyManagementYearAmount: Double {
        yearlyAmount(for: Double(propertyManagement))
    }
    
    var leasingCostsYearAmount: Double {
        yearlyAmount(for: Double(leasingCosts))
    }
    
    var maintenanceYearAmount: Double {
        yearlyAmount(for: Double(maintenance))
    }
    
    var utilitiesYearAmount: Double {
        yearlyAmount(for: utilities)
    }
    
    var propertyTaxesYearAmount: Double {
        yearlyAmount(for: Double(propertyTaxes))
    }
    
    var insuranceYearAmount: Double {
        yearlyAmount(for: Double(insurance))
    }
    
    var otherYearAmount: Double {
        yearlyAmount(for: Double(otherOngoingExpenses))
    }
    
    // Total Expenses
    var totalExpenses: Double {
        vacancyYearAmount + propertyManagementYearAmount + leasingCostsYearAmount +
        maintenanceYearAmount + utilitiesYearAmount + propertyTaxesYearAmount +
        insuranceYearAmount + otherYearAmount
    }
    
    // **3. Other Key Metrics**
    var vacancyMonthAmount: Double {
        vacancyYearAmount / 12
    }
    
    var netOperatingIncomeYearAmount: Double {
        totalOngoingIncome - totalExpenses
    }
    
    var netOperatingIncomeMonthAmount: Double {
        netOperatingIncomeYearAmount / 12
    }
    
    var totalExpensesAndVacancyYearAmount: Double {
        totalExpenses
    }
    
    var totalExpensesAndVacancyMonthAmount: Double {
        totalExpensesAndVacancyYearAmount / 12
    }
    
    var netOperatingIncomeNOI: Double {
        (Double(purchaseTermsManager.totalIncome) + purchaseTermsManager.totalMonthly) - totalExpensesAndVacancyYearAmount
    }
    
    var monthlyCashFlow: Double {
        netOperatingIncomeNOI - (purchaseTermsManager.monthlyMortgagePayment)
    }
}
