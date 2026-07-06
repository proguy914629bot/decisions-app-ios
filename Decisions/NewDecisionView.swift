//
//  NewDecisionView.swift
//  Decisions
//
//  Created by Mac on 02/07/26.
//

import SwiftUI
import SwiftData

struct NewDecisionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context

    @State private var userDeciding: String = ""
    @State private var options: [Option] = [
        Option(name: "", pros: [], cons: []),
        Option(name: "", pros: [], cons: [])
    ]
    @State private var focusedOptionIndex: Int? = 0

    private var isValid: Bool {
        !userDeciding.trimmingCharacters(in: .whitespaces).isEmpty &&
        options.filter { !$0.name.trimmingCharacters(in: .whitespaces).isEmpty }.count >= 2
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

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

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Options")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)

                        ForEach(options.indices, id: \.self) { index in
                            OptionCardView(
                                option: $options[index],
                                isFocused: focusedOptionIndex == index,
                                canDelete: options.count > 2,
                                onDelete: { options.remove(at: index) }
                            )
                            .onTapGesture { focusedOptionIndex = index }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("New Decision")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Label("Close", systemImage: "xmark")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: saveDecision) {
                        Image(systemName: "checkmark")
                            .frame(width: 20, height: 20)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                    .disabled(!isValid)
                }
            }
        }
    }

    private func saveDecision() {
        let name = userDeciding.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty else { return }
        let validOptions = options.filter { !$0.name.trimmingCharacters(in: .whitespaces).isEmpty }
        guard validOptions.count >= 2 else { return }
        let decision = DecisionData(name: name, options: validOptions)
        context.insert(decision)
        dismiss()
    }
}

struct OptionCardView: View {
    @Binding var option: Option
    var isFocused: Bool
    var canDelete: Bool = false
    var onDelete: (() -> Void)? = nil

    private let maxItems = 3

    static var proColor = Color(red: 44 / 255, green: 156 / 255, blue: 106 / 255)
    static var consColor = Color(red: 226 / 255, green: 96 / 255, blue: 74 / 255)

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TextField("Option name", text: $option.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled()

                if canDelete {
                    Button(action: { onDelete?() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color(.systemGray3))
                            .font(.system(size: 18))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 12)
            .padding(.bottom, 4)

            VStack(spacing: 6) {
                prosSection
                consSection
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

    private var prosSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Circle()
                    .fill(Color(red: 44 / 255, green: 156 / 255, blue: 106 / 255))
                    .frame(width: 10, height: 10)
                Text("PROS")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(red: 44 / 255, green: 156 / 255, blue: 106 / 255))
                Spacer()
                if option.pros.count < maxItems {
                    Button(action: { option.pros.append("") }) {
                        Image(systemName: "plus")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color(red: 44 / 255, green: 156 / 255, blue: 106 / 255))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 10)
            .padding(.bottom, option.pros.isEmpty ? 10 : 4)

            ForEach(option.pros.indices, id: \.self) { i in
                HStack(spacing: 10) {
                    Button(action: { option.pros.remove(at: i) }) {
                        ZStack {
                            Circle()
                                .fill(Color.green.opacity(0.2))
                                .frame(width: 26, height: 26)
                            Image(systemName: "plus")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(Color(red: 44 / 255, green: 156 / 255, blue: 106 / 255))
                        }
                    }
                    .buttonStyle(.plain)

                    TextField("Pro \(i + 1)", text: $option.pros[i])
                        .font(.subheadline)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
            }

            if !option.pros.isEmpty {
                Color.clear.frame(height: 6)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 44 / 255, green: 156 / 255, blue: 106 / 255).opacity(0.1))
        )
    }

    private var consSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Circle()
                    .fill(Color(red: 226 / 255, green: 96 / 255, blue: 74 / 255))
                    .frame(width: 10, height: 10)
                Text("CONS")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(red: 226 / 255, green: 96 / 255, blue: 74 / 255))
                Spacer()
                if option.cons.count < maxItems {
                    Button(action: { option.cons.append("") }) {
                        Image(systemName: "plus")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color(red: 226 / 255, green: 96 / 255, blue: 74 / 255))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 10)
            .padding(.bottom, option.cons.isEmpty ? 10 : 4)

            ForEach(option.cons.indices, id: \.self) { i in
                HStack(spacing: 10) {
                    Button(action: { option.cons.remove(at: i) }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 226 / 255, green: 96 / 255, blue: 74 / 255).opacity(0.2))
                                .frame(width: 26, height: 26)
                            Image(systemName: "minus")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(Color(red: 226 / 255, green: 96 / 255, blue: 74 / 255))
                        }
                    }
                    .buttonStyle(.plain)

                    TextField("Con \(i + 1)", text: $option.cons[i])
                        .font(.subheadline)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
            }

            if !option.cons.isEmpty {
                Color.clear.frame(height: 6)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 226 / 255, green: 96 / 255, blue: 74 / 255).opacity(0.1))
        )
    }
}

#Preview {
    NewDecisionView()
}
