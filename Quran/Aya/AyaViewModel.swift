//
//  AyaViewModel.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

class AyaViewModel: ObservableObject {
    @Published var ayaFontSize: Double {
        didSet{
            UserDefaults.standard.set(ayaFontSize, forKey: "ayaFontSize")
        }
    }
    @Published var transFontSize: Double {
        didSet{
            UserDefaults.standard.set(transFontSize, forKey: "transFontSize")
        }
    }
    @Published var isTransEnable: Bool {
        didSet{
            UserDefaults.standard.set(isTransEnable, forKey: "isTransEnable")
        }
    }
    @Published var isTransBold: Bool {
        didSet{
            UserDefaults.standard.set(isTransBold, forKey: "isTransBold")
        }
    }
    @Published var isPhonticEnable: Bool {
        didSet{
            UserDefaults.standard.set(isPhonticEnable, forKey: "isPhonticEnable")
        }
    }
    @Published var isPhoneticBold: Bool {
        didSet{
            UserDefaults.standard.set(isPhoneticBold, forKey: "isPhoneticBold")
        }
    }    
    
    init(){
        Self.onBoard()
        ayaFontSize = UserDefaults.standard.double(forKey: "ayaFontSize")
        transFontSize = UserDefaults.standard.double(forKey: "transFontSize")
        isTransEnable = UserDefaults.standard.bool(forKey: "isTransEnable")
        isTransBold = UserDefaults.standard.bool(forKey: "isTransBold")
        isPhonticEnable = UserDefaults.standard.bool(forKey: "isPhonticEnable")
        isPhoneticBold = UserDefaults.standard.bool(forKey: "isPhoneticBold")
    }
}

extension AyaViewModel {
    //MARK: Public Function
    static func onBoard(){
        if UserDefaults.standard.bool(forKey: "isBoarded") {
            
        } else {
            UserDefaults.standard.set(true, forKey: "isUseSystemColorScheme")

            //MARK: APP DEFAULT VALURES
            UserDefaults.standard.set(30.0, forKey: "ayaFontSize")
            UserDefaults.standard.set(17.0, forKey: "transFontSize")
            UserDefaults.standard.set(false, forKey: "isTransBold")
            UserDefaults.standard.set(true, forKey: "isTransEnable")

            // all things we want to do onBoad
            

            

            UserDefaults.standard.set(true, forKey: "isBoarded")
        }
    }
}

