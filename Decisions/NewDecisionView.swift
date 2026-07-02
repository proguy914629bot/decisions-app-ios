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
    @State private var options: [Option] = [
        Option(name: "", pros: [], cons: []),
        Option(name: "", pros: [], cons: [])
    ]
    @State private var focusedOptionIndex: Int? = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // I'M DECIDING section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("I'm Deciding...")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)

                        ZStack(alignment: .topLeading) {
                            CardView()
                                .frame(minHeight: 80)

                            TextField("What's your decision?", text: $userDeciding, axis: .vertical)
                                .lineLimit(1...3)
                                .padding()
                                .font(.headline)
                                .textFieldStyle(.plain)
                                .autocorrectionDisabled()
                        }
                    }

                    // OPTIONS section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("OPTIONS (\(options.count))")
                            .font(.caption)
//                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)

                        ForEach(options.indices, id: \.self) { index in
                            OptionCardView(
                                option: $options[index],
                                isFocused: focusedOptionIndex == index
                            )
                            .onTapGesture {
                                focusedOptionIndex = index
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("New Decision")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                            .padding(8)
                            .background(Circle().fill(Color(.systemGray5)))
                    }
                    .buttonStyle(.plain)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addDecision) {
                        Image(systemName: "checkmark")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(Circle().fill(Color.blue))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func addDecision() {
        dismiss()
    }
}

struct OptionCardView: View {
    @Binding var option: Option
    var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Option name", text: $option.name)
                .font(.title3)
                .fontWeight(.semibold)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
                .padding(.horizontal, 12)
                .padding(.top, 12)
                .padding(.bottom, 4)

            VStack(spacing: 6) {
                // PROS row
                HStack {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                    Text("PROS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.green)
                    Spacer()
                    Button(action: { option.pros.append("") }) {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.green)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green.opacity(0.1))
                )

                // CONS row
                HStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                    Text("CONS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.red)
                    Spacer()
                    Button(action: { option.cons.append("") }) {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.red)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.red.opacity(0.1))
                )
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(isFocused ? Color.blue : Color.clear, lineWidth: 2)
        )
    }
}

#Preview {
    NewDecisionView()
}
