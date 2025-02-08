//
//  PurchaseTermsViewModel.swift
//  DTDW
//
//  Created by Sopnil Sohan on 6/1/25.
//

import Foundation
import Combine
import SwiftUI
import SwiftData

class PropertyTermsViewModel: ObservableObject {
    @Bindable var propertyData: PropertyDataModel
    
    // Custom initializer
    init(propertyData: PropertyDataModel) {
        self.propertyData = propertyData
    }
    
    // MARK: - PurchaseTerms...
    func discountProfit() -> Double {
        let marketValue = Double(propertyData.propertyCalculatabeleData.marketValue)
        let purchasePrice = Double(propertyData.propertyCalculatabeleData.purchasePriceValue)
        return max(0, marketValue - purchasePrice)
    }
    
    func discountProfitPercentage() -> Double {
        let marketValue = Double(propertyData.propertyCalculatabeleData.marketValue)
        return discountProfit() / marketValue * 100
    }
    
    func downPaymentAmount() -> Double {
        let purchasePrice = Double(propertyData.propertyCalculatabeleData.purchasePriceValue)
        let downPayment = Double(propertyData.propertyCalculatabeleData.downPaymentValue) / 100
        return purchasePrice * downPayment
    }
    
    func amountFinanced() -> Double {
        let purchasePrice = Double(propertyData.propertyCalculatabeleData.purchasePriceValue)
        return purchasePrice - downPaymentAmount()
    }
    
    func financedPercentage() -> Double {
        return 100.0 - Double((propertyData.propertyCalculatabeleData.downPaymentValue))
    }
    
    func monthlyMortgagePayment() -> Double {
        let interestRate = Double(propertyData.propertyCalculatabeleData.interestRateValue) / 100 / 12
        let loanTermMonths = Double((propertyData.propertyCalculatabeleData.mortgageLengthValue) * 12)
        let principal = amountFinanced()
        
        guard interestRate > 0 else { return principal / loanTermMonths }
        return principal * (interestRate * pow(1 + interestRate, loanTermMonths)) / (pow(1 + interestRate, loanTermMonths) - 1)
    }
    
    //MARK: - Initial Expenses...
    
    //Calculated Outputs(COP)
    var totalCostOfPurchase: Int {
        let fees = propertyData.propertyCalculatabeleData.findersFees ?? 0
        let inspectionCost = propertyData.propertyCalculatabeleData.inspection ?? 0
        let searchFee = propertyData.propertyCalculatabeleData.titleSearchFee ?? 0
        let insuranceCost = Int(propertyData.propertyCalculatabeleData.titleInsurance ?? 0) // Convert Double to Int
        let appraisalCost = propertyData.propertyCalculatabeleData.appraisal ?? 0
        let recordingFee = propertyData.propertyCalculatabeleData.deedRecordingFee ?? 0
        let originationFee = propertyData.propertyCalculatabeleData.loanOriginationFee ?? 0
        let surveyCost = propertyData.propertyCalculatabeleData.survey ?? 0
        let otherCost = propertyData.propertyCalculatabeleData.copOther ?? 0
        
        return fees + inspectionCost + searchFee + insuranceCost + appraisalCost + recordingFee + originationFee + surveyCost + otherCost
    }
    
    // Calculated Outputs(COR)
    var totalCostOfRepair: Int {
        let minor = propertyData.propertyCalculatabeleData.cosmeticMinor ?? 0
        let major = propertyData.propertyCalculatabeleData.cosmeticMajor ?? 0
        let structural = propertyData.propertyCalculatabeleData.structural ?? 0
        let fixtures = propertyData.propertyCalculatabeleData.fixtures ?? 0
        let landscap = propertyData.propertyCalculatabeleData.landscaping ?? 0
        
        return minor + major + structural + fixtures + landscap
    }
    
    var contingencyAmount: Int {
        Int(Double(totalCostOfRepair) * (propertyData.propertyCalculatabeleData.contingencyFactor ?? 0 / 100))
    }
    
    var totalInitialExpenses: Int {
        totalCostOfPurchase + totalCostOfRepair
    }
    
    var includingMoneyDown: Int {
        totalCostOfPurchase + totalCostOfRepair + Int(initialExpanceDownPaymentAmount)
    }
    
