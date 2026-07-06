//
//  OptionCard.swift
//  Decisions
//
//  Created by Mac on 02/07/26.
//

import SwiftUI

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

#Preview {
    OptionCard(option: Option(name: "test opt", pros: ["opt1 pro"], cons: ["cons opt1"]), isSelected: false)
}
