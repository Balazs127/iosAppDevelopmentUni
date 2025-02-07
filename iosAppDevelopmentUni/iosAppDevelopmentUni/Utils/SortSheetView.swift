//
//  SortSheetView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

struct SortSheetView: View {
    @ObservedObject var presenter: SortPresenter
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sort by")) {
                    Picker("Sort by", selection: $presenter.selectedSortOption) {
                        ForEach(SortOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
                    Toggle("Ascending", isOn: $presenter.sortAscending)
                }
            }
            .navigationTitle("Sort Options")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
