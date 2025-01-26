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
    @Bindable var propertyData: PropertyData
    @State private var selectedTab: Tab = .home
    @State private var isPresentingPurchaseTerms = false
    @State private var isPresentingSavedPurchaseTerms = false
    @State private var selectedProperty: PropertyData?
    @Environment(\.modelContext) private var modelContext
    @State private var newProperty: PropertyData? // Make this optional to allow dynamic property creation
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                DTDWHomeView(viewModel: PurchaseTermsViewModel(propertyData: propertyData))
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
        .onChange(of: newProperty) {
            // Debugging: Track changes to newProperty
            print("newProperty changed: \(String(describing: newProperty?.propertyName))")
        }
        .onChange(of: isPresentingPurchaseTerms) {
            // Debugging: Track when the fullscreen cover is triggered
            print("isPresentingPurchaseTerms changed to: \(isPresentingPurchaseTerms)")
        }
        .fullScreenCover(isPresented: $isPresentingPurchaseTerms) {
            // Debugging: Check if newProperty is set correctly before presenting fullscreen
            if let property = newProperty {
                DTDWPurchaseTermsMainView(propertyData: property)
            } else {
                // In case newProperty is nil, show a temporary view
                Text("Loading...") // Temporary view in case the property is nil (to avoid a blank page)
            }
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
            // Dynamically create a new property with a unique name or other data
            let newDynamicProperty = PropertyData(propertyName: "Land Lady Apt.", propertyCalculatabeleData: demoPropertyCalculatableData)
            
            // Insert the new property in the model context
            modelContext.insert(newDynamicProperty)
            
            // Save context and ensure it's successful
            do {
                try modelContext.save()
                
                // Debugging: Ensure that the property is saved and newProperty is set correctly
                print("New property saved: \(newDynamicProperty.propertyName)")
                
                // After saving, update the state and present the fullscreen view
                DispatchQueue.main.async {
                    newProperty = newDynamicProperty
                    isPresentingPurchaseTerms = true
                    
                    // Debugging: Confirm that the fullscreen view is triggered with the right property
                    print("Full screen cover presented with: \(String(describing: newProperty?.propertyName))")
                }
            } catch {
                // Handle error if saving the context fails
                print("Error saving property: \(error.localizedDescription)")
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
}

