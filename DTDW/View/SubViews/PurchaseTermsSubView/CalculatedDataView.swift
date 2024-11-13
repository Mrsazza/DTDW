//
//  CalculatedDataView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct CalculatedDataView: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text("Calculated Data")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.colorFont)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(Color.black.opacity(0.1))
            }
            
            VStack(spacing: 10) {
                HStack {
                    Text("Discount/ Profit")
                    Spacer()
                    Text("37.5")
                    Spacer()
                    Text("$1,50,000")
                    
                }
                HStack {
                    Text("Down Payment")
                    Spacer()
                    Text("$25,000")
                    
                }
                HStack {
                    Text("Amount Financed")
                    Spacer()
                    Text("90.0%")
                    Spacer()
                    Text("$2,25,000")
                    
                }
                
                HStack {
                    Text("Mortgage Payment")
                    Spacer()
                    Text("$1,422")
                    Spacer()
                    Text("$17,065")
                }
                .padding(.bottom, 20)
            }
            .font(.system(size: 13))
            .foregroundStyle(Color.black)
            .multilineTextAlignment(.center)
            
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}
