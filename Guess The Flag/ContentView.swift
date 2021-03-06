//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Andrew Chen on 2021-05-03.
//

import SwiftUI
struct FlagImage: ViewModifier {
    func body (content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule()
                        .stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}
extension View {
    func imageStyle() -> some View {
        self.modifier(FlagImage())
    }
}
struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var alertShowing = false
    @State var selectedAnswer = false
    @State var scoreTitle = ""
    @State var userScore = 0
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue,.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
            ForEach(0..<3){ number in
                Button(action:{
                    self.flagTapped(number)
                }){
                    Image(self.countries[number])
                        .renderingMode(.original)
                    }
                .imageStyle()
                
                }
            Text("Score: \(userScore)")
                .foregroundColor(.white)
            Spacer()
            }
            .alert(isPresented: $alertShowing){
                Alert(title: Text(scoreTitle), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("Continue")){
                    self.askQuestion()
                })
            }
        }
    }
    func flagTapped (_ number: Int){
        if (number == correctAnswer){
            scoreTitle = "Correct"
            userScore += 1
        }
        else{
            scoreTitle = "Incorrect, that's the flag of \(countries[correctAnswer])"
        }
        alertShowing = true;
    }
    func askQuestion (){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
