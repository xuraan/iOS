//
//  AddKollectionView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-11.
//

import SwiftUI

struct AddKollectionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var viewContext
    @Binding var kollection: Kollection?
    @State var name: String = ""
    @State var description: String = ""
    @State var color: Color = .gray
    @State var surasIDs = Set<Sura.ID>()
    @State var ayasIDs = Set<Aya.ID>()
    @State var sofhasIDs = Set<Sofha.ID>()
    @FocusState var isDescptionFocused: Bool

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)]
    ) var suras: FetchedResults<Sura>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)]
    ) var sofhas: FetchedResults<Sofha>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)]
    ) var ayas: FetchedResults<Aya>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)]
    ) var kollections: FetchedResults<Kollection>
    
    init(kollection: Binding<Kollection?> = .constant(nil)){
        _kollection = kollection
    }
    var title: LocalizedStringKey { .init(kollection.isNil ? "New collection" : kollection!.id) }
    var body: some View {
        List{
            Section{
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
            } header: {
                Text("collection name")
            } footer: {
                Text(inValideText)
                    .foregroundColor(.red)
            }
            Section("description"){
                TextField("Description", text: $description, axis: .vertical)
                    .lineLimit(5...)
            }
            Section("collection items"){
                Group{
                    NavigationSheet(closeButtonTitle: "Done"){
                        AyaList(ayas: Array(ayas), selection: $ayasIDs)
                            .environment(\.editMode, .constant(.active))
                    } label: {
                        Text("ayas")
                            .badge(ayasIDs.count)
                    }
                    NavigationSheet(closeButtonTitle: "Done"){
                        SofhaList(sofhas: Array(sofhas), selection: $sofhasIDs)
                            .environment(\.editMode, .constant(.active))
                    } label: {
                        Text("sofhas")
                            .badge(sofhasIDs.count)
                    }
                    NavigationSheet(closeButtonTitle: "Done"){
                        SuraList(suras: Array(suras), selection: $surasIDs)
                            .environment(\.editMode, .constant(.active))
                    } label: {
                        Text("suras")
                            .badge(surasIDs.count)
                    }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .buttonStyle(.bordered)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .font(.title3)
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    save()
                }, label: {
                    HStack{
                        Text("Done")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                })
                .disabled(!canSave)
            })
        }
        .onAppear{
            if let kollection = kollection {
                name = kollection.id
                description = kollection.descript
                ayasIDs = Set(kollection.ayas.ayas.map{ $0.id })
                surasIDs = Set(kollection.suras.suras.map{ $0.id })
                sofhasIDs = Set(kollection.sofhas.sofhas.map{ $0.id })
            }
        }
        .navigationTitle(title)
    }
    
    private var saveKollection: Kollection {
        guard let kollection = kollection else {
            return Kollection(context: viewContext)
        }
        return kollection
    }
    private func save(){
        withAnimation{
            dismiss()
            let kollection = saveKollection
            kollection.colorHex = color.hex
            kollection.id = name
            kollection.descript = description
            kollection.suras = NSSet(array: suras.filter{ surasIDs.contains($0.id) })
            kollection.sofhas = NSSet(array: sofhas.filter{ sofhasIDs.contains($0.id) })
            kollection.ayas = NSSet(array: ayas.filter{ ayasIDs.contains($0.id) })
        }
    }
    private var inValideNames: [String] {
        kollections.map{ $0.id }+Kollection.immutableIDs
    }
    private var canSave: Bool{
        !(name.isEmpty || self.inValideNames.contains(name) && name != kollection?.id )
    }
    private var inValideText: String {
        if Kollection.immutableIDs.contains(name) {
            return "Ce mot (\(name)) est reservé "
        }else if inValideNames.contains(name) {
            return "Une collection existe avec ce nom (\(name))"
        } 
        return ""
    }
}

struct AddKollectionView_Previews: PreviewProvider {
    static var previews: some View {
        AddKollectionView(kollection: .constant(nil))
    }
}