    var initialExpanceDownPaymentAmount: Double {
        let purchasePriceValue = Double(propertyData.propertyCalculatabeleData.purchasePriceValue)
        let downPaymentValue = Double(propertyData.propertyCalculatabeleData.downPaymentValue)
        return purchasePriceValue * ( downPaymentValue / 100)
    }
    
    //MARK: - Rental Assumptions...
    func totalMonthly() -> Double {
        let total = propertyData.propertyCalculatabeleData.amounts.compactMap {
            Double($0) ?? 0
        }.reduce(0, +)
        
        return total
    }
    
    func totalYearly() -> Double {
        totalMonthly() * 12
    }
    
    //MARK: - Income...
    
    func totalMonthlyRentalIncome() -> Double {
        propertyData.propertyCalculatabeleData.amounts.compactMap { Double($0) ?? 0 }.reduce(0, +)
    }
    
    func totalMonthlyIncome() -> Double {
        let otherIncome = [
            propertyData.propertyCalculatabeleData.administrativeFees,
            propertyData.propertyCalculatabeleData.applianceRentals,
            propertyData.propertyCalculatabeleData.furnitureRental,
            propertyData.propertyCalculatabeleData.parking,
            propertyData.propertyCalculatabeleData.laundryIncome,
            propertyData.propertyCalculatabeleData.otherIncome
        ].compactMap { $0 }.reduce(0, +)
        
        return Double(totalMonthlyRentalIncome()) + otherIncome
    }
    
    func monthlyAdministrativeFees() -> Double {
        return propertyData.propertyCalculatabeleData.administrativeFees ?? 0
    }
    
    func yearlyAdministrativeFees() -> Double {
        return monthlyAdministrativeFees() * 12
    }
    
    func monthlyApplianceRentals() -> Double {
        return propertyData.propertyCalculatabeleData.applianceRentals ?? 0
    }
    
    func yearlyApplianceRentals() -> Double {
        return monthlyApplianceRentals() * 12
    }
    
    func monthlyFurnitureRental() -> Double {
        return propertyData.propertyCalculatabeleData.furnitureRental ?? 0
    }
    
    func yearlyFurnitureRental() -> Double {
        return monthlyFurnitureRental() * 12
    }
    
    func monthlyParkingIncome() -> Double {
        return propertyData.propertyCalculatabeleData.parking ?? 0
    }
    
    func yearlyParkingIncome() -> Double {
        return monthlyParkingIncome() * 12
    }
    
    func monthlyLaundryIncome() -> Double {
        return propertyData.propertyCalculatabeleData.laundryIncome ?? 0
    }
    
    func yearlyLaundryIncome() -> Double {
        return monthlyLaundryIncome() * 12
    }
    
    func monthlyOtherIncome() -> Double {
        return propertyData.propertyCalculatabeleData.otherIncome ?? 0
    }
    
    func yearlyOtherIncome() -> Double {
        return monthlyOtherIncome() * 12
    }
    
    func monthlyTotalIncome() -> Double {
        return totalMonthlyIncome()
    }
    
    func yearlyTotalIncome() -> Double {
        return monthlyTotalIncome() * 12
    }
    
    //MARK: - OngoingExpensess...
    
    var totalOngoingIncome: Double {
        totalMonthlyIncome()  * 12
    }
    
    var totalOngoingIncomeMonthly: Double {
        totalMonthlyIncome() + totalMonthly()
    }
    
    private func yearlyAmount(for monthlyValue: Double) -> Double {
        monthlyValue * 12
    }
    
    private func monthlyAmount(for monthlyValue: Double) -> Double {
        monthlyValue
    }
    
    private func percentage(for amount: Double, base: Double) -> String {
        guard base > 0 else { return "0.0%" }
        return String(format: "%.1f%%", (amount / base) * 100)
    }
    
    var vacancyYearAmount: Double {
        (propertyData.propertyCalculatabeleData.vacancyOfTotalIncome / 100) * (totalMonthlyIncome() * 12)
    }
    
    var propertyManagementYearAmount: Double {
        yearlyAmount(for: Double(propertyData.propertyCalculatabeleData.propertyManagement))
    }
    
    var propertyManagementMonthlyAmount: Double {
        monthlyAmount(for: Double(propertyData.propertyCalculatabeleData.propertyManagement))
    }
    
