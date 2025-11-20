//
//  ContentView.swift
//  ClassVsStruct
//
//  Created by Manoj Reddy on 11/20/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Section("Class - Reference Type") {
                DogClassIsReferenceType()
            }
            Section("Struct - Value Type") {
                CarStructIsValueType()
            }
            
        }
        .padding()
        .onAppear() {
        }
    }
}

#Preview {
    ContentView()
}
