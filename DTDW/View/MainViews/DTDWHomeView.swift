//
//  HomePageNoDeals.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI
import SwiftData

struct DTDWHomeView: View {
    @State private var searchText = ""
    @State private var isGridView: Bool = true
    @Query private var properties: [PropertyDataModel]
    @State private var isPresentingPurchaseTerms = false
    @State private var isPresentingSavedPurchaseTerms = false
    @State private var selectedProperty: PropertyDataModel?
    @StateObject var viewModel: PurchaseTermsViewModel
    @Environment(\.modelContext) private var modelContext

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    private var filteredProperties: [PropertyDataModel] {
        if searchText.isEmpty {
            return properties
        } else {
            return properties.filter { $0.propertyName.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Header Section
                headerSection

                // Divider
                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .foregroundStyle(Color.colorDivider)

                VStack(spacing: 20) {
                    // Title Section
                    Text("Real Estate Analysis")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                        .padding(.top, 20)

                    // Search bar
                    SearchBar(text: $searchText)

                    // Your Deals Section
                    yourDealsSection
                }
                .background(.white)
                .clipShape(RoundedCornerShape(corners: [.topLeft, .topRight], radius: 20))
                .padding(.horizontal, 15)
                .shadow(color: Color.blackOnePercentColor, radius: 4, x: 2, y: 0)
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .fullScreenCover(item: $selectedProperty, onDismiss: {
            selectedProperty = nil
        }) { item in
            DTDWPropertyTermsMainView(propertyData: item)
        }
    }

    private var headerSection: some View {
        HStack(spacing: 20) {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 52)

            VStack {
                Text("Does The Deal Work?")
                    .foregroundStyle(Color.deepPurpelColor)
                    .font(.system(size: 18))

                Text("Ask the Land Lady®")
                    .font(.system(size: 24))
                    .foregroundStyle(Color.black)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }

    private var yourDealsSection: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Your Deals")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Grid or List Button
                Button {
                    isGridView.toggle()
                } label: {
                    Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                        .font(.system(size: 21))
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal, 20)

            // Divider
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity, maxHeight: 2)
                .foregroundStyle(Color.colorDivider)
                .padding(.horizontal, 20)
                .padding(.top, 5)

            // Grid or List View based on toggle, or "No Deals" message if no deals available
            ScrollView(showsIndicators: false) {
                if filteredProperties.isEmpty {
                    noDealsView
                } else {
                    if isGridView {
                        gridView
                    } else {
                        listView
                    }
                }
            }
            .padding(.bottom, 30)
        }
        .background(
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
        )
    }

    private var noDealsView: some View {
        VStack(spacing: 8) {
            Image("Property Icon")
                .resizable()
                .scaledToFill()
                .frame(width: 42, height: 42)
            Text("No Deals")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundStyle(.black)
            Text("You haven’t added any deals yet")
                .font(.system(size: 16))
                .foregroundStyle(.black)
        }
        .padding(.top, 120)
    }

    private var gridView: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(filteredProperties, id: \.id) { property in
                GridCardView(card: HomeCardModel(
                    imageName: property.imageData,
                    title: "\(property.propertyName)",
                    cashOnReturn: "Cash on Return",
                    cashOnReturnData: property.casOnCashReturn,
                    capRate: "Cap Rate",
                    capRateData: property.capRate,
                    buttonAction: {
                        selectedProperty = property
                        isPresentingSavedPurchaseTerms = true
                    }
                ),deleteAction: {
                    deleteProperty(property) // Call the delete logic
                })
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 80)
    }

    private var listView: some View {
        LazyVStack(spacing: 10) {
            ForEach(filteredProperties, id: \.id) { property in
                SwipeableCardView(card: HomeCardModel(
                    imageName: property.imageData,
                    title: "\(property.propertyName)",
                    cashOnReturn: "Cash on Return",
                    cashOnReturnData: property.casOnCashReturn,
                    capRate: "Cap Rate",
                    capRateData: property.capRate,
                    buttonAction: {
                        selectedProperty = property
                        isPresentingSavedPurchaseTerms = true
                    }
                ),deleteAction: {
                    deleteProperty(property)
                })
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 80)
        .frame(maxHeight: .infinity)
    }

    private func deleteProperty(_ property: PropertyDataModel) {
        do {
            modelContext.delete(property)
            try modelContext.save()
            print("Deleted property: \(property)")
        } catch {
            print("Error deleting property: \(error)")
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
