//
//  HomePageNoDeals.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI
import SwiftData

struct DTDWHomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var properties: [PropertyDataModel]
    @State private var selectedProperty: PropertyDataModel?
    @State private var searchText = ""
    @State private var isGridView: Bool = true
    @State private var isPresentingPropertyTerms = false
    @State private var isPresentingSavedPropertyTerms = false
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 2)
    
    private var filteredProperties: [PropertyDataModel] {
        searchText.isEmpty ? properties : properties.filter { $0.propertyName.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header Section
                headerSection
                
                // Divider
                divider
                
                VStack(spacing: 20) {
                    // Title Section
                    Text("Real Estate Analysis")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.black)
                        .padding(.top, 20)
                    
                    // Search Bar
                    SearchBar(text: $searchText)
                    
                    // Your Deals Section
                    yourDealsSection
                }
                .background(.white)
                .clipShape(RoundedCornerShape(corners: [.topLeft, .topRight], radius: 20))
                .padding(.horizontal, 15)
                .shadow(color: Color.blackOnePercentColor, radius: 4, x: 2, y: 0)
                .ignoresSafeArea()
            }
        }
        .fullScreenCover(item: $selectedProperty, onDismiss: {
            selectedProperty = nil
        }) { item in
            DTDWPropertyTermsMainView(propertyData: item)
        }
    }
    
    // MARK: - Subviews
    
    private var headerSection: some View {
        HStack(spacing: 20) {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 52)
            
            VStack(alignment: .center, spacing: 4) {
                Text("Does The Deal Work?")
                    .foregroundStyle(Color.deepPurpelColor)
                    .font(.system(size: 18, weight: .semibold))
                
                Text("Ask the Land Lady®")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.black)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    private var divider: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 2)
            .foregroundStyle(Color.colorDivider)
    }
    
    private var yourDealsSection: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Your Deals")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Grid or List Button
                Button {
                    isGridView.toggle()
                } label: {
                    Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                        .font(.system(size: 18))
                        .foregroundStyle(.black)
                        .padding(8)
                }
            }
            .padding(.horizontal, 20)
            
            // Divider
            divider
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
                .onTapGesture(perform: hideKeyboard)
        )
    }
    
    private var noDealsView: some View {
        VStack(spacing: 8) {
            Image("Property Icon")
                .resizable()
                .scaledToFill()
                .frame(width: 42, height: 42)
            
            Text("No Deals")
                .font(.system(size: 20, weight: .bold))
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
                GridCardView(
                    card: HomeCardModel(
                        imageName: property.imageData,
                        title: property.propertyName,
                        cashOnReturn: "COR",
                        cashOnReturnData: property.cashOnCashReturn,
                        capRate: "Cap Rate",
                        capRateData: property.capRate,
                        buttonAction: { selectedProperty = property }
                    ),
                    deleteAction: { deleteProperty(property) }
                )
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 80)
        .onTapGesture(perform: hideKeyboard)
    }
    
    private var listView: some View {
        LazyVStack(spacing: 10) {
            ForEach(filteredProperties, id: \.id) { property in
                SwipeableCardView(
                    card: HomeCardModel(
                        imageName: property.imageData,
                        title: property.propertyName,
                        cashOnReturn: "Cash on Return",
                        cashOnReturnData: property.cashOnCashReturn,
                        capRate: "Cap Rate",
                        capRateData: property.capRate,
                        buttonAction: { selectedProperty = property }
                    ),
                    deleteAction: { deleteProperty(property) }
                )
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 80)
        .frame(maxHeight: .infinity)
        .onTapGesture(perform: hideKeyboard)
    }
    
    // MARK: - Helper Methods
    
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
