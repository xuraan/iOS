//
//  KollectionSection.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-23.
//

import SwiftUI

struct KollectionSection: View {
    @EnvironmentObject var kModel: KollectionProvider
    var kollections: [Kollection]?
    
    init(kollections: [Kollection]? = nil) {
        self.kollections = kollections
    }
    
    var body: some View {
        if let kollections = kollections, !kollections.isEmpty  {
            Section{
                ForEach(kollections){ kollection in
                    KollectionRow(for: kollection, isEditable: false)
                }
            } header: {
                Label("Collections", systemImage: "square.on.circle.fill")
            }
        } else {
            if !kModel.kollections.isEmpty {
                Section{
                    ForEach(kModel.kollections){ kollection in
                        KollectionRow(for: kollection, isEditable: true)
                            .swipeActions {
                                Button(role: .destructive) {
                                    kModel.remove(id: kollection.id)
                                } label: {
                                    Label("delete", systemImage: "trash")
                                }

                            }
                    }
                } header: {
                    Label("My collections", systemImage: "square.on.circle.fill")
                }
            }
        }
    }
    
}

struct KollectionRow: View {
    @ObservedObject var kollection: Kollection
    var isEditable: Bool
    
    init(for kollection: Kollection, isEditable: Bool = true) {
        self.kollection = kollection
        self.isEditable = isEditable
    }

    var body: some View {
        NavigationLink{
            KollectionView(for: kollection, isEditable: isEditable)
        } label: {
            Label {
                Text(kollection.name)
            } icon: {
                Image(systemName: "circle.fill")
                    .foregroundColor(kollection.color)
            }
        }
    }
}

struct KollectionSection_Previews: PreviewProvider {
    static var previews: some View {
        KollectionSection()
    }
}
