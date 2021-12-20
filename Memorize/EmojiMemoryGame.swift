import SwiftUI


class EmojiMemoryGame : ObservableObject {
    private let themeSelector = ThemeSelector()

    func createNewMemoryGame() {
        theme = themeSelector.getRandomTheme()
        game = MemoryGame<String>(numberOfPairsOfCards: 8) {
            pairIndex in theme.content[pairIndex]
        }
    }

    init() {
        theme = themeSelector.getRandomTheme()
        game = MemoryGame<String>(numberOfPairsOfCards: theme.numPairsInGame) {
            index in theme.content[index]
        }
    }

    @Published private var game: MemoryGame<String> = MemoryGame<String>()
    @Published private var theme: Theme

    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }

    // MARK: - Intents

    func choose(_ card: MemoryGame<String>.Card){
        game.choose(card)
    }
}
