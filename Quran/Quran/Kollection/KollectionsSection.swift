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
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var model: Model
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var ayaVM: AyaViewModel
    @EnvironmentObject var searchVM: SearchModel
    var body: some View {
        if !kollections.isEmpty {
            Section("Collections"){
                ForEach(kollections){ kollection in
                    NavigationLink{
                        KollectionView(for: kollection)
                    } label: {
                        Label(title: {
                            Text(kollection.id)
                        }, icon: {
                            Image(systemName: "circle.fill")
                                .foregroundColor(kollection.color)
                        })
                        .swipeActions{
                            Button(role: .destructive, action: { context.delete(kollection) }, label: {
                                Label("Delete", systemImage: "trash")
                            })
                        }
                    }
                    .contextMenu(menuItems: {
                        Button(role: .destructive, action: { context.delete(kollection) }, label: {
                            Label("Delete", systemImage: "trash")
                        })
                    }, preview: {
                        NavigationStack{
                            KollectionView(for: kollection)
                                .environmentObject(model)
                                .environmentObject(quranVM)
                                .environmentObject(ayaVM)
                                .environmentObject(searchVM)
                        }
                    })
                }
            }
        }
    }
}

