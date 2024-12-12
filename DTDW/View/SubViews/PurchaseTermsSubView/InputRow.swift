//
//  InputRow.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct InputRow<T: Numeric>: View {
    let label: String
    let placeholder: String
    @Binding var value: T?
    let formatter: NumberFormatter

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(.black)

            Spacer()

            TextField(
                placeholder,
                value: Binding(
                    get: { value ?? 0 }, // Default to 0 if value is nil
                    set: { value = $0 }
                ),
                formatter: formatter
            )
            .font(.system(size: 13))
            .keyboardType(.decimalPad)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 5)
            .minimumScaleFactor(0.05)
            .frame(width: 100, height: 30)
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
            )
        }
    }
}
