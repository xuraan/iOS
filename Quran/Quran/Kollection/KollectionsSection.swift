//
//  KollectionsSection.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-11.
//

import SwiftUI

struct KollectionsSection: View {
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)]
    ) var kollections: FetchedResults<Kollection>
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var model: Model
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var ayaVM: AyaViewModel
    @EnvironmentObject var searchVM: SearchModel
    var body: some View {
        let immutable = kollections.filter{ $0.isImmutable && $0.id != Kollection.favoriteID }
        Section{
            ForEach(immutable){ kollection in
                NavigationLink{
                    KollectionView(for: kollection)
                        .navigationTitle(LocalizedStringKey(kollection.id))
                } label: {
                    Label(title: {
                        Text(LocalizedStringKey(kollection.id))
                    }, icon: {
                        Image(systemName: "circle.fill")
                            .foregroundColor(kollection.color)
                    })
                }
                .contextMenu(menuItems: {
                    Text(kollection.id)
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
        } header: {
            Label("Collections", systemImage: "lock.rectangle.on.rectangle.fill")
        }
        if !kollections.filter({ !$0.isImmutable }).isEmpty {
            Section{
                ForEach(kollections.filter{ !$0.isImmutable }){ kollection in
                    NavigationLink{
                        KollectionView(for: kollection)
                            .navigationTitle(kollection.id)
                    } label: {
                        Label(title: {
                            Text(LocalizedStringKey(kollection.id))
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
            } header: {
                Label("My collections", systemImage: "rectangle.on.rectangle.fill")
            }
        }
    }
}

