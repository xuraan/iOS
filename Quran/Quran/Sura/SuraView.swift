//
//  SuraView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SuraView: View {
    @ObservedObject var sura: Sura
    @Environment(\.favorite) var favorite
    @Environment(\.pinned) var pinned
    @EnvironmentObject var suraVM: SuraViewModel
    @EnvironmentObject var quranVM: QuranViewModel
    @EnvironmentObject var model: Model
    @EnvironmentObject var ayaVM: AyaViewModel
    @State var rect: CGRect = .zero
    @State var lastOffsetY: CGFloat = .zero
    @State var isExpanded: Bool = false
    @State var scrollTo: Aya.ID?
    init(for sura: Sura) {
        self.sura = sura
    }
    
    var body: some View {
        GeometryReader{ proxy in
            ScrollViewReader{ scroll in
                ScrollView{
                    LazyVStack{
                        if sura.id != 9 {
                            Text("﷽")
                                .font(CustomFont.mequran(40))
                                .frame(maxWidth: .infinity)
                        }
                        ForEach(sura.ayas.ayas){ aya in
                            Group{
                                if aya == aya.sofha.ayas.ayas.first {
                                    AyaView(for: aya)
                                        .offset(coordinateSpace: .global){ value in
                                            if (100...150).contains(value.minY){
                                                quranVM.currentAya = aya
                                            }
                                        }
                                } else {
                                    AyaView(for: aya)
                                }
                            }
                            .background(Color.blue.opacity( aya.id == scrollTo ? 0.3 : 0).blur(radius: 10))
                            pageSeparator(aya: aya)
                        }
                    }
                    .padding(.top, -20)
                    .offset(coordinateSpace: .named("sura\(sura.id)")){ value in
                        DispatchQueue.main.async {
                            withAnimation{
                                
                                if rect.minY >= -20 {
                                    if isExpanded {
                                        isExpanded = false
                                    }
                                } else {
                                    if !isExpanded {
                                        isExpanded = true
                                    }
                                }
                                
                            }
                            rect = value
                        }
                    }
                }
                .coordinateSpace(name: "sura\(sura.id)")
                .safeAreaInset(edge: .top){
                    VStack{
                        CustomSheet{
                            QuranIndexView()
                            .preferredColorScheme(model.preferredColorScheme)
                            .environmentObject(quranVM)
                            .environmentObject(suraVM)
                            .environmentObject(ayaVM)
                        } label: {
                            Text(sura.name)
                                .font(CustomFont.waseem(35))
                                .contextMenu(menuItems: {
                                    sura.menu(favorite: favorite, pinned: pinned)
                                })
                                .padding(.vertical, -10)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                                .contentTransition(.interpolate)
                        }
                        .tint(Color.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 5)
                    .background{
                        Rectangle().fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                            .overlay(alignment: .bottom){
                                Divider()
                            }
                            .opacity(isExpanded ? 1 : 0)
                            .animation(isExpanded ? .none : .easeInOut, value: isExpanded)
                    }
                }
                .overlay(alignment: .top){
                    HStack{
                        VStack(alignment: .leading){
                            Text(sura.phonetic)
                                .font(.headline)
                            Text(sura.translation)
                                .font(.subheadline)
                        }
                        .lineLimit(1)
                        
                        VStack(alignment: .trailing){
                            Text(LocalizedStringKey(sura.place.id))
                                .font(.headline)
                            Text("ayas: \(sura.ayas.ayas.count)")
                                .font(.subheadline)
                        }
                        .lineLimit(1)
                    }
                    .offset(y: 50)
                    .opacity(rect.minY*0.001)
                }
                .onAppear{
                    scrollTo = scrollTo
                }
                .onChange(of: scrollTo){ value in
                    withAnimation{
                        scroll.scrollTo(value, anchor: .top)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now()+1){
                        withAnimation{
                            scrollTo = nil
                        }
                    }
                }
                .onReceive(quranVM.$suraViewScrollTo){ value in
                    scrollTo = value
                }
            }
        }
        .background(Color.yellow.opacity( sura.isElement(of: favorite) ? 0.05 : 0 ).ignoresSafeArea())
        .onReceive(quranVM.$selection) { value in
            if value+1 == Int16(sura.id){
                quranVM.currentSura = sura
            }
        }
    }
    
    @ViewBuilder
    func pageSeparator(aya: Aya) -> some View {
        if aya == aya.sofha.ayas.ayas.last {
            HStack{
                VStack{
                    Divider()
                }
                Text("\(aya.sofha.id)")
                    .font(.footnote)
                VStack{
                    Divider()
                }
            }
            .offset(y: 5)
        }
    }
}
