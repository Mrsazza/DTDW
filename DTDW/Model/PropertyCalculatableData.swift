//
//  PropertyCalculatableData.swift
//  DTDW
//
//  Created by Sazza on 16/12/24.
//

import Foundation


struct PropertyCalculatableData: Codable {
    var vacancyOfTotalIncome: Double?
    var propertyManagement: Double?
    var leasingCosts: Double?
    var maintenance: Double?
    var utilities: Double?
    var propertyTaxes: Double?
    var insurance: Double?
    var otherOngoingExpenses: Double?
    
    var cashOnCashReturn: Double?
    
    var marketValue: Int?
    var purchasePriceValue: Int?
    var downPaymentValue: Int?
    var interestRateValue: Double?
    var mortgageLengthValue: Int?
    
    // Inputs
    var findersFees: Int?
    var inspection: Int?
    var titleSearchFee: Int?
    var titleInsurance: Double?
    var appraisal: Int?
    var deedRecordingFee: Int?
    var loanOriginationFee: Int?
    var survey: Int?
    var copOther: Int?
    
    var cosmeticMinor: Int?
    var cosmeticMajor: Int?
    var structural: Int?
    var fixtures: Int?
    var landscaping: Int?
    var corOther: Int?
    var contingencyFactor: Double? // Default percentage
    
    //Rental Assumptions...
    var units: [Int]?
    var amounts: [String]?
    
    //Income..
    var administrativeFees: Int?
    var applianceRentals: Int?
    var furnitureRental: Int?
    var parking: Int?
    var laundryIncome: Int?
    var otherIncome: Int?
}
