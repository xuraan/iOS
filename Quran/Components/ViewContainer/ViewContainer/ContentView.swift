//
//  ContentView.swift
//  ViewContainer
//
//  Created by Samba Diawara on 2023-01-30.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1
    var body: some View {
        LeaningTower(selection: $selection){
            Text("Oumar")
                .detail(id: "yu", content: {
                    VStack{
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                    }
                })
            Text("samba")
                .detail(id: 2, content: {
                    VStack{
                        Text("gjlh f4wv urwGFBJR FRWhff")
                        Text("gjlhb rwGFBJR FRWhff")
                        Text("gjlhbvejhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbveourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                    }
                })
            Text("samba")
                .detail(id: 3, content: {
                    VStack{
                        Text("gjlh f4wv urwGFBJR FRWhff")
                        Text("gjlhb rwGFBJR FRWhff")
                        Text("gjlhbvejhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbveourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                        Text("gjlhbvejhwrf rwfhourwGFBJR FRWhff")
                    }
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
