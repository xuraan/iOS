//
//  SuraView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct SuraView: View {
    let sura: Sura
    @State var rect: CGRect = .zero
    @State var lastOffsetY: CGFloat = .zero
    @State var isHide: Bool = false
    @State var scrollTo: Aya.ID?
    @EnvironmentObject var qModel: QuranViewModel
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
                        ForEach(sura.ayas){ aya in
                            AyaView(for: aya)
                                .offset(coordinateSpace: .named("sura\(sura.id)")){ value in
                                    if (100...150).contains(value.minY){
                                        if qModel.currentAya != aya {
                                            qModel.currentAya = aya
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 5)
                    .offset(coordinateSpace: .named("sura\(sura.id)")){ value in
                        DispatchQueue.main.async {
                            withAnimation{
                                if rect.minY >= -20 {
                                    if isHide {
                                        isHide = false
                                    }
                                } else {
                                    if !isHide {
                                        isHide = true
                                    }
                                }
                            }
                            rect = value
                        }
                    }
                }
                .coordinateSpace(name: "sura\(sura.id)")
                .safeAreaInset(edge: .top){
                    NavigationButtomSheet {
                        QuranIndeView()
                    } label: {
                        Text(sura.name)
                            .font(.waseem(25))
                            .padding(.top, -5)
                    }
                    .frame(maxWidth: .infinity)
                    .background {
                        Rectangle().fill(.ultraThinMaterial)
                        
                            .ignoresSafeArea()
                            .overlay(alignment: .bottom){
                                Divider()
                            }
                            .opacity(isHide ? 1 : 0)
                            .animation(isHide ? .none : .easeInOut, value: isHide)
                    }
                }
                .onAppear{
                    withAnimation{
                        if qModel.suraViewScrollTo != sura.ayas.first?.id {
                            scroll.scrollTo(qModel.suraViewScrollTo, anchor: .top)
                        }
                    }
                }
                .onReceive(qModel.$suraViewScrollTo) { value in
                    withAnimation{
                        if value != sura.ayas.first?.id {
                            scroll.scrollTo(value, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

struct SuraView_Previews: PreviewProvider {
    static var previews: some View {
        SuraView(for: QuranProvider.shared.sura(3))
            .environmentObject(QuranViewModel())
    }
}
