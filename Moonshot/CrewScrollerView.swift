//
//  CrewScrollerView.swift
//  Moonshot
//
//  Created by Sunny on 2024/7/31.
//

import SwiftUI

struct CrewScrollerView: View {
    struct CrewMember2 {
        let role: String
        let astronaut: Astronaut
    }
    
    let crews: [CrewMember2]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crews, id:\.role){ crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.crews = mission.crew.map{ member in
            if let astronaut = astronauts[member.name] {
                return CrewMember2(role: member.role, astronaut: astronaut)
            }else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return CrewScrollerView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
