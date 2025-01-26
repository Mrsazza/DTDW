//
//  Untitled.swift
//  DTDW
//
//  Created by Sazza on 16/12/24.
//

import Foundation
import SwiftData

@Model
class PropertyData {
    @Attribute(.unique) // Ensures uniqueness of the ID
    var id: String

    var propertyName: String

    @Attribute(.externalStorage) // For efficient handling of potentially large image data
    var imageData: Data?
    
    var propertyCalculatabeleData: PropertyCalculatableData

    // SwiftData requires an explicit initializer if custom initializations are needed.
    init(
        id: String = UUID().uuidString,
        propertyName: String,
        imageData: Data? = nil,
        propertyCalculatabeleData: PropertyCalculatableData
    ) {
        self.id = id
        self.propertyName = propertyName
        self.imageData = imageData
        self.propertyCalculatabeleData = propertyCalculatabeleData
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
