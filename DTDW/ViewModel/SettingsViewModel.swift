//
//  SettingsViewModel.swift
//  DTDW
//
//  Created by Sopnil Sohan on 28/1/25.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var privacyURL = URL(string: "https://www.youtube.com")!
    @Published var termsURL = URL(string: "https://www.youtube.com")!
    @Published var showingSafariViewForPrivacy = false
    @Published var showingSafariViewForTerms = false
    
    @Published var isShowingMailView = false
    @Published var mailError = false
    @Published var isShowingShareSheet = false
    @Published var ifAccessPremiumAllowed: Bool = false
}
