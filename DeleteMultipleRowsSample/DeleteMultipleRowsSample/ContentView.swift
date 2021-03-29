//
//  ContentView.swift
//  DeleteMultipleRowsSample
//
//  Created by home on 2021/03/29.
//

import SwiftUI

struct ContentView: View {
    struct Region: Identifiable {
        let id = UUID()
        let name: String
    }
    
    @State var regions = [
        Region(name: "北海道"),
        Region(name: "東北"),
        Region(name: "関東"),
        Region(name: "中部"),
        Region(name: "近畿"),
        Region(name: "中国"),
        Region(name: "四国"),
        Region(name: "九州")
    ]
    
    @State var editMode: EditMode = .inactive
    @State var multiSelection = Set<UUID>()
    
    var body: some View {
        NavigationView {
            VStack {
                List(selection: $multiSelection) {
                        if editMode == .active {
                            Text("選択した項目を削除")
                                .foregroundColor(Color.red)
                                .onTapGesture {
                                    deleteItems()
                                }
                        }
                    
                        ForEach(regions) { region in
                            Text(region.name)
                        }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("地方")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{ EditButton() }
                .environment(\.editMode, self.$editMode)
            }
        }
    }
    
    func deleteItems() {
        for id in multiSelection {
            if let index = regions.lastIndex(where: { $0.id == id }) {
                regions.remove(at: index)
            }
        }
        multiSelection = Set<UUID>()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
