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
    
    @State private var textValue: String = "0" // Default to "0"
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(.black)
            
            Spacer()
            
            TextField(isCurrency ? "$0" : "", text: $textValue)
                .formattedTextField()
                .keyboardType(.decimalPad)
                .onChange(of: textValue) {
                    // Handle empty string case
                    if textValue.isEmpty {
                        textValue = "0" // Set to "0" if empty
                        value = 0
                    } else {
                        // Convert the text input to a Double, or set to 0 if the conversion fails
                        value = Double(textValue) ?? 0
                    }
                }
                .onAppear {
                    // Initialize the text value with the current Double value or "0" if nil
                    textValue = value != nil ? String(format: "%.0f", value!) : "0"
                }
        }
    }
}
