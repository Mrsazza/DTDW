//
//  NewsletterCustomTextField.swift
//  DTDW
//
//  Created by Sopnil Sohan on 28/1/25.
//

import SwiftUI

struct NewsletterCustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var placeholderColor: Color = .gray
    var textColor: Color = .black
    var backgroundColor: Color = Color(#colorLiteral(red: 0.9607843757, green: 0.9607843757, blue: 0.9607843757, alpha: 1))
    var cornerRadius: CGFloat = 10
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Show the placeholder when text is empty
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .padding(.leading, 8) // Align placeholder text with text field's padding
            }
            
            // Actual TextField with clear background, so the placeholder shows
            TextField("", text: $text)
                .foregroundColor(textColor)
                .padding(10)
                .background(Color.clear)  // Make background clear so placeholder shows
                .cornerRadius(cornerRadius)
                .autocorrectionDisabled()
        }
        .background(backgroundColor) // Apply the actual background color here
        .cornerRadius(cornerRadius)
    }
}
