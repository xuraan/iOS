//
//  HomeView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.pin) var pin
    @Environment(\.showCoverView) var showCoverView
    @Environment(\.isSearching) var isSearching
    @EnvironmentObject var kModel: KollectionProvider
    var body: some View {
        List{
            if isSearching {
                SearchView()
            } else {
                pinView()
                ForEach(kModel.kollections){ kollection in
                    NavigationLink{
                        KollectionView(for: kollection)
                    } label: {
                        Label {
                            Text(kollection.name)
                        } icon: {
                            Image(systemName: "circle.fill")
                                .foregroundColor(kollection.color)
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            kModel.remove(id: kollection.id)
                        } label: {
                            Label("delete", systemImage: "trash")
                        }

                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                SheetButton("Settings") {
                    SettingsView()
                    .presentationDetents(.init([.height(550)]))
                }
            }
            ToolbarItemGroup(placement: .primaryAction) {
                SheetButton {
                    NavigationStack{
                        KollectionEditor()
                    }
                    .presentationDetents([.height(470)])
                } label: {
                    Image(systemName: "plus")
                }
                
                NavigationButtomSheet {
                    QuranIndeView()
                } label: {
                    Image(systemName: "list.bullet.rectangle.portrait")
                }

            }
        }
        .overlay(alignment: .bottomLeading) {
            NavigationButtomSheet {
                FavoriteView()
            } label: {
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .padding(12)
                    .background {
                        Circle()
                            .fill(.ultraThinMaterial.shadow(.inner(color: .accentColor.opacity(0.1), radius: 5)))
                    }
                    .padding(-1)
                    .clipShape(Circle())
                    
            }
            .padding(.leading)
            .opacity(isSearching ? 0 : 1)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView()
                .environmentObject(KollectionProvider())
        }
    }
}


//MARK: - PinnedView
extension HomeView {
    @ViewBuilder
    func pinView() -> some View {
        if pin.wrappedValue != nil {
            Section{
                if let sura = pin.wrappedValue as? Sura {
                    SuraRow(for: sura)
                } else if let sofha = pin.wrappedValue as? Sofha {
                    SofhaRow(for: sofha)
                } else if let aya = pin.wrappedValue as? Aya {
                    AyaRow(for: aya)
                }
            }
            .padding(.vertical, -7)
        }
    }
}


