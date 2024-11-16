//
//  DefaultTextFieldStyle.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct DefaultTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(.black.opacity(0.5))
            .padding(.horizontal)
            .frame(width: 297, height: 38)
            .background(Color(#colorLiteral(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)))
            .cornerRadius(10)
    }
}
