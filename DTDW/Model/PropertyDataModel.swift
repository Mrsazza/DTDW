//
//  Untitled.swift
//  DTDW
//
//  Created by Sazza on 16/12/24.
//

import Foundation
import SwiftData

@Model
class PropertyDataModel {
    @Attribute(.unique) // Ensures uniqueness of the ID
    var id: UUID

    var propertyName: String

    @Attribute(.externalStorage) // For efficient handling of potentially large image data
    var imageData: Data?
    
    var casOnCashReturn: Double
    var capRate: Double
   
    var propertyCalculatabeleData: PropertyCalculatableData

    // SwiftData requires an explicit initializer if custom initializations are needed.
    init(
        id: UUID = UUID(),
        propertyName: String,
        imageData: Data? = nil,
        propertyCalculatabeleData: PropertyCalculatableData,
        cashOnCashReturn : Double = 11.52,
        capRate : Double = 8.33
        
    ) {
        self.id = id
        self.propertyName = propertyName
        self.imageData = imageData
        self.propertyCalculatabeleData = propertyCalculatabeleData
        self.casOnCashReturn = cashOnCashReturn
        self.capRate = capRate
    }
}


struct PropertyCalculatableData: Codable {
    var vacancyOfTotalIncome: Double =  5.0
    var propertyManagement: Double = 50
    var leasingCosts: Double = 0
    var maintenance: Double = 100
    var utilities: Double = 500
    var propertyTaxes: Double = 412
    var insurance: Double = 121
    var otherOngoingExpenses: Double = 0
    
    var cashOnCashReturnn: Double = 0.0
    var capRatee: Double = 0.0
    
    var marketValue: Double = 400000.0
    var purchasePriceValue: Double = 250000.0
    var downPaymentValue: Double = 10.0
    var interestRateValue: Double = 6.50
    var mortgageLengthValue: Double = 30.0
    
    // Inputs
    var findersFees: Int? = 0
    var inspection: Int? = 0
    var titleSearchFee: Int? = 300
    var titleInsurance: Int? = 100
    var appraisal: Int? = 0
    var deedRecordingFee: Int? = 100
    var loanOriginationFee: Int? = 0
    var survey: Int? = 0
    var copOther: Int? = 0
    
    var cosmeticMinor: Int? = 0
    var cosmeticMajor: Int? = 0
    var structural: Int? = 0
    var fixtures: Int? = 0
    var landscaping: Int? = 0
    var corOther: Int? = 0
    var contingencyFactor: Double? = 10.0
    
    //Rental Assumptions...
    var units: [Int] = []
    var amounts: [String] = []
    
    //Income..
    var administrativeFees: Double? = 0
    var applianceRentals: Double? = 0
    var furnitureRental: Double? = 0
    var parking: Double? = 0
    var laundryIncome: Double? = 0
    var otherIncome: Double? = 0
}

var demoPropertyCalculatableData = PropertyCalculatableData (
    vacancyOfTotalIncome : 5.0,
    propertyManagement: 50.0,
    leasingCosts: 0.0,
    maintenance: 100.0,
    utilities:  500.0,
    propertyTaxes: 412.0,
    insurance: 121.0,
    otherOngoingExpenses: 0.0,
    
    marketValue: 400000.0,
    purchasePriceValue: 250000.0,
    downPaymentValue: 10.0,
    interestRateValue: 6.50,
    mortgageLengthValue: 30,
    
    findersFees: 0,
    inspection: 0,
    titleSearchFee: 300,
    titleInsurance: 100,
    appraisal: 0,
    deedRecordingFee: 100,
    loanOriginationFee: 0,
    survey: 0,
    copOther: 0,
    
    cosmeticMinor: 0,
    cosmeticMajor: 0,
    structural: 0,
    fixtures: 0,
    landscaping:  0,
    corOther: 0,
    contingencyFactor: 10.0, // Default percentage
    
    //Rental Assumptions...
    units: [1 , 2, 3, 4, 5, 6], // Default unit
    amounts: ["1200", "1200", "600", "0", "0", "0" ], // Default amount

    administrativeFees: 0,
    applianceRentals: 0,
    furnitureRental: 0,
    parking: 0,
    laundryIncome: 0,
    otherIncome: 0
)
