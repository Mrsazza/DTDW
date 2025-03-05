//
//  InputRow.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//
import SwiftUI

struct InputRow: View {
    let label: String
    @Binding var value: Double?
    let isCurrency: Bool = true
    
    @State private var textValue: String = "0"
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(.black)
            
            Spacer()
            
            TextField(isCurrency ? "$0" : "", text: $textValue)
                .formattedTextField()
                .keyboardType(.decimalPad)
                .focused($isTextFieldFocused)
                .onChange(of: textValue) {
                    // Handle empty string case
                    if textValue.isEmpty {
                        value = 0
                    } else {
                        value = Double(textValue) ?? 0
                    }
                }
                .onAppear {
                    textValue = value != nil ? String(format: "%.0f", value!) : "0"
                }
                .onChange(of: isTextFieldFocused) {
                    if isTextFieldFocused {
                        if textValue == "0" {
                            textValue = ""
                        }
                    } else {
                        if textValue.isEmpty {
                            textValue = "0"
                            value = 0
                        }
                    }
                }
        }
    }
}
