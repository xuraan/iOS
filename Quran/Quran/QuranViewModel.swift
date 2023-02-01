//
//  QuranViewModel.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

class QuranViewModel: ObservableObject {
    
    @Published var selection: Int {
        didSet{
            UserDefaults.standard.set(selection, forKey: "quranSelection")
        }
    }
    @Published var isShow: Bool = false
    @Published var isShowIndex: Bool = false
    @Published var selectedDetent: PresentationDetent = .float
    @Published var suraViewScrollTo: Int?
    @Published var cuurentAyaID: Aya.ID = 1
    @Published var mode: Mode {
        didSet{
            UserDefaults.standard.set(mode.rawValue, forKey: "quranMode")
            switch mode {
                case .sura:
//                    if let sofha = quran.sofhas.first(where: { $0.id-1 == selection }) {
//                        selection = (sofha.suras.first?.id ?? 1)-1
//                        DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
//                            self.suraViewScrollTo = sofha.ayas.first?.id ?? nil
//                        }
//                    }
                    ayaOpenAction = openActionModeSura
                    suraOpenAction = openActionModeSura
                    sofhaOpenAction = openActionModeSura
                
                case .sofha:
//                    selection = (quran.ayas.first{ $0.id == cuurentAyaID }?.sofha.id ?? 1)-1
                    ayaOpenAction = openActionModeSofha
                    suraOpenAction = openActionModeSofha
                    sofhaOpenAction = openActionModeSofha
            }
        }
    }
    
    var ayaOpenAction: (Aya)->Void = {_ in}
    var suraOpenAction: (Sura)->Void = {_ in}
    var sofhaOpenAction: (Sofha)->Void = {_ in}
    
        
    init() {
        self.selection = UserDefaults.standard.integer(forKey: "quranSelection")
        let mode = Mode.allCases.first(where: { $0.rawValue == UserDefaults.standard.string(forKey: "quranMode") }) ?? .sura
        self.mode = mode
        
        switch mode {
        case .sura:
            ayaOpenAction = openActionModeSura
            suraOpenAction = openActionModeSura
            sofhaOpenAction = openActionModeSura
        case .sofha:
            ayaOpenAction = openActionModeSofha
            suraOpenAction = openActionModeSofha
            sofhaOpenAction = openActionModeSofha
        }
    }
}

extension QuranViewModel {
    func show(){
        withAnimation{
            isShow = true
        }
    }
    func hide(){
        withAnimation{
            isShow = false
        }
    }
    func showIndex(){
        selectedDetent = .large
    }
    func hideIndex(){
        DispatchQueue.main.async { [self] in
            selectedDetent = .hide
        }
    }
}

extension QuranViewModel {
    
    func openActionModeSura(sura: Sura)->Void{
        withAnimation{
            selection = Int(sura.id-1)
            hideIndex()
            isShow = true
        }
    }
    func openActionModeSofha(sura: Sura)->Void{
        selection = Int((sura.sofhas.toSuras.first?.id ?? 1)-1)
        hideIndex()
        isShow = true
    }
    
    func openActionModeSura(sofha: Sofha)->Void{
        withAnimation{
            selection = Int(sofha.suras.toSuras.first!.id-1)
            hideIndex()
            isShow = true
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.3){ [self] in
//                suraViewScrollTo = Int(sofha.ayas.toAyas.first!.id)
//            }
        }

    }
    func openActionModeSofha(sofha: Sofha)->Void{
        withAnimation{
            selection = Int(sofha.id-1)
            hideIndex()
            isShow = true
        }
   
    }
        
    func openActionModeSura(aya: Aya)->Void{
        withAnimation{
            selection = Int(aya.sura.id-1)
            isShowIndex = false
            isShow = true
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                self.suraViewScrollTo = Int(aya.id)
            }
        }
        
    }
    func openActionModeSofha(aya: Aya)->Void{
        withAnimation{
            selection = Int(aya.sofha.id - 1)
            isShowIndex = false
            isShow = true
        }

    }

}


extension QuranViewModel {
    enum Mode: String, CaseIterable, Hashable, Identifiable {
        case sura, sofha
        var id: Self{self}
    }

}
