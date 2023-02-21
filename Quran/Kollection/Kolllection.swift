//
//  Kolllection.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-18.
//

import SwiftUI

// Define the data you want to store
class Kollection: ObservableObject, Identifiable, Codable {
    let id: UUID
    @Published var name: String
    @Published var description: String
    
    @Published var ayas: [Aya]
    @Published var suras: [Sura]
    @Published var hizbs: [Hizb]
    @Published var sofhas: [Sofha]
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, ayas, suras, hizbs, sofhas
    }
    
    init(id: UUID = .init(), name: String = "", description: String = "", ayas: [Aya] = [] , suras: [Sura] = [], hizbs: [Hizb] = [], sofhas: [Sofha] = []) {
        self.id = id
        self.name = name
        self.description = description
        self.ayas = ayas
        self.suras = suras
        self.hizbs = hizbs
        self.sofhas = sofhas
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        ayas = try container.decode([Int].self, forKey: .ayas).map{ QuranProvider.shared.aya($0) }
        suras = try container.decode([Int].self, forKey: .suras).map{ QuranProvider.shared.sura($0) }
        hizbs = try container.decode([Int].self, forKey: .hizbs).map{ QuranProvider.shared.hizb($0) }
        sofhas = try container.decode([Int].self, forKey: .sofhas).map{ QuranProvider.shared.sofha($0) }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(id, forKey: .id)
        try container.encode(ayas.map{ $0.id }, forKey: .ayas)
        try container.encode(suras.map{ $0.id }, forKey: .suras)
        try container.encode(hizbs.map{ $0.id }, forKey: .hizbs)
        try container.encode(sofhas.map{ $0.id }, forKey: .sofhas)
    }
}


class KollectionProvider: ObservableObject {
    @Published var kollections: [Kollection] = []
    
    // Initialize the manager and load the list of people from a JSON file
    init() {
        kollections = KollectionProvider.load().filter{ $0.id.uuidString != Constant.favUUIDString.rawValue }
    }
    
    // Load the list of people from a JSON file
    static func load() -> [Kollection] {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("kollections.json")
        if let data = try? Data(contentsOf: fileURL) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Kollection].self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    // Save the list of people to a JSON file
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode([KollectionProvider.favorite]+kollections) {
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("kollections.json")
            try? encoded.write(to: fileURL)
        }
    }
    
    // Add a new person to the list
    func add(name: String, description: String, ayas: [Aya], suras: [Sura], hizbs: [Hizb], sofhas: [Sofha]) {
        let kollection = Kollection(id: .init(), name: name, description: description, ayas: ayas, suras: suras, hizbs: hizbs, sofhas: sofhas)
        kollections.append(kollection)
        save()
    }
    
    // Remove a person from the list
    func remove(id: UUID) {
        if let index = kollections.firstIndex(where: { $0.id == id }) {
            kollections.remove(at: index)
            save()
        }
    }
    
    // Favorite
    static var favorite: Kollection = {
        load().first(where: { $0.id == UUID(uuidString: Constant.favUUIDString.rawValue) }) ??
        Kollection(id: UUID(uuidString: Constant.favUUIDString.rawValue)! , name: "favorite", description: "", ayas: [], suras: [], hizbs: [], sofhas: [])
    }()
    
    enum Constant: String {
        case favUUIDString = "C6819E4A-9203-48CE-9EE4-AAF815B52D09"
    }
}

extension Kollection {
    
    func toggle<T>(_ object: T){
        if let sura = object as? Sura{
            if suras.contains(sura), let index = suras.firstIndex(of: sura) {
                suras.remove(at: index)
            } else {
                suras.append(sura)
            }
        } else if let sofha = object as? Sofha {
            if sofhas.contains(sofha), let index = sofhas.firstIndex(of: sofha) {
                sofhas.remove(at: index)
            } else {
                sofhas.append(sofha)
            }
        } else if let aya = object as? Aya {
            if ayas.contains(aya), let index = ayas.firstIndex(of: aya) {
                ayas.remove(at: index)
            } else {
                ayas.append(aya)
            }
        } else if let hizb = object as? Hizb {
            if hizbs.contains(hizb), let index = hizbs.firstIndex(of: hizb) {
                hizbs.remove(at: index)
            } else {
                hizbs.append(hizb)
            }
        }
    }
    
    func contains<T>(_ object: T) -> Bool {
        if let sura = object as? Sura { return suras.contains(sura) }
        if let aya = object as? Aya { return ayas.contains(aya) }
        if let sofha = object as? Sofha { return sofhas.contains(sofha) }
        if let hizb = object as? Hizb { return hizbs.contains(hizb) }
        return false
    }
    
}
