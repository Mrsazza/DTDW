//
//  GridCardView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

struct GridCardView: View {
    var card: HomeCardModel
    @State private var showingAlert = false
    @State private var cardToDelete: HomeCardModel?
    var deleteAction: () -> Void

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                //Image...
                if let imageData = card.imageName, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(height: 112)
                } else {
                    Image("Picture")
                        .resizable()
                        .frame(height: 112)
                }
                
                //Name
                Text(card.title)
                    .font(.system(size: 11))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .padding(.horizontal, 10)
                
                
                //cash and cap
                HStack(spacing: 5) {
                    HStack(spacing: 3) {
                        Text(card.cashOnReturn)
                            .font(.system(size: 7))
                            .foregroundStyle(.black.opacity(0.5))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        Text("\(card.cashOnReturnData, specifier: "%.2f")%")
                            .font(.system(size: 7))
                            .foregroundStyle(card.cashOnReturnData < 0 ? Color.red : Color(#colorLiteral(red: 0.5127275586, green: 0.7354346514, blue: 0.1412258446, alpha: 1)))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                    
                    HStack(spacing: 3) {
                        Text(card.capRate)
                            .font(.system(size: 7))
                            .foregroundStyle(.black.opacity(0.5))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        Text("\(card.capRateData, specifier: "%.2f")%")
                            .font(.system(size: 7))
                            .foregroundStyle(card.capRateData < 0 ? Color.red : Color(#colorLiteral(red: 0.5127275586, green: 0.7354346514, blue: 0.1412258446, alpha: 1)))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 5)
                
               //Button
                Button {
                    card.buttonAction()
                } label: {
                    Text("View Deal")
                        .font(.system(size: 10))
                        .minimumScaleFactor(0.5)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.champagneColor)
                        .frame(maxWidth: .infinity, maxHeight: 30) // Ensures the text takes the full width and height
                }
                .frame(maxWidth: .infinity, maxHeight: 30) // Ensures the button has a full tappable frame
                .background(Color.viewDealButtonBackgroundColor)
                .cornerRadius(50)
                .padding(.horizontal, 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(LinearGradient(colors: [Color(#colorLiteral(red: 0.6147011518, green: 0.1258341968, blue: 0.4036872387, alpha: 1)), Color(#colorLiteral(red: 0.8818204999, green: 0.6534648538, blue: 0.7702771425, alpha: 1))], startPoint: .leading, endPoint: .trailing), lineWidth: 0.94)
                        .padding(.horizontal, 20)
                )
                .shadow(color: Color.viewDealButtonShadowColor, radius: 4, x: 0, y: 1)
                .padding(.bottom, 10)
                .contentShape(Rectangle()) // Ensures the entire frame is tappable
            }
            .frame(height: 208 , alignment: .top)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: Color(.black).opacity(0.1), radius: 6, x: 1, y: 1)
            .onLongPressGesture {
                showingAlert = true
                cardToDelete = card // Store the card that is being deleted
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Delete Deal"),
                    message: Text("Are you sure you want to delete this deal?"),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteAction()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}
