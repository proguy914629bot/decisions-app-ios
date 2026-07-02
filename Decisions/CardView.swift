//
//  CardView.swift
//  Decisions
//
//  Created by Mac on 02/07/26.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color(.systemBackground))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    CardView()
}
