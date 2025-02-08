//
//  SettingsViewModel.swift
//  DTDW
//
//  Created by Sopnil Sohan on 28/1/25.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var privacyURL = URL(string: "https://askthelandlady.com/privacy-policy-for-does-the-deal-work-real-estate-analysis-tool/")!
    @Published var termsURL = URL(string: "https://askthelandlady.com/terms-of-use-for-does-the-deal-work-real-estate-analysis-tool/")!
    @Published var showingSafariViewForPrivacy = false
    @Published var showingSafariViewForTerms = false
    
    @Published var isShowingMailView = false
    @Published var mailError = false
    @Published var isShowingShareSheet = false
}
