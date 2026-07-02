//
//  ContentView.swift
//  Decisions
//
//  Created by Mac on 01/07/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
//    @Query private var decisions: [DecisionData]
    @State private var isShowingSheet: Bool = false
    
    var decisions = [
        DecisionData(name: "Which university should I apply to?", options: [
            Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"]),
            Option(name: "ITB", pros: ["pros1-opt2", "pros2-opt2"], cons: ["cons1-opt2", "cons2-opt2"]),
        ]),
        DecisionData(name: "Which university should I apply to?", options: [
            Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"]),
            Option(name: "ITB", pros: ["pros1-opt2", "pros2-opt2"], cons: ["cons1-opt2", "cons2-opt2"]),
        ], decided: true, decidedOption: Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"])),
        DecisionData(name: "Which university should I apply to?", options: [
            Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"]),
            Option(name: "ITB", pros: ["pros1-opt2", "pros2-opt2"], cons: ["cons1-opt2", "cons2-opt2"]),
        ]),
        DecisionData(name: "Which university should I apply to?", options: [
            Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"]),
            Option(name: "ITB", pros: ["pros1-opt2", "pros2-opt2"], cons: ["cons1-opt2", "cons2-opt2"]),
        ], decided: true, decidedOption: Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"])),
        DecisionData(name: "Which university should I apply to?", options: [
            Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"]),
            Option(name: "ITB", pros: ["pros1-opt2", "pros2-opt2"], cons: ["cons1-opt2", "cons2-opt2"]),
        ], decided: true, decidedOption: Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"]))
    ]
    
    var body: some View {
        NavigationSplitView {
            List {
                Section("In Progress") {
                    ForEach(decisions.filter { $0.decided == false }) { decision in
                        DecisionCard(decision: decision)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                }
                Section("History") {
                    ForEach(decisions.filter { $0.decided == true }) { decision in
                        DecisionCard(decision: decision)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .navigationTitle(Text("Decisions"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addDecision) {
                        Label("Add Decision", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingSheet) {
                NewDecisionView()
            }
        } detail: {
            Text("Select a decision")
        }
    }
    
    private func addDecision() {
        isShowingSheet = true
    }
    
    private func deleteDecision(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(decisions[index])
            }
        }
    }
    
}

#Preview {
    ContentView()
}
