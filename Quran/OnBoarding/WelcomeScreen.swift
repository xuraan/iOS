//
//  WelcomeScreen.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-03.
//

import SwiftUI

struct WelcomeScreen: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            Button{
                if !UserDefaults.standard.bool(forKey: "dataWasAdded"){
                    let newPlace = Place(context: viewContext)
                    newPlace.id = "mk"
                    let newPlace1 = Place(context: viewContext)
                    newPlace1.id = "md"
                    let suras = Bundle.main.decodeQuran("quran.json")
                    var sofhaId: Int16 = 1
                    var newSofha = Sofha(context: viewContext)
                    newSofha.id = sofhaId
                    for sura in suras {
                        let newSura = Sura(context: viewContext)
                        newSura.id = Int16(sura.id)
                        newSura.name = sura.name
                        newSura.phonetic = sura.phonetic
                        newSura.place = sura.place == "mk" ? newPlace : newPlace1
                        var surasSofha = Set<Sofha>()
                        for aya in sura.ayas{
                            let newAya = Aya(context: viewContext)
                            newAya.id = aya.id
                            newAya.text = aya.text
                            newAya.plain = aya.plain
                            newAya.sura = newSura
                                                            
                            if aya.sofha == sofhaId {
                                newAya.sofha = newSofha
                                surasSofha.insert(newSofha)

                            } else {
                                sofhaId = sofhaId + 1
                                newSofha = Sofha(context: viewContext)
                                newSofha.id = sofhaId
                                newAya.sofha = newSofha
                                surasSofha.insert(newSofha)
                            }
                        }
                        for sofha in surasSofha.sorted(by: { $0.id < $1.id }) {
                            newSura.addToSofhas(sofha)
                        }
                    
                    }
                    try? viewContext.save()
                    UserDefaults.standard.set(true, forKey: "dataWasAdded")
                }
                UserDefaults.standard.set(true, forKey: "isBoraded")
                dismiss()
            } label: {
                Text("Start reading the holy book")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("ٱلسَّلَامُ عَلَيْكُمْ وَرَحْمَةُ ٱللَّٰهِ وَبَرَكَاتُهُ")
                        .mequran(25)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
