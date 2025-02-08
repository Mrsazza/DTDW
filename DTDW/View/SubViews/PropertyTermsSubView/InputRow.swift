//
//  InputRow.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//
import SwiftUI

struct InputRow<T: Numeric & LosslessStringConvertible>: View {
    let label: String
    let placeholder: String
    @Binding var value: T?
    let formatter: NumberFormatter

    @State private var textValue: String = ""

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(.black)

            Spacer()

            TextField(
                placeholder,
                text: Binding(
                    get: { textValue },
                    set: { newValue in
                        textValue = newValue
                        if let number = formatter.number(from: newValue) {
                            // Use NSNumber directly without conditional casting
                            if T.self == Int.self {
                                value = T(exactly: number.intValue)
                            } else if T.self == Double.self || T.self == Float.self {
                                value = T("\(number.doubleValue)") // Convert to string and parse
                            } else {
                                value = nil
                            }
                        }
                    }
                )
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
            .onAppear {
                // Initialize the text field with the formatted value
                if let value = value, let formattedValue = formatter.string(from: NSNumber(value: Double("\(value)") ?? 0.0)) {
                    textValue = formattedValue
                }
            }
        }
    }
}
