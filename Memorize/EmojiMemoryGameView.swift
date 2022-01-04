import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame

    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2 / 3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }

        }.foregroundColor(.red)
            .padding(.horizontal)
    }
}


struct CardView: View {
    private let card: EmojiMemoryGame.Card

    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }

    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(radians: -CGFloat.pi / 2), endAngle: Angle(radians: 0.0))
                        .padding(4)
                        .opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        })
    }

    private func font(in size: CGSize) -> Font {
        .system(size: min(size.height, size.width) * DrawingConstants.fontScale)
    }

    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            EmojiMemoryGameView(game: game)
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.landscapeLeft)
            EmojiMemoryGameView(game: game)
                .preferredColorScheme(.light)
        }
    }
}
