//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Brandon Barros on 5/5/20.
//  Copyright © 2020 Brandon Barros. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var compMove = Int.random(in: 0...2)
    @State private var strategyWin = Bool.random()
    @State private var rounds = 0
    @State private var wins = 0
    @State private var moves = ["Rock", "Paper", "Scissors"]
    @State private var pick = 0
    @State private var showResult = false
    
    var gameOver: Bool {
        return rounds == 10
    }
    
    //Figure out who won
    var won: Bool {
        var w = false
        
        //Cant win if pick was the same
        if (pick == compMove) {
            return false
        }
        
        //check winning combos
        if (pick == 0 && compMove == 2) {
            w = true
        } else if (pick == 1 && compMove == 0) {
            w = true
        } else if (pick == 2 && compMove == 1) {
            w = true
        }
        
        //change if they were suppose to lose
        if (!strategyWin) {
            w = !w
        }
        
        return w
        
    }
    
    
    var body: some View {
        ZStack {
            
            //Background
            LinearGradient(gradient: Gradient(colors: [.gray, .orange]), startPoint: .bottom, endPoint: .top)
            .edgesIgnoringSafeArea(.all)
            
            //Text
            VStack(spacing: 40) {
                
                //Title
                Text("Rock Paper Scissors")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                //Opponent Pick
                VStack {
                    Text("Your Opponent has picked:")
                    Text(moves[compMove])
                        .font(.title)
                }
                
                //Strategy
                VStack {
                    Text("Your goal is to: ")
                    Text(self.strategyWin ? "Win": "Lose")
                        .font(.title)
                }
                
                //User Pick
                VStack(spacing: 20) {
                    Text("What Will you pick?")
                    VStack(spacing: 20) {
                        ForEach(0..<moves.count) { num in
                            Button(action: {
                                self.pick = num
                                if (self.won) {
                                    self.wins += 1
                                }
                                self.rounds += 1
                                self.showResult = true
                                
                            }) {
                                Text("\(self.moves[num])")
                            }
                            
                        }
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                }
                
                Spacer()
                
                //Score
                VStack {
                    Text("Current Score: \(wins) out of \(rounds)")
                }
            }
        }
        .alert(isPresented: $showResult) {
            Alert(title: Text(won ? "Correct!": "Wrong Choice"), message: Text(gameOver ? "Good Job! You're final score is \(wins) out of 10": "Click to continue"), dismissButton: .default(Text(gameOver ? "New Game": "Continue")) {
                if (self.gameOver) {
                    self.reset()
                } else {
                    self.nextRound()
                }
            })
        }
    }
    
    func nextRound() {
        compMove = Int.random(in: 0...2)
        strategyWin = Bool.random()
    }
    
    func reset() {
        rounds = 0
        wins = 0
        
        compMove = Int.random(in: 0...2)
        strategyWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
