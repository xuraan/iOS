//
//  KollectionEditor.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-22.
//

import SwiftUI

struct KollectionEditor: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var kModel: KollectionProvider
    var kollection: Kollection?
    @State var name: String = ""
    @State var description: String = ""
    @State var color: Color = .gray
    @State var suras = Set<Sura>()
    @State var ayas = Set<Aya>()
    @State var sofhas = Set<Sofha>()
    @State var hizbs = Set<Hizb>()
    @FocusState var isDescptionFocused: Bool

    var body: some View {
        List{
            Section("Collection name"){
                TextField("Name", text: $name)
                    .overlay(alignment: .trailing){
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .blur(radius: 10)
                            .padding(-5)
                            .frame(width: 60)
                    }
                    .overlay(alignment: .trailing){
                        HStack{
                            if !name.isEmpty {
                                Button{
                                    withAnimation{
                                        name = ""
                                    }
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.secondary)
                                }
                                .buttonStyle(.borderless)
                            }
                            ColorPicker("", selection: $color)
                                .offset(x: -5)
                        }
                        .frame(width: 40)
                    }
                }
            Section("Description"){
                TextField("Description", text: $description, axis: .vertical)
                    .lineLimit(5...)
                    .focused($isDescptionFocused)
                    .onSubmit{
                        isDescptionFocused = true
                        withAnimation{
                            description += "\n"
                        }
                    }
            }
            Section("Collection items"){
                HStack{
                    NavigationButtomSheet {
                        SuraList(selection: $suras)
                    } label: {
                        Text("suras")
                            .badge(suras.count)
                    }
                    NavigationButtomSheet {
                        AyaList(selection: $ayas)
                    } label: {
                        Text("ayas")
                            .badge(ayas.count)
                    }
                    NavigationButtomSheet {
                        SofhaList(selection: $sofhas)
                    } label: {
                        Text("sofhas")
                            .badge(sofhas.count)
                    }
                    NavigationButtomSheet {
                        HizbList(selection: $hizbs)
                    } label: {
                        Text("Hizbs")
                            .badge(hizbs.count)
                    }
                }
                .buttonStyle(.borderedProminent)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .lineLimit(1)
            }
        }
        .toolbar{
            ToolbarItem(placement: .confirmationAction, content: {
                Button(action: {
                    save()
                }, label: {
                    HStack{
                        Text("Done")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                })
                .disabled(name.isEmpty)
            })
            ToolbarItem(placement: .destructiveAction, content: {
                CloseButton()
            })
            ToolbarItemGroup(placement: .keyboard, content: {
                Button("Done"){
                    withAnimation{
                        hideKeyboard()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            })
        }
        .onAppear{
            if let kollection = kollection {
                name = kollection.name
                description = kollection.description
                color = kollection.color
                suras = Set(kollection.suras)
                ayas = Set(kollection.ayas)
                sofhas = Set(kollection.sofhas)
            }
        }
        
        .navigationTitle( kollection?.name ?? "New collection")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func save(){
        Task {
            withAnimation{
                dismiss()
                if kollection != nil {
                    kollection!.name = name
                    kollection!.color = color
                    kollection!.description = description
                    kollection!.suras = Array(suras)
                    kollection!.ayas = Array(ayas)
                    kollection!.sofhas = Array(sofhas)
                    kollection!.hizbs = Array(hizbs)
                } else {
                    kModel.add(name: name, description: description, ayas: ayas, suras: suras, hizbs: hizbs, sofhas: sofhas, color: color)
                }
            }
        }
    }
}

struct KollectionEditor_Previews: PreviewProvider {
    static var previews: some View {
        KollectionEditor()
            .environmentObject(KollectionProvider())
    }
}
