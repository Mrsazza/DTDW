//
//  SearchBar.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search deals"
    
    var body: some View {
        HStack {
            CustomTextField(text: $text, placeholder: placeholder, placeholderColor: Color.deepPurpelColor)
                .padding(7)
                .padding(.horizontal, 25)
                .foregroundColor(Color.deepPurpelColor)
                .background(Color.homeSearchBarColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(#colorLiteral(red: 1, green: 0.9268273115, blue: 0.9626460671, alpha: 1)), lineWidth: 1)
                )
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.deepPurpelColor)
                            .padding(.leading, 8)
                        Spacer()
                        
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                                hideKeyboard() // Dismiss keyboard when clearing text
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .frame(height: 36)
                .padding(.horizontal, 20)
        }
        .padding(.vertical, 5)
        .background(
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard() // Dismiss keyboard when tapping outside
                }
        )
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var placeholderColor: Color
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.text = text
        textField.borderStyle = .none
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange), for: .editingChanged)
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(placeholderColor)]
        )
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField
        
        init(_ parent: CustomTextField) {
            self.parent = parent
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
