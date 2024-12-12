//
//  InitialExpemsesCOPCalculatedDataView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct InitialExpensesCalculatedDataView: View {
    @ObservedObject var viewModel: InitialExpensesViewModel

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
                    Text("$\(viewModel.contingencyAmount)")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                }
                
                HStack {
                    Text("Total Cost of Purchase (COP)")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                    Spacer()
                    Text("$\(viewModel.totalCostOfPurchase)")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                }
                
                HStack {
                    Text("Total Cost of Repair (COR)")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                    Spacer()
                    Text("$\(viewModel.totalCostOfRepair)")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                }
                
                HStack {
                    Text("Total Initial Expenses")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                    Spacer()
                    Text("$\(viewModel.totalInitialExpenses)")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 1, y: 1)
    }
}
