//
//  ContentView.swift
//  card-game
//
//  Created by Jacob Summerville on 7/30/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var playerCard  = "card2"
    @State var cpuCard     = "card2"
    @State var playerScore = 0
    @State var cpuScore    = 0
    @State var winnerStatement = "Let's Play!"
    
    var body: some View {
        ZStack {
            Image("background")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("logo")
                Spacer()
                
                HStack {
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                
                Spacer()
                
                Button(action: {
                    let playerNum = Int.random(in: 2...14)
                    let cpuNum = Int.random(in: 2...14)
                    
                    if playerNum > cpuNum {
                        playerScore += 1
                        winnerStatement = "Player Won!"
                    } else if cpuNum > playerNum {
                        cpuScore += 1
                        winnerStatement = "CPU Won!"
                    } else {
                        playerScore += 1
                        cpuScore += 1
                        winnerStatement = "Tie!"
                    }
                    
                    playerCard = "card" + String(playerNum)
                    cpuCard = "card" + String(cpuNum)
                }, label: {
                    Image("dealbutton")
                })

                
                Spacer()
                
                Text(winnerStatement)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 20.0)
                
                HStack {
                    Spacer()
                    VStack {
                        Text("Player")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 10.0)
                        Text(String(playerScore))
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    VStack {
                        Text("CPU")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 10.0)
                        Text(String(cpuScore))
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
