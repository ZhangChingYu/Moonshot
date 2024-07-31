//
//  ContentView.swift
//  Moonshot
//
//  Created by Sunny on 2024/7/30.
//

import SwiftUI

struct ContentView: View {
    @State private var displayToggle = false
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if displayToggle {
                    ListView(missions: missions, astronauts: astronauts)
                }else {
                    GridView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                Button {
                    displayToggle.toggle()
                } label: {
                    Image(systemName: displayToggle ?  "rectangle.split.3x3.fill":"rectangle.grid.1x2.fill")
                }
                .foregroundStyle(.white)
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
