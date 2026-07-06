//
//  ProConsCard.swift
//  Decisions
//
//  Created by Mac on 02/07/26.
//

import SwiftUI

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
    ProsConsCard(label: "test pro", items: ["pro"], symbol: "plus", tint: .green)
    ProsConsCard(label: "test cons", items: ["cons"], symbol: "minus", tint: .red)
}
