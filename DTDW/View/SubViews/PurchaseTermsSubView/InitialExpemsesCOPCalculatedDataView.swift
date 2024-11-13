//
//  InitialExpemsesCOPCalculatedDataView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct InitialExpemsesCOPCalculatedDataView: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text("Calculated Data")
                    .font(.system(size: 15))
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
                    Text("Contingency Factor")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                    Spacer()
                    
                    Text("$0")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                }
                
                HStack {
                    Text("DTotal Cost of Purchase (COP)")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                    Spacer()
                    Text("$500")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                    
                }
                HStack {
                    Text("Total Cost of Repair (COR)")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                    Spacer()
                    Text("$0")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                    
                }
                HStack {
                    Text("Total Initial Expensest")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                    Spacer()
                    Text("$500")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                }
                
                HStack {
                    Text("Includind money down")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                    Spacer()
                    Text("$25,000")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                }
                .padding(.bottom, 20)
            }
            .font(.system(size: 13))
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}
