//
//  QuranProvider.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-17.
//

import SwiftUI

class QuranProvider {
    static let shared = QuranProvider()
        
    let ayas: [Aya]
    let suras: [Sura]
    let sofhas: [Sofha] = (1...604).map{ Sofha(id: $0) }
    let hizbs: [Hizb] = (1...60).map{ Hizb(id: $0) }
    
    var ayasBySura: [Int: [Aya]] = [:]
    var ayasBySofha: [Int: [Aya]] = [:]
    var ayasByHizb: [Int: [Aya]] = [:]
    
    init() {
        let decoder = JSONDecoder()
        guard let ayaPath = Bundle.main.path(forResource: QuranDataConstants.ayasFilename, ofType: QuranDataConstants.fileExtension),
              let ayaData = try? Data(contentsOf: URL(fileURLWithPath: ayaPath)),
              let suraPath = Bundle.main.path(forResource: QuranDataConstants.surasFilename, ofType: QuranDataConstants.fileExtension),
              let suraData = try? Data(contentsOf: URL(fileURLWithPath: suraPath))
        else {
            fatalError(QuranDataErrors.failedToLoadData.message)
        }
        do {
            suras = try decoder.decode([Sura].self, from: suraData)
        } catch {
            fatalError(QuranDataErrors.failedToDecodeSurasData(message: error.localizedDescription).message)
        }
        do {
            ayas = try decoder.decode([Aya].self, from: ayaData)
        } catch {
            fatalError(QuranDataErrors.failedToDecodeAyasData(message: error.localizedDescription).message)
        }
        ayasBySura = ayasBySura(ayas: ayas, suras: suras)
        ayasBySofha = ayasBySofha(ayas: ayas, sofhas: sofhas)
        ayasByHizb = ayasByHizb(ayas: ayas, hizbs: hizbs)
    }
}

extension QuranProvider {
    private func ayasBySura(ayas: [Aya], suras: [Sura]) -> [Int: [Aya]] {
        var ayasBySura = [Int: [Aya]]()
        for sura in suras {
            let suraAyas = ayas.filter { $0.suraID == sura.id }
            ayasBySura[sura.id] = suraAyas
        }
        return ayasBySura
    }
    
    private func ayasBySofha(ayas: [Aya], sofhas: [Sofha]) -> [Int: [Aya]] {
        var ayasBySofha = [Int: [Aya]]()
        for sofha in sofhas {
            let sofhaAyas = ayas.filter { $0.sofhaID == sofha.id }
            ayasBySofha[sofha.id] = sofhaAyas
        }
        return ayasBySofha
    }
    
    private func ayasByHizb(ayas: [Aya], hizbs: [Hizb]) -> [Int: [Aya]] {
        var ayasByHizb = [Int: [Aya]]()
        for hizb in hizbs {
            let hizbAyas = ayas.filter { $0.hizbID == hizb.id }
            ayasByHizb[hizb.id] = hizbAyas
        }
        return ayasByHizb
    }
}

extension QuranProvider {
    func sura(_ id: Int) -> Sura { suras[id-1] }
    func aya(_ id: Int) -> Aya { ayas[id-1] }
    func sofha(_ id: Int) -> Sofha { sofhas[id-1] }
    func hizb(_ id: Int) -> Hizb { hizbs[id-1] }
    
    func ayas(from: Int, to: Int) -> [Aya] {
        Array(ayas[(from-1)...(to-1)])
    }
    func suras(from: Int, to: Int) -> [Sura] {
        Array(suras[(from-1)...(to-1)])
    }
    func hizbs(from: Int, to: Int) -> [Hizb] {
        Array(hizbs[(from-1)...(to-1)])
    }
    func sofhas(from: Int, to: Int) -> [Sofha] {
        Array(sofhas[(from-1)...(to-1)])
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

// MARK: - Place
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

enum QuranDataConstants {
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
