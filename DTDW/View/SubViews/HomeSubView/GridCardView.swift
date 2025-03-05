//
//  GridCardView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

struct GridCardView: View {
    var card: HomeCardModel
    @State private var showingDeleteAlert = false
    @State private var showingSubscriptionAlert = false
    @EnvironmentObject var purchaseViewModel: PurchaseViewModel
    var deleteAction: () -> Void

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                // Image Section
                if let imageData = card.imageName, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 90)
                        .clipped()
                } else {
                    Image("Picture")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 90)
                        .clipped()
                }

                // Property Name
                Text(card.title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.black)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .padding(.horizontal, 10)

                // Cash on Return and Cap Rate
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 3) {
                        Text("\(card.cashOnReturn):")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.black.opacity(0.5))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        Text("\(card.cashOnReturnData, specifier: "%.2f")%")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(card.cashOnReturnData < 0 ? .red : .green)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }

                    HStack(spacing: 3) {
                        Text("\(card.capRate):")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.black.opacity(0.5))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        Text("\(card.capRateData, specifier: "%.2f")%")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(card.capRateData < 0 ? .red : .green)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 5)

                // View Deal Button
                Button {
                    card.buttonAction()
                } label: {
                    Text("View Deal")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color.champagneColor)
                        .frame(maxWidth: .infinity, maxHeight: 30)
                }
                .frame(maxWidth: .infinity, maxHeight: 30)
                .background(Color.viewDealButtonBackgroundColor)
                .cornerRadius(50)
                .padding(.horizontal, 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(LinearGradient(
                            colors: [Color(#colorLiteral(red: 0.6147011518, green: 0.1258341968, blue: 0.4036872387, alpha: 1)), Color(#colorLiteral(red: 0.8818204999, green: 0.6534648538, blue: 0.7702771425, alpha: 1))],
                            startPoint: .leading,
                            endPoint: .trailing
                        ), lineWidth: 0.94)
                        .padding(.horizontal, 20)
                )
                .shadow(color: Color.viewDealButtonShadowColor, radius: 4, x: 0, y: 1)
                .padding(.bottom, 10)
                .contentShape(Rectangle())
            }
            .frame(height: 208, alignment: .top)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.1), radius: 6, x: 1, y: 1)
            .onLongPressGesture {
                if purchaseViewModel.isSubscribed {
                    showingDeleteAlert = true // Show delete confirmation alert
                } else {
                    showingSubscriptionAlert = true // Show subscription alert
                }
            }
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Delete Deal"),
                    message: Text("Are you sure you want to delete this deal?"),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteAction() // Perform delete action
                    },
                    secondaryButton: .cancel()
                )
            }
            .alert(isPresented: $showingSubscriptionAlert) {
                Alert(
                    title: Text("Delete Restricted"),
                    message: Text("You need to be subscribed to delete deals."),
                    dismissButton: .default(Text("OK")))
            }
        }
    }
}
