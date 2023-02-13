//
//  SofhasView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SofhasView: View {
    @Environment(\.pinned) var pinned
    @Environment(\.favorite) var favorite
    
    @Binding var selection: Int
    @State var isExtended: Bool = false
    @Binding var isHideCloseButton: Bool
    var secondaryAction: ()->Void
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var sofhas: FetchedResults<Sofha>

    // MARK: - INITIALE FINCTION.
    
    init(
        selection: Binding<Int>,
        SecondaryAction: @escaping ()->Void = {},
        isHideCloseButton: Binding<Bool>
    ){
        self._selection = selection
        self.secondaryAction = SecondaryAction
        self._isHideCloseButton = isHideCloseButton
    }
    var body: some View {
        GeometryReader{ proxy in
            PageView(
                selection: $selection,
                isReversed: true,
                pages: sofhas.map{ sofha in
                    SofhaView(isExtended: $isExtended,for: sofha)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .safeAreaInset(edge: .top){
                            HStack{}
                            .frame(height: isExtended ? 1 : 45)
                            .offset(y: proxy.safeAreaInsets.top)
                        }
                       .ignoresSafeArea(.container, edges: isExtended ? [.horizontal, .bottom] : [.all])
                       .environment(\.favorite, favorite)
                       .environment(\.pinned, pinned)
                }
            )
            .ignoresSafeArea()
            .overlay(alignment: .topLeading, content: {
                Button(action: secondaryAction){
                    Image(systemName: "list.bullet.rectangle.portrait")
                        .foregroundColor(.secondary)
                        .font(.title)
                }
                .padding(.horizontal)
                .opacity(isExtended ? 0 : 1)
            })
            .overlay(alignment: .top){
                Picker("", selection: $selection, content: {
                    ForEach(sofhas){ sofha in
                        Text("\(sofha.id)").tag(Int(sofha.id-1))
                    }
                })
                .menuIndicator(.hidden)
                .opacity(isExtended ? 0 : 1)
            }
            
        }
        .onChange(of: isExtended){ value in
            withAnimation{
                isHideCloseButton = value
            }
        }
    }
}

struct SofhasView_Previews: PreviewProvider {
    static var previews: some View {
        SofhasView(selection: .constant(32), isHideCloseButton: .constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(QuranViewModel())
            .environmentObject(SuraViewModel())
    }
}
