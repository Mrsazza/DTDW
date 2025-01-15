//
//  PurchaseTermsHederView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI
import PhotosUI

struct PurchaseTermsHederView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isEditing: Bool = false
    
    @Bindable var propertyData: PropertyData
    
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var showingPhotoPicker = false
    
    var body: some View {
        HStack {
            Button {
                dismiss()
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
                showingPhotoPicker = true // Open the photo picker
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.purchaseHeaderButtonFillColor)
                        .frame(width: 44, height: 44)
                        .shadow(color: Color.purchaseHeaderButtonShadowColor, radius: 4, x: 2, y: 2)

                    Circle()
                        .stroke(Color.purchaseHeaderButtonStrokeColor, lineWidth: 1)
                        .frame(width: 44, height: 44)

                    Image("cameraImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 24)
                }
            }
            .photosPicker(
                isPresented: $showingPhotoPicker,
                selection: $selectedPhotoItem,
                matching: .images
            )
            .onChange(of: selectedPhotoItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
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
}
