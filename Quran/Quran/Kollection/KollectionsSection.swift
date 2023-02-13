//
//  KollectionsSection.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-11.
//

import SwiftUI

struct KollectionsSection: View {
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: Kollection.predicate
    ) var kollections: FetchedResults<Kollection>

    var body: some View {
        if !kollections.isEmpty {
            Section("Collections"){
                ForEach(kollections){ kollection in
                    Label(title: {
                        Text(kollection.id)
                    }, icon: {
                        Image(systemName: "circle.fill")
                            .foregroundColor(kollection.color)
                    })
                }
            }
        }
    }
}

