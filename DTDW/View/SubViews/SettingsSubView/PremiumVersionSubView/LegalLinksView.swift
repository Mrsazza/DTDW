//
//  LegalLinksView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct LegalLinksView: View {
    var body: some View {
        VStack(spacing: 10) {
            Divider()
            
            HStack(spacing: 20) {
                Button {
                    //Privacy action button
                    
                } label: {
                    Text("Privacy Policy")
                        .foregroundStyle(Color.colorFont)
                        .font(.system(size: 12))
                }

                Divider()
                    .frame(height: 20)
                
                Button {
                    //Terms of Use action button
                } label: {
                    Text("Terms of Use")
                        .foregroundStyle(Color.colorFont)
                        .font(.system(size: 12))
                }
            }
            
            Divider()
        }
        .padding(.horizontal, 60)
    }
}
