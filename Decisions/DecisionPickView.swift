//
//  DecisionPickView.swift
//  Decisions
//
//  Created by Mac on 02/07/26.
//

import SwiftUI

struct DecisionPickView: View {
    @Environment(\.dismiss) private var dismiss

    var decision: DecisionData
    @State private var selectedOptionID: UUID?

    private var isReadOnly: Bool { decision.decided }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(decision.name)
                            .font(.title2.bold())
                        Text(isReadOnly ? "Your decision" : "Tap the one you're going with")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    ForEach(decision.options) { option in
                        OptionCard(option: option, isSelected: selectedOptionID == option.id)
                            .onTapGesture {
                                if !isReadOnly {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        selectedOptionID = option.id
                                    }
                                }
                            }
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom, 24)
            }
            .navigationTitle(isReadOnly ? "Decision" : "Pick your decision")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Label("Close", systemImage: "xmark")
                    }
                }
                if !isReadOnly {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: commitDecision) {
                            Image(systemName: "checkmark")
                                .frame(width: 20, height: 20)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.circle)
                        .disabled(selectedOptionID == nil)
                    }
                }
            }
            .onAppear {
                selectedOptionID = decision.decidedOption?.id
            }
        }
    }

    private func commitDecision() {
        guard let id = selectedOptionID,
              let picked = decision.options.first(where: { $0.id == id }) else { return }
        decision.decidedOption = picked
        decision.decided = true
        dismiss()
    }
}

#Preview {
    DecisionPickView(decision: DecisionData(name: "Which university should I apply to?", options: [
        Option(name: "ITS", pros: ["Pros 1", "Pros 1", "Pros 1"], cons: ["Cons 1", "Cons 1", "Cons 1"]),
        Option(name: "ITB", pros: ["Pros 1", "Pros 1", "Pros 1"], cons: ["Cons 1", "Cons 1", "Cons 1"])
    ]))
}
