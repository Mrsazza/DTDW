//
//  PurchaseTermsManager.swift
//  DTDW
//
//  Created by Sopnil Sohan on 18/11/24.
//

import Foundation
import SwiftUI
import Combine
import SwiftData

class PurchaseTermsManager: ObservableObject {
    @Published var marketValue: Int? = 400000
    @Published var purchasePriceValue: Int? = 250000
    @Published var downPaymentValue: Int? = 10
    @Published var interestRateValue: Double? = 6.50
    @Published var mortgageLengthValue: Int? = 30
    
    // Inputs
    @Published var findersFees: Int? = 0
    @Published var inspection: Int? = 0
    @Published var titleSearchFee: Int? = 300
    @Published var titleInsurance: Double? = 100
    @Published var appraisal: Int? = 0
    @Published var deedRecordingFee: Int? = 100
    @Published var loanOriginationFee: Int? = 0
    @Published var survey: Int? = 0
    @Published var copOther: Int? = 0
    
    @Published var cosmeticMinor: Int? = 0
    @Published var cosmeticMajor: Int? = 0
    @Published var structural: Int? = 0
    @Published var fixtures: Int? = 0
    @Published var landscaping: Int? = 0
    @Published var corOther: Int? = 0
    @Published var contingencyFactor: Double? = 10.0 // Default percentage
    
    //Rental Assumptions...
    @Published var units: [Int] = []
    @Published var amounts: [String]
    
    //Income..
    @Published var administrativeFees: Int? = nil
    @Published var applianceRentals: Int? = nil
    @Published var furnitureRental: Int? = nil
    @Published var parking: Int? = nil
    @Published var laundryIncome: Int? = nil
    @Published var otherIncome: Int? = nil
    
    init() {
        self.units = Array(1...5)
        self.amounts = ["$1200", "$1200", "$600"] + Array(repeating: "$0", count: 2) // First 3 units prepopulated, rest default to $0
    }
    
    // Computed total income...
    var totalIncome: Int {
        [administrativeFees, applianceRentals, furnitureRental, parking, laundryIncome, otherIncome]
            .compactMap { $0 }
            .reduce(0, +)
    }
    
    // Computed properties for calculated data
    var discountProfit: Double {
        guard let marketValue = marketValue, let purchasePriceValue = purchasePriceValue else { return 0 }
        return Double(marketValue - purchasePriceValue)
    }
    
    var downPaymentAmount: Double {
        guard let purchasePriceValue = purchasePriceValue, let downPaymentValue = downPaymentValue else { return 0 }
        return Double(purchasePriceValue) * (Double(downPaymentValue) / 100)
    }
    
    var amountFinanced: Double {
        guard let purchasePriceValue = purchasePriceValue else { return 0 }
        return Double(purchasePriceValue) - downPaymentAmount
    }
    
    var monthlyMortgagePayment: Double {
        guard let interestRateValue = interestRateValue,
              let mortgageLengthValue = mortgageLengthValue else {
            print("Invalid values for monthly mortgage calculation")
            return 0
        }
        
        let monthlyRate = interestRateValue / 100 / 12
        let numberOfPayments = Double(mortgageLengthValue * 12)
        
        return amountFinanced * (monthlyRate * pow(1 + monthlyRate, numberOfPayments)) / (pow(1 + monthlyRate, numberOfPayments) - 1)
    }
    
    // Calculated Outputs(COP)
    var totalCostOfPurchase: Int {
        let fees = findersFees ?? 0
        let inspectionCost = inspection ?? 0
        let searchFee = titleSearchFee ?? 0
        let insuranceCost = Int(titleInsurance ?? 0) // Convert Double to Int
        let appraisalCost = appraisal ?? 0
        let recordingFee = deedRecordingFee ?? 0
        let originationFee = loanOriginationFee ?? 0
        let surveyCost = survey ?? 0
        let otherCost = copOther ?? 0
        
        return fees + inspectionCost + searchFee + insuranceCost + appraisalCost + recordingFee + originationFee + surveyCost + otherCost
    }
    
    // Calculated Outputs(COR)
    var totalCostOfRepair: Int {
        let minor = cosmeticMinor ?? 0
        let major = cosmeticMajor ?? 0
        let structural = structural ?? 0
        let fixtures = fixtures ?? 0
        let landscap = landscaping ?? 0
        let otherCost = corOther ?? 0
        let contingencyFactor = Int(contingencyFactor ?? 0)
        
        return minor + major + structural + fixtures + landscap + otherCost + contingencyFactor
    }
    
    var totalInitialExpenses: Int {
        totalCostOfPurchase + totalCostOfRepair
    }
    
    var contingencyAmount: Int {
        Int(Double(totalCostOfRepair) * (contingencyFactor ?? 0) / 100)
    }
    
    var includingMoneyDown: Int {
        totalCostOfPurchase + totalCostOfRepair + Int(downPaymentAmount)
    }
    
    //Calculate Rental Assumptions monthly totals
    var monthlyTotals: [Double] {
        amounts.map { Double($0.replacingOccurrences(of: "$", with: "")) ?? 0 }
    }
    
    // Calculate Rental Assumptions yearly totals
    var yearlyTotals: [Double] {
        monthlyTotals.map { $0 * 12 }
    }
    
    // Rental Assumption
    var cashOnCashReturn: Double {
        guard let purchasePriceValue = purchasePriceValue else { return 0 }
        
        // Count only the units with non-zero amounts
        let validUnitsCount = amounts.filter { amount in
            let amountValue = Double(amount.replacingOccurrences(of: "$", with: "")) ?? 0
            return amountValue > 0
        }.count
        
        return validUnitsCount > 0 ? Double(purchasePriceValue) / Double(validUnitsCount) : 0
    }
    
    // Total Rental Assumptions Monthly Income
    var totalMonthly: Double {
        monthlyTotals.reduce(0, +)
    }
    
    // Total Rental Assumptions Yearly Income
    var totalYearly: Double {
        yearlyTotals.reduce(0, +)
    }
    
    // Add a new Rental Assumptions unit and corresponding amount
    func addUnit() {
        units.append(units.count + 1)
        amounts.append("$0")
    }
    
    // Formatter for numbers without decimals
    var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
}
