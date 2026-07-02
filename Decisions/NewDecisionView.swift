//
//  NewDecisionView.swift
//  Decisions
//
//  Created by Mac on 02/07/26.
//

import SwiftUI

struct NewDecisionView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var userDeciding: String = ""
    @State private var option1Name: String = ""
    @State private var option2Name: String = ""
    
    var body: some View {
        NavigationSplitView {
            List {
                Section("What are you deciding?") {
                    ZStack(alignment: .top) {
                        CardView()
                            .frame(height: 100)
                        
                        TextField("Enter your decision here", text: $userDeciding, axis: .vertical)
                            .lineLimit(1...3)
                            .padding()
                            .textFieldStyle(.plain)
                    }
                }
                .listSectionSeparator(.hidden)
                
                Section("Options") {
                    VStack {
                        ZStack(alignment: .top) {
                            CardView()
                                .frame(minHeight: 150)
                                
                            VStack {
                                TextField("Name this option", text: $option1Name, axis: .vertical)
                                    .lineLimit(1...2)
                                    .padding()
                                    .textFieldStyle(.plain)
                                
                                CardView()
                                    .frame(maxWidth: 325, minHeight: 100)
                                    .padding()
                            }
                            
                        }
                    }
                }
                .listSectionSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .navigationTitle(Text("New Decision"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: backToHome) {
                        Label("Close", systemImage: "xmark")
                    }
                }
                ToolbarItem {
                    Button(action: addDecision) {
                        Label("Add Decision", systemImage: "checkmark")
                    }
                }
            }
        } detail: {
            Text("Add an decision")
        }
        
    }
    
    private func backToHome() {
        dismiss()
    }
    
    private func addDecision() {
        
    }
    
}

#Preview {
    NewDecisionView()
}
