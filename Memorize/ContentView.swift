import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack{
            topMenu
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cardViewModels) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                    }
                }
            }
        }
        .foregroundColor(Color(color: viewModel.theme.color))
        .padding(.horizontal)
    }


    var topMenu: some View {
        HStack {
            Text(viewModel.theme.name).font(.largeTitle)
            Button { viewModel.newGame() } label: {
                Image(systemName: "arrow.counterclockwise").font(.largeTitle)
            }
        }
    }
}


struct CardView: View {
    let card: EmojiMemoryGame.CardViewModel

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            ContentView(viewModel: game)
                .preferredColorScheme(.dark)
.previewInterfaceOrientation(.landscapeLeft)
            ContentView(viewModel: game)
                .preferredColorScheme(.light)
        }
    }
}