    var leasingCostsYearAmount: Double {
        yearlyAmount(for: Double(propertyData.propertyCalculatabeleData.leasingCosts))
    }
    
    var leasingCostsMonthlyAmount: Double {
        monthlyAmount(for: Double(propertyData.propertyCalculatabeleData.leasingCosts))
    }
    
    var maintenanceYearAmount: Double {
        yearlyAmount(for: Double(propertyData.propertyCalculatabeleData.maintenance))
    }
    
    var maintenanceMonthlyAmount: Double {
        monthlyAmount(for: Double(propertyData.propertyCalculatabeleData.maintenance))
    }
    
    var utilitiesYearAmount: Double {
        yearlyAmount(for: propertyData.propertyCalculatabeleData.utilities)
    }
    
    var utilitiesMonthlyAmount: Double {
        monthlyAmount(for: Double(propertyData.propertyCalculatabeleData.utilities))
    }
    
    var propertyTaxesYearAmount: Double {
        yearlyAmount(for: Double(propertyData.propertyCalculatabeleData.propertyTaxes))
    }
    
    var propertyTaxesMonthlyAmount: Double {
        monthlyAmount(for: Double(propertyData.propertyCalculatabeleData.propertyTaxes))
    }
    
    var insuranceYearAmount: Double {
        yearlyAmount(for: Double(propertyData.propertyCalculatabeleData.insurance))
    }
    
    var insuranceMonthlyAmount: Double {
        monthlyAmount(for: Double(propertyData.propertyCalculatabeleData.insurance))
    }
    
    var otherYearAmount: Double {
        yearlyAmount(for: Double(propertyData.propertyCalculatabeleData.otherOngoingExpenses))
    }
    
    var otherMonthlyAmount: Double {
        monthlyAmount(for: Double(propertyData.propertyCalculatabeleData.otherOngoingExpenses))
    }
    
    // Total Expenses
    var totalExpenses: Double {
        let expenses =
        
        propertyManagementYearAmount +
        leasingCostsYearAmount +
        maintenanceYearAmount +
        utilitiesYearAmount +
        propertyTaxesYearAmount +
        insuranceYearAmount +
        otherYearAmount + vacancyYearAmount
        
        return expenses
    }
    
    var totalExpensesMonthly: Double {
        let monthlyExpenses =
        
        propertyManagementMonthlyAmount + leasingCostsMonthlyAmount + maintenanceMonthlyAmount + utilitiesMonthlyAmount + propertyTaxesMonthlyAmount + insuranceMonthlyAmount + otherMonthlyAmount + vacancyMonthAmount
        
        return monthlyExpenses
    }
    
    var vacancyAmount: Double {
        return (propertyData.propertyCalculatabeleData.vacancyOfTotalIncome / 100) * yearlyRentalIncome
    }
    
    var yearlyRentalIncome: Double {
        let totalMonthlyIncome = propertyData.propertyCalculatabeleData.amounts
            .compactMap { Double($0) } // Convert each string to Double
            .reduce(0, +) // Now reduce it to a total sum
        return totalMonthlyIncome * 12
    }
    
    // **3. Other Key Metrics**
    var vacancyMonthAmount: Double {
        vacancyYearAmount / 12
    }
    
    var capVacancyYearAmount: Double {
        vacancyYearAmount
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
        (totalMonthlyIncome() + totalMonthly()) - totalExpensesAndVacancyYearAmount
    }
    
    var propertyManagementPercentage: String {
        guard totalMonthlyIncome() > 0 else { return "0.0%" }
        
        // Debugging prints to check values
//        print("totalOngoingIncomeMonthly: \(totalOngoingIncomeMonthly)")
//        print("propertyManagement: \(propertyData.propertyCalculatabeleData.propertyManagement)")
        
        let percentage = (Double(propertyManagementMonthlyAmount) / totalMonthlyIncome()) * 100
        return String(format: "%.1f", percentage) + "%"
    }
    
    
    var leasingCostsPercentage: String {
        guard totalMonthlyIncome() > 0 else { return "0.0%" }
        let percentage = (Double(propertyData.propertyCalculatabeleData.leasingCosts) / totalMonthlyIncome()) * 100
        return String(format: "%.1f", percentage) + "%"
    }
    
    var maintenancePercentage: String {
        let percentage = (maintenanceYearAmount / propertyData.propertyCalculatabeleData.marketValue) * 100
        return String(format: "%.1f", percentage) + "%"
    }
    
