//
//  FilterSheetView.swift
//  iosAppDevelopmentUni
//
//  Created by Herényi Orsolya on 07/02/2025.
//

import SwiftUI

struct FilterSheetView: View {
    @ObservedObject var presenter: FilterPresenter
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Filter by")) {
                    Picker("Filter Criteria", selection: $presenter.selectedFilterCriteria) {
                        ForEach(FilterCriteria.allCases) { criteria in
                            Text(criteria.rawValue).tag(criteria)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section(header: Text("Filter text")) {
                    TextField("Enter filter text", text: $presenter.filterText)
                }
            }
            .navigationTitle("Filter Options")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        dismiss()
                    }
                }
            }
        }
    }
}
