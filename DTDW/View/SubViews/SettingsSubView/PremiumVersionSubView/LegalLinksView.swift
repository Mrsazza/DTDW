//
//  LegalLinksView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct LegalLinksView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Divider()
            
            HStack(spacing: 20) {
                Button {
                    settingsViewModel.showingSafariViewForPrivacy = true
                } label: {
                    Text("Privacy Policy")
                        .foregroundStyle(Color.colorFont)
                        .font(.system(size: 12))
                }

                Divider()
                    .frame(height: 20)
                
                Button {
                    settingsViewModel.showingSafariViewForTerms = true
                } label: {
                    Text("Terms of Use")
                        .foregroundStyle(Color.colorFont)
                        .font(.system(size: 12))
                }
            }
            
            Divider()
        }
        .padding(.horizontal, 60)
        .fullScreenCover(isPresented: $settingsViewModel.showingSafariViewForPrivacy) {
            DTDWSafariView(url: settingsViewModel.privacyURL)
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $settingsViewModel.showingSafariViewForTerms) {
            DTDWSafariView(url: settingsViewModel.termsURL)
                .ignoresSafeArea()
        }
    }
}
