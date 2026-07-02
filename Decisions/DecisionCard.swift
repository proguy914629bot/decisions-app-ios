//
//  DecisionCard.swift
//  Decisions
//
//  Created by Mac on 01/07/26.
//

import SwiftUI

struct DecisionCard: View {
    
    var decision: DecisionData
    
    var body: some View {
        if decision.decided {
            HStack(alignment: .center, spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color(red: 44 / 255, green: 156 / 255, blue: 106 / 255, opacity: 0.2))
                        .frame(width: 45, height: 45)
                    
                    Image(systemName: "checkmark")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 44 / 255, green: 156 / 255, blue: 106 / 255))
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(decision.name)
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                    
                    Text(decision.decidedOption!.name)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                
            }
            .padding()
            .frame(width: 360, alignment: .leading)
            .background(Color(.white))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
        } else {
            
            VStack(alignment: .leading, spacing: 12) {
                
                Text("Deciding")
                    .foregroundColor(Color(red: 181 / 255, green: 115 / 255, blue: 26 / 255))
                    .frame(width: 70, height: 25)
                    .font(.caption)
                    .background(Color(red: 224 / 255, green: 160 / 255, blue: 40 / 255, opacity: 0.16))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
                
                Text(decision.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                HStack {
                    ForEach(decision.options) { opt in
                        Text(opt.name)
                            .font(.caption)
                            .padding(5)
                            .background(Color(red: 120 / 255, green: 120 / 255, blue: 140 / 255, opacity: 0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
                    }
                }
            }
            .padding()
            .frame(width: 360, alignment: .leading)
            .background(Color(.white))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
            
        }
    }
}

struct OptionCard: View {
    let option: Option
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(option.name)
                    .font(.headline)
                Spacer()
                if isSelected {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark")
                        Text("Your pick")
                    }
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.green)
                    .clipShape(Capsule())
                }
            }

            ProsConsCard(
                label: "PROS",
                items: option.pros,
                symbol: "plus",
                tint: .green
            )

            ProsConsCard(
                label: "CONS",
                items: option.cons,
                symbol: "minus",
                tint: .red
            )
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color.green : Color(.systemGray5), lineWidth: isSelected ? 2 : 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
    }
}

struct ProsConsCard: View {
    var label: String
    var items: [String]
    var symbol: String
    var tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Circle()
                    .fill(tint)
                    .frame(width: 6, height: 6)
                Text(label)
                    .font(.caption.bold())
                    .foregroundColor(tint)
            }

            ForEach(items, id: \.self) { item in
                HStack(spacing: 10) {
                    Image(systemName: symbol)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(tint)
                        .frame(width: 0, height: 20)
                        .background(tint.opacity(0.15))
                        .clipShape(Circle())
                    Text(item)
                        .font(.subheadline)
                    Spacer()
                }
            }
        }
        .padding(11)
        .background(tint.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    DecisionCard(decision: DecisionData(name: "Which university should I apply to?", options: [
        Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"]),
        Option(name: "ITB", pros: ["pros1-opt2", "pros2-opt2"], cons: ["cons1-opt2", "cons2-opt2"]),
    ]))
    
    let opt = Option(name: "ITB", pros: ["pros1-opt2", "pros2-opt2"], cons: ["cons1-opt2", "cons2-opt2"])
    
    opt.pros
    
    DecisionCard(decision: DecisionData(name: "Which university should I apply to?", options: [
        Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"]),
        Option(name: "ITB", pros: ["pros1-opt2", "pros2-opt2"], cons: ["cons1-opt2", "cons2-opt2"]),
    ], decided: true, decidedOption: Option(name: "ITS", pros: ["pros1-opt1", "pros2-opt1"], cons: ["cons1-opt1", "cons2-opt1"])))
}
