//
//  QuranViewModel.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

class QuranViewModel: ObservableObject {
    var show: () -> Void = {}
    
    @Published var selection: Int {
        didSet{
            UserDefaults.standard.set(selection, forKey: "quranSelection")
        }
    }
    @Published var isShowIndex: Bool = false
    @Published var suraViewScrollTo: Int16 = 0
    @Published var cuurentAyaID: Aya.ID = 1
    @Published var lastPage: Any?
    @Published var mode: Mode {
        didSet{
            UserDefaults.standard.set(mode.rawValue, forKey: "quranMode")
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
    func openActionModeSura(sura: Sura)->Void{
        withAnimation{
            selection = Int(sura.id-1)
            show()
            isShowIndex = false
        }
    }
    func openActionModeSofha(sura: Sura)->Void{
        selection = Int((sura.sofhas.sofhas.first?.id ?? 1)-1)
        show()
        isShowIndex = false
    }
    
    func openActionModeSura(sofha: Sofha)->Void{
        withAnimation{
            selection = Int(sofha.suras.suras.first!.id-1)
            show()
            isShowIndex = false
            DispatchQueue.main.asyncAfter(deadline:.now()+0.2, execute: { [self] in
                suraViewScrollTo = sofha.ayas.ayas.first!.id
            })
        }
    }
    func openActionModeSofha(sofha: Sofha)->Void{
        withAnimation{
            selection = Int(sofha.id-1)
            show()
            isShowIndex = false
        }
   
    }
        
    func openActionModeSura(aya: Aya)->Void{
        withAnimation{
            selection = Int(aya.sura.id-1)
            show()
            isShowIndex = false
            DispatchQueue.main.asyncAfter(deadline:.now()+0.2, execute: { [self] in
                suraViewScrollTo = aya.id
            })
        }
    }
    func openActionModeSofha(aya: Aya)->Void{
        withAnimation{
            selection = Int(aya.sofha.id - 1)
            show()
            isShowIndex = false
        }

    }
    
    func changeModeToSura(currentSofha: Sofha)->Void{
        withAnimation{
            selection = Int((currentSofha.suras.suras.first?.id ?? 1)-1)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                self.suraViewScrollTo = currentSofha.ayas.ayas.first?.id ?? 0
            }
        }
    }
    func changeModeToSofha(currentAya: Aya){
        selection = Int(currentAya.sofha.id-1)
    }
    
    func setLastPage(suras: FetchedResults<Sura>, sofhas: FetchedResults<Sofha>){
        switch mode {
        case .sura:
            lastPage = suras.first{ $0.id == Int16(selection+1) }
        case .sofha:
            lastPage = sofhas.first{ $0.id == Int16(selection+1) }
        }
    }
}


extension QuranViewModel {
    enum Mode: String, CaseIterable, Hashable, Identifiable {
        case sura, sofha
        var id: Self{self}
    }

}
