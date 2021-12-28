import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private let themeSelector = ThemeSelector()

    private var game: MemoryGame<String> = MemoryGame<String>()
    @Published private(set) var theme: Theme
    @Published private(set) var cardViewModels: [CardViewModel] = []

    func createNewMemoryGame() {
        theme = themeSelector.getRandomTheme()
        game = MemoryGame<String>(numberOfPairsOfCards: theme.numPairsInGame) {
            pairIndex in theme.content[pairIndex]
        }
        updateCardViewState()
    }

    init() {
        theme = themeSelector.getRandomTheme()
        game = MemoryGame<String>(numberOfPairsOfCards: theme.numPairsInGame) {
            index in theme.content[index]
        }
        updateCardViewState()
    }

    var cards: [MemoryGame<String>.Card] {
        game.cards
    }

    // MARK: - Intents

    func choose(_ card: EmojiMemoryGame.CardViewModel) {
        let card = game.cards.first(where: { $0.id == card.id })!
        game.choose(card)
        updateCardViewState()
    }

    func newGame() {
        createNewMemoryGame()
    }

    private func updateCardViewState() {
        cardViewModels = []
        for card in cards {
            cardViewModels.append(CardViewModel(card))
        }
    }

    struct CardViewModel : Identifiable {
        var isFaceUp: Bool = false
        var content: String
        var id: ObjectIdentifier

        init(_ card: Card) {
            isFaceUp = card.isFaceUp
            content = card.content
            id = card.id
        }
    }
}

// Workaround, Color("black) and similar is not working on my machine for some reason.
extension Color {
    init(color: String) {
        switch(color) {
        case "black": self.init(.black)
        case "blue": self.init(.blue)
        case "brown": self.init(.brown)
        case "cyan": self.init(.cyan)
        case "green:": self.init(.green)
        case "grey": self.init(.gray)
        case "magenta": self.init(.magenta)
        case "orange": self.init(.orange)
        case "purple": self.init(.purple)
        case "red": self.init(.red)
        case "yellow": self.init(.yellow)
        default: self.init(.black)
        }
    }
}
