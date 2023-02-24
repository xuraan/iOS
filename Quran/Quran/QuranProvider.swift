//
//  QuranProvider.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-17.
//

import SwiftUI
import CoreSpotlight
import MobileCoreServices

extension Bundle {
    func load<T: Decodable>(_ filename: String, extention: String, as: T.Type) -> T {
        guard let path = Bundle.main.path(forResource: filename, ofType: extention),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError(QuranDataErrors.failedToLoadData.message)
        }
        do {
            let decoder = JSONDecoder()
            print("samba")
            return try decoder.decode(T.self, from: data)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

class QuranProvider {
    static let shared = QuranProvider()
        
    let ayas: [Aya] = Bundle.main.load(QuranProvider.ayasFilename, extention: "json", as: [Aya].self)
    let suras: [Sura] = Bundle.main.load(QuranProvider.surasFilename, extention: "json", as: [Sura].self)
    let sofhas: [Sofha] = (1...604).map{ Sofha(id: $0) }
    let hizbs: [Hizb] = (1...60).map{ Hizb(id: $0) }
    
    let ayasBySura: [Int: [Aya]]
    let ayasBySofha: [Int: [Aya]]
    let ayasByHizb: [Int: [Aya]] 
    
    init(){
        self.ayasBySura = Self.ayasBySura(ayas: ayas, suras: suras)
        self.ayasBySofha = Self.ayasBySofha(ayas: ayas, sofhas: sofhas)
        self.ayasByHizb = Self.ayasByHizb(ayas: ayas, hizbs: hizbs)
    }

}

// MARK: - Place Sura
extension QuranProvider {
    static let makiyaSuraIDs: [Int] = { [1, 6, 7, 10, 11, 12, 14, 15, 16, 17, 18, 19, 20, 21, 23, 25, 26,
                                         27, 28, 29, 30, 31, 32, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
                                         45, 46, 50, 51, 52, 53, 54, 56, 67, 68, 69, 70, 71, 72, 73, 74, 75,
                                         77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93,
                                         94, 95, 96, 97, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 111,
                                         112, 113, 114] }()
    
    static let madaniyaSuraIDs: [Int] = { [2, 3, 4, 5, 8, 9, 13, 22, 24, 33, 47, 48,
                                          49, 55, 57, 58, 59, 60, 61, 62, 63, 64, 65,
                                          66, 76, 98, 99, 110] }()
}

//MARK: - Perform access data by using Dictionnary
extension QuranProvider {
    
    static private func ayasBySura(ayas: [Aya], suras: [Sura]) -> [Int: [Aya]] {
        var ayasBySura = [Int: [Aya]]()
        for sura in suras {
            let suraAyas = ayas.filter { $0.suraID == sura.id }
            ayasBySura[sura.id] = suraAyas
        }
        return ayasBySura
    }
    
    static private func ayasBySofha(ayas: [Aya], sofhas: [Sofha]) -> [Int: [Aya]] {
        var ayasBySofha = [Int: [Aya]]()
        for sofha in sofhas {
            let sofhaAyas = ayas.filter { $0.sofhaID == sofha.id }
            ayasBySofha[sofha.id] = sofhaAyas
        }
        return ayasBySofha
    }
    
    static private func ayasByHizb(ayas: [Aya], hizbs: [Hizb]) -> [Int: [Aya]] {
        var ayasByHizb = [Int: [Aya]]()
        for hizb in hizbs {
            let hizbAyas = ayas.filter { $0.hizbID == hizb.id }
            ayasByHizb[hizb.id] = hizbAyas
        }
        return ayasByHizb
    }
    
}

//MARK: - Access items by ID
extension QuranProvider {
    func sura(_ id: Int) -> Sura? { (1...114).contains(id) ? suras[id-1] : nil }
    
    func aya(_ id: Int) -> Aya? { (1...6236).contains(id) ? ayas[id-1] : nil }
    
    func sofha(_ id: Int) -> Sofha? { (1...604).contains(id) ? sofhas[id-1] : nil }
    
    func hizb(_ id: Int) -> Hizb? { (1...60).contains(id) ? hizbs[id-1] : nil }
}

//MARK: - CONSTANT
extension QuranProvider {
    static let ayasFilename = "ayas"
    static let surasFilename = "suras"
    static let sofhasFilename = "sofhas"
    static let hizbsFilename = "hizbs"
    static let fileExtension = "json"
}

enum QuranDataErrors: Error {
    case failedToLoadData
    case failedToDecodeAyasData(message: String)
    case failedToDecodeSurasData(message: String)
    
    var message: String {
        switch self {
        case .failedToLoadData:
            return "Failed to load Quran data"
        case .failedToDecodeAyasData(let message), .failedToDecodeSurasData(let message):
            return "Failed to decode Quran data: \(message)"
        }
    }
}

// MARK: - Search
extension QuranProvider {
    func searchSuras(text: String) async -> [Sura] {
        if text.isArabic{
            return suras.filter{ $0.name.contains(text)}
        } else if text.isNumeric{
            return suras.filter{ "\($0.id)" == text }
        } else if text.isArabicNumeral{
            return suras.filter{ "\($0.id)".toArabicNumeral == "\(text)" }
        } else {
            return suras.filter{ $0.phonetic.lowercased().contains(text.lowercased()) || $0.translation.lowercased().contains(text.lowercased()) }
        }
    }
    
    func searchAyas(text: String) async -> [Aya] {
        if text.isArabic{
            return ayas.filter{ $0.simple.contains(text)}
        } else if text.isNumeric{
            return ayas.filter{ $0.secondaryID.contains(text) }
        } else if text.isArabicNumeral{
            return ayas.filter{ $0.secondaryID.toArabicNumeral.contains(text)}
        } else {
            return ayas.filter{ $0.text.lowercased().contains(text.lowercased()) || $0.translation.lowercased().contains(text.lowercased()) }
        }
    }
    
    func searchSofhas(text: String) async -> [Sofha] {
        if text.isNumeric{
            return sofhas.filter{ "\($0.id)".contains(text) }
        } else if text.isArabicNumeral{
            return sofhas.filter{ "\($0.id)".toArabicNumeral.contains(text) }
        }
        return []
    }
    
    func searchHizb(text: String) async -> [Hizb] {
        if text.isNumeric{
            return hizbs.filter{ "\($0.id)".contains(text) }
        } else if text.isArabicNumeral{
            return hizbs.filter{ "\($0.id)".toArabicNumeral.contains(text) }
        }
        return []
    }
}
