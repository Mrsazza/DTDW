//
//  DTDWTabView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 11/11/24.
//

import SwiftUI
import SwiftData

enum Tab {
    case home
    case plus
    case settings
}

struct DTDWTabView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var properties: [PropertyDataModel]
    @State private var selectedProperty: PropertyDataModel?
    @State private var selectedTab: Tab = .home
    @State private var isPresentingPropertyTerms = false
    @State private var isShowingPremiumSheet = false
    
    @EnvironmentObject var purchaseViewModel: PurchaseViewModel
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                DTDWHomeView()
            case .settings:
                DTDWSettingsView()
            default:
                EmptyView()
            }
            tabBar
                .background(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                .ignoresSafeArea()
                .zIndex(0)
        }
        .onChange(of: selectedProperty) {
            // Debugging: Track changes to selectedProperty
            print("selectedProperty changed: \(String(describing: selectedProperty?.propertyName))")
        }
        .onChange(of: isPresentingPropertyTerms) {
            // Debugging: Track when the fullscreen cover is triggered
            print("isPresentingPropertyTerms changed to: \(isPresentingPropertyTerms)")
        }
        .fullScreenCover(isPresented: $isPresentingPropertyTerms) {
            // Debugging: Check if selectedProperty is set correctly before presenting fullscreen
            if let property = selectedProperty {
                DTDWPropertyTermsMainView(propertyData: property)
            } else {
                // In case selectedProperty is nil, show a temporary view
                Text("Loading...") // Temporary view in case the property is nil (to avoid a blank page)
            }
        }
        .fullScreenCover(isPresented: $isShowingPremiumSheet) {
            DTDWPremiumSubscriptionsView()
        }
    }
    
    private var tabBar: some View {
        HStack(alignment: .center) {
            tabButton(for: .home, imageNameWhite: "HomeImageWhite", imageNameBlack: "HomeImageBlack", title: "Home")
            
            plusTabButton()
                .padding(.bottom, 10)
            
            tabButton(for: .settings, imageNameWhite: "SettingsImageWhite", imageNameBlack: "SettingsImageBlack", title: "Settings")
        }
        .frame(height: 90)
    }
    
    private func tabButton(for tab: Tab, imageNameWhite: String, imageNameBlack: String, title: String) -> some View {
        Button {
            selectedTab = tab
        } label: {
            let isActive = selectedTab == tab && selectedTab != .plus
            CustomTabButton(imageNameWhite: imageNameWhite, imageNameBlack: imageNameBlack, tabText: title, isActive: isActive)
        }
        .tint(Color.white)
    }
    
    private func plusTabButton() -> some View {
        Button {
            // Check if the user is subscribed or has fewer than 3 properties
            if purchaseViewModel.isSubscribed || properties.count < 3 {
                addNewProperty()
            } else {
                // Show premium subscription view
                isShowingPremiumSheet = true
            }
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color.colorFont)
                .frame(width: 54, height: 54)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.15), radius: 2, x: 1, y: 2)
        }
    }
    
    private func addNewProperty() {
        // Dynamically create a new property with a unique name or other data
        let newDynamicProperty = PropertyDataModel(propertyName: "Landlady Apt.", propertyCalculatabeleData: demoPropertyCalculatableData)
        
        // Insert the new property in the model context
        modelContext.insert(newDynamicProperty)
        
        // Save context and ensure it's successful
        do {
            try modelContext.save()
            
            // Debugging: Ensure that the property is saved and selectedProperty is set correctly
            print("New property saved: \(newDynamicProperty.propertyName)")
            
            // After saving, update the state and present the fullscreen view
            DispatchQueue.main.async {
                selectedProperty = newDynamicProperty
                isPresentingPropertyTerms = true
                
                // Debugging: Confirm that the fullscreen view is triggered with the right property
                print("Full screen cover presented with: \(String(describing: selectedProperty?.propertyName))")
            }
        } catch {
            // Handle error if saving the context fails
            print("Error saving property: \(error.localizedDescription)")
        }
    }
}
