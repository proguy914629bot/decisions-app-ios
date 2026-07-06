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
    @Query(sort: \DecisionData.createdAt, order: .reverse) private var decisions: [DecisionData]
    @State private var isShowingNewDecision = false

    private var inProgress: [DecisionData] { decisions.filter { !$0.decided } }
    private var history: [DecisionData] { decisions.filter { $0.decided } }

    var body: some View {
        NavigationStack {
            Group {
                if decisions.isEmpty {
                    ContentUnavailableView(
                        "No Decisions Yet",
                        systemImage: "",
                        description: Text("Tap + to start weighing your options")
                    )
                } else {
                    List {
                        if !inProgress.isEmpty {
                            Section("In Progress") {
                                ForEach(inProgress) { decision in
                                    DecisionCard(decision: decision)
                                        .listRowBackground(Color.clear)
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
                                }
                                .onDelete { offsets in
                                    delete(from: inProgress, at: offsets)
                                }
                            }
                        }

                        if !history.isEmpty {
                            Section("History") {
                                ForEach(history) { decision in
                                    DecisionCard(decision: decision)
                                        .listRowBackground(Color.clear)
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
                                }
                                .onDelete { offsets in
                                    delete(from: history, at: offsets)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Decisions")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingNewDecision = true }) {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $isShowingNewDecision) {
                NewDecisionView()
            }
        }
    }

    private func delete(from list: [DecisionData], at offsets: IndexSet) {
        for i in offsets {
            context.delete(list[i])
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: DecisionData.self, inMemory: true)
}
