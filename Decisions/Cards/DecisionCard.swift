//
//  DecisionCard.swift
//  Decisions
//
//  Created by Mac on 02/07/26.
//

import SwiftUI

private let proGreen = Color(red: 44 / 255, green: 156 / 255, blue: 106 / 255)
private let decidingAmber = Color(red: 224 / 255, green: 160 / 255, blue: 40 / 255)
private let decidingAmberText = Color(red: 181 / 255, green: 115 / 255, blue: 26 / 255)

struct DecisionCard: View {
    var decision: DecisionData
    @State private var isShowingSheet = false

    var body: some View {
        if decision.decided {
            decidedCard
        } else {
            inProgressCard
        }
    }

    private var decidedCard: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack {
                Circle()
                    .fill(proGreen.opacity(0.15))
                    .frame(width: 45, height: 45)
                Image(systemName: "checkmark")
                    .bold()
                    .font(.system(size: 18))
                    .foregroundColor(proGreen)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(decision.name)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.primary)
                if let picked = decision.decidedOption {
                    Text(picked.name)
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)
        .onTapGesture { isShowingSheet = true }
        .sheet(isPresented: $isShowingSheet) {
            DecisionPickView(decision: decision)
        }
    }

    private var inProgressCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Deciding")
                .foregroundColor(decidingAmberText)
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(decidingAmber.opacity(0.16))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            Text(decision.name)
                .font(.headline)
                .foregroundStyle(.primary)

            HStack(spacing: 6) {
                ForEach(decision.options) { opt in
                    if !opt.name.isEmpty {
                        Text(opt.name)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)
        .onTapGesture { isShowingSheet = true }
        .sheet(isPresented: $isShowingSheet) {
            DecisionPickView(decision: decision)
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        DecisionCard(decision: DecisionData(name: "Which university should I apply to?", options: [
            Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"]),
            Option(name: "ITB", pros: ["pros1-opt2", "pros2-opt2"], cons: ["cons1-opt2", "cons2-opt2"]),
        ]))

        DecisionCard(decision: DecisionData(name: "Which university should I apply to?", options: [
            Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"]),
            Option(name: "ITB", pros: ["pros1-opt2", "pros2-opt2"], cons: ["cons1-opt2", "cons2-opt2"]),
        ], decided: true, decidedOption: Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"])))
    }
    .padding()
}
