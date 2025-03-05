//
//  PurchaseTermsHederView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI
import PhotosUI

struct PropertyTermsHeaderView: View {
    @EnvironmentObject var interstitialAdsViewModel: InterstitialAdsViewModel
    @EnvironmentObject var purchaseViewModel: PurchaseViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var isEditing: Bool = false
    @Bindable var propertyData: PropertyDataModel
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var showingPhotoPicker = false
    
    var body: some View {
        HStack {
            Button {
                if purchaseViewModel.isSubscribed {
                    dismiss()
                } else {
                    showInterstitialAdsAndDismiss()
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.purchaseHeaderButtonFillColor)
                        .frame(width: 44, height: 44)
                        .shadow(color: Color.purchaseHeaderButtonShadowColor, radius: 4, x: 2, y: 2)

                    Circle()
                        .stroke(Color.purchaseHeaderButtonStrokeColor, lineWidth: 1)
                        .frame(width: 44, height: 44)

                    Image(systemName: "chevron.left")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.colorFont)
                }
            }

            Spacer()

            HStack(spacing: 2) {
                Text(propertyData.propertyName)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .minimumScaleFactor(1)
                    .lineLimit(1)

                Button {
                    isEditing = true
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                }
                .padding(.top, 3)
                
            }
            .alert("Edit Property Name", isPresented: $isEditing) {
                TextField("Property Name", text: $propertyData.propertyName)
                Button("Save", role: .none) {}
                Button("Cancel", role: .cancel) {}
            }

            Spacer()

            Button {
                showingPhotoPicker = true 
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.purchaseHeaderButtonFillColor)
                        .frame(width: 44, height: 44)
                        .shadow(color: Color.purchaseHeaderButtonShadowColor, radius: 4, x: 2, y: 2)

                    Circle()
                        .stroke(Color.purchaseHeaderButtonStrokeColor, lineWidth: 1)
                        .frame(width: 44, height: 44)

                    // Conditionally display the selected image or the default camera image
                    if let imageData = propertyData.imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                    } else {
                        Image("cameraImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 24)
                    }
                }
            }
            .photosPicker(
                isPresented: $showingPhotoPicker,
                selection: $selectedPhotoItem,
                matching: .images
            )
            .onChange(of: selectedPhotoItem) {
                Task {
                    if let data = try? await selectedPhotoItem?.loadTransferable(type: Data.self) {
                        propertyData.imageData = data
                    }
                }
            }
        }
        .padding(.leading, 10)
        .padding(.trailing, 20)
        .padding(.bottom, 20)
        .background(Color.purchaseHeaderButtonBackgroundColor)
    }
    
    func showInterstitialAdsAndDismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            dismiss()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                interstitialAdsViewModel.displayInterstitialAd()
            }
        }
    }
}