    var utilitiesPercentage: String {
        let percentage = (utilitiesYearAmount / propertyData.propertyCalculatabeleData.marketValue) * 100
        return String(format: "%.1f", percentage) + "%"
    }
    
    var propertyTaxesPercentage: String {
        let percentage = (propertyTaxesYearAmount / propertyData.propertyCalculatabeleData.marketValue) * 100
        return String(format: "%.1f", percentage) + "%"
    }
    
    var insurancePercentage: String {
        let percentage = (insuranceYearAmount / propertyData.propertyCalculatabeleData.marketValue) * 100
        return String(format: "%.1f", percentage) + "%"
    }
    
    var otherPercentage: String {
        let percentage = (otherYearAmount / propertyData.propertyCalculatabeleData.marketValue) * 100
        return String(format: "%.1f", percentage) + "%"
    }
    
    var combinedExpensePercentages: String {
        guard totalMonthlyIncome() > 0 else { return "0.0%" }
        
        // Calculate individual percentages
        let vacancyPercentage = propertyData.propertyCalculatabeleData.vacancyOfTotalIncome
        let propertyManagementPercentage = (Double(propertyManagementMonthlyAmount) / totalMonthlyIncome()) * 100
        let leasingCostsPercentage = (Double(propertyData.propertyCalculatabeleData.leasingCosts) / totalMonthlyIncome()) * 100
        
        let maintenancePercentage = (maintenanceYearAmount / propertyData.propertyCalculatabeleData.marketValue) * 100
        let utilitiesPercentage = (utilitiesYearAmount / propertyData.propertyCalculatabeleData.marketValue) * 100
        let propertyTaxesPercentage = (propertyTaxesYearAmount / propertyData.propertyCalculatabeleData.marketValue) * 100
        let insurancePercentage = (insuranceYearAmount / propertyData.propertyCalculatabeleData.marketValue) * 100
        let otherPercentage = (otherYearAmount / propertyData.propertyCalculatabeleData.marketValue) * 100
        
        let totalPercentage = vacancyPercentage + propertyManagementPercentage + leasingCostsPercentage + maintenancePercentage + utilitiesPercentage + propertyTaxesPercentage + insurancePercentage + otherPercentage
        
        return String(format: "%.1f", totalPercentage) + "%"
    }
    
    //MARK: - Bottom Tab View
    
    var pricePerUnit: Double {
        guard propertyData.propertyCalculatabeleData.purchasePriceValue > 0 else { return 0 }
        
        // Count only the units with non-zero amounts
        let validUnitsCount = propertyData.propertyCalculatabeleData.amounts.compactMap {
            Double($0) ?? 0
        }.reduce(0, +)
        
        return validUnitsCount > 0 ? (propertyData.propertyCalculatabeleData.purchasePriceValue / Double(validUnitsCount) * 1000) : 0
    }
    
    var monthlyCashFlow: Double {
        ((totalMonthlyIncome() - totalExpensesMonthly) - monthlyMortgagePayment())
    }
    
    var annualCashFlow: Double {
        ((totalMonthlyIncome() - totalExpensesMonthly) - monthlyMortgagePayment()) * 12
    }
    
    var cashOnCashReturn: Double {
        (annualCashFlow / Double(includingMoneyDown) * 100)
    }
    
    var capRateFinal: Double {
        (((totalMonthly() - (propertyManagementMonthlyAmount + leasingCostsMonthlyAmount + maintenanceMonthlyAmount + utilitiesMonthlyAmount + insuranceMonthlyAmount + utilitiesMonthlyAmount + insuranceMonthlyAmount + otherMonthlyAmount + vacancyMonthAmount ))) / ((totalYearly() - (propertyManagementYearAmount + leasingCostsYearAmount + maintenanceYearAmount + utilitiesYearAmount + insuranceYearAmount + utilitiesYearAmount + insuranceYearAmount + otherYearAmount + vacancyAmount)))) * 100
    }
    
    var dSCR: Double {
        netOperatingIncomeYearAmount / (monthlyMortgagePayment() * 12)
    }
    
    var anualNOI: Double {
        netOperatingIncomeYearAmount
    }
    
    var anualDebtService: Double {
        monthlyMortgagePayment() * 12
    }
}
