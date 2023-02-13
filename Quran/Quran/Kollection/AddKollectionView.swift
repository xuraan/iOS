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
    ) var kollections: FetchedResults<Kollection>
    
    init(kollection: Binding<Kollection?>){
        _kollection = kollection
    }
    
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
                Text("Collection name")
            } footer: {
                Text("Une collection existe avec ce nom (\(name))")
                    .foregroundColor(.red.opacity((kollections.first{ $0.id == name } != nil) ? 1 : 0))
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
                NavigationLink{
                    SelectableSuraList(suras: Array(suras), selection: $surasIDs)
                        .toolbar{
                            EditButton()
                        }
                }label: {
                    Text("suras")
                        .badge(surasIDs.count)
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .cancellationAction, content: {
                Button(action: {
                    withAnimation{
                        self.dismiss()
                        let newKollection = Kollection(context: viewContext)
                        newKollection.colorHex = color.hex
                        newKollection.id = name
                        print(color.hex)
                    }
                }, label: {
                    HStack{
                        Text("Done")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                })
                .disabled(name.isEmpty || kollections.first{ $0.id == name } != nil)
            })
        }
        .onAppear{
            
        }
    }
}

struct AddKollectionView_Previews: PreviewProvider {
    static var previews: some View {
        AddKollectionView(kollection: .constant(nil))
    }
}
