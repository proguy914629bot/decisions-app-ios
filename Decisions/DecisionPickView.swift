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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//#Preview {
//    DecisionPickView()
//}

struct DecisionPickerView: View {
    @Environment(\.dismiss) private var dismiss

    var decision: DecisionData
    @State private var selectedOptionID: UUID?

    var body: some View {
        let question = decision.name
        let options = decision.options
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(question)
                            .font(.title2.bold())
                        Text("Tap the one you're going with")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    ForEach(options) { option in
                        OptionCard(
                            option: option,
                            isSelected: selectedOptionID == option.id
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                selectedOptionID = option.id
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 24)
            }
            .navigationTitle("Pick your decision")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: backToHome) {
                        Label("Close", systemImage: "xmark")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // hook up share sheet later
                    } label: {
                        Image(systemName: "checkmark")
                            .frame(width: 20, height: 20)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                }
            }
        }
    }
    
    private func backToHome() {
        dismiss()
    }
}

#Preview {
//    DecisionPickerView(
//        question: "Which university should I apply to?",
//        subtitle: "Tap the one you're going with",
//        options: [
//            Option(
//                name: "ITS",
//                pros: ["Pros 1", "Pros 1", "Pros 1"],
//                cons: ["Cons 1", "Cons 1", "Cons 1"]
//            ),
//            Option(
//                name: "ITB",
//                pros: ["Pros 1", "Pros 1", "Pros 1"],
//                cons: ["Cons 1", "Cons 1", "Cons 1"]
//            )
//        ]
//    )
    
    DecisionPickerView(decision: DecisionData(name: "Which university should I apply to?", options: [
        Option(
            name: "ITS",
            pros: ["Pros 1", "Pros 1", "Pros 1"],
            cons: ["Cons 1", "Cons 1", "Cons 1"]
        ),
        Option(
            name: "ITB",
            pros: ["Pros 1", "Pros 1", "Pros 1"],
            cons: ["Cons 1", "Cons 1", "Cons 1"]
        )
    ]))
}
