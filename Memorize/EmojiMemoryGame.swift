import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private let themeSelector = ThemeSelector()

    @Published private var game: MemoryGame<String> = MemoryGame<String>()
    @Published private(set) var theme: Theme

    func createNewMemoryGame() {
        theme = themeSelector.getRandomTheme()
        game = MemoryGame<String>(numberOfPairsOfCards: theme.numPairsInGame) {
            pairIndex in theme.content[pairIndex]
        }
    }

    init() {
        theme = themeSelector.getRandomTheme()
        game = MemoryGame<String>(numberOfPairsOfCards: theme.numPairsInGame) {
            index in theme.content[index]
        }
    }

    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }

    // MARK: - Intents

    func choose(_ card: MemoryGame<String>.Card) {
        game.choose(card)
    }

    func newGame() {
        createNewMemoryGame()
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
