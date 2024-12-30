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
   
    
    var marketValue: Int = 0
    var purchasePriceValue: Int = 0
    var downPaymentValue: Int = 0
    var interestRateValue: Double = 0.0
    var mortgageLengthValue: Int = 0
    
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

var demoPropertyCalculatableData = PropertyCalculatableData (
    vacancyOfTotalIncome : 0.15,
    propertyManagement: 0.05,
    leasingCosts: 0.05,
    maintenance: 0.05,
    utilities:  0.05,
    propertyTaxes: 0.05,
    insurance: 0.05,
    otherOngoingExpenses: 0.05,
    
    cashOnCashReturn: 0.05,
    
    marketValue: 400000,
    purchasePriceValue: 250000,
    downPaymentValue: 10,
    interestRateValue: 6.50,
    mortgageLengthValue: 30,
    
    // Inputs
    findersFees: 5,
    inspection: 5,
    titleSearchFee: 5,
    titleInsurance: 0.05,
    appraisal: 5,
    deedRecordingFee: 5,
    loanOriginationFee: 5,
    survey: 5,
    copOther: 5,
    
    cosmeticMinor: 5,
    cosmeticMajor: 5,
    structural: 5,
    fixtures: 5,
    landscaping:  5,
    corOther: 5,
    contingencyFactor: 0.05,// Default percentage
    
    //Rental Assumptions...
    units: [5],
    amounts:  ["Hola"],
    
    //Income..
    administrativeFees: 5,
    applianceRentals: 5,
    furnitureRental: 5,
    parking: 5,
    laundryIncome: 5,
    otherIncome: 5
    
)


