//
//  ListCardView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

import SwiftUI

struct ListCardView: View {
    var card: HomeCardModel

    var body: some View {
        HStack(spacing: 16) {
            // Image Section
            if let imageData = card.imageName, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
            } else {
                Image("Picture")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
            }

            // Text Section
            VStack(alignment: .leading, spacing: 8) {
                Text(card.title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

                VStack(alignment: .leading, spacing: 3) {
                    // Cash on Return
                    HStack(spacing: 2) {
                        Text("\(card.cashOnReturn):")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.black.opacity(0.5))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text("\(card.cashOnReturnData, specifier: "%.2f")%")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(card.cashOnReturnData < 0 ? .red : .green)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }

                    // Cap Rate
                    HStack(spacing: 2) {
                        Text("\(card.capRate):")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.black.opacity(0.5))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text("\(card.capRateData, specifier: "%.2f")%")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(card.capRateData < 0 ? .red : .green)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
            }

            Spacer()

            // Chevron Icon
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(Color.deepPurpelColor)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .shadow(color: .black.opacity(0.1), radius: 6, x: 1, y: 1)
        .contentShape(Rectangle())
        .onTapGesture(perform: card.buttonAction)
    }
}

struct SwipeableCardView: View {
    var card: HomeCardModel
    var deleteAction: () -> Void
    @State private var showAlert: Bool = false

    @State private var offset: CGFloat = 0
    @GestureState private var isDragging = false

    var body: some View {
        ZStack(alignment: .trailing) {
            // Background Delete Button
            if offset < 0 {
                Button {
                    if PurchaseViewModel.shared.isSubscribed {
                        deleteAction() // Call the delete action
                    } else {
                        showAlert = true // Show alert for non-subscribed users
                    }
                } label: {
                    HStack {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.white)
                        Text("Delete")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.red)
                    .cornerRadius(10)
                }
                .padding(.trailing, 20)
                .transition(.move(edge: .trailing))
            }

            // Foreground Card View
            ListCardView(card: card)
                .offset(x: offset)
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { gesture in
                            if abs(gesture.translation.width) > 10 && abs(gesture.translation.width) > abs(gesture.translation.height) {
                                offset = gesture.translation.width
                            }
                        }
                        .onEnded { gesture in
                            withAnimation(.smooth) {
                                if offset < -100 {
                                    offset = -120
                                } else {
                                    offset = 0
                                }
                            }
                        }
                )
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Delete Restricted"),
                message: Text("You need to be subscribed to delete posts."),
                dismissButton: .default(Text("OK")))
        }
    }
}
                
