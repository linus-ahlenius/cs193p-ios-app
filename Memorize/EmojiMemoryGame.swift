import SwiftUI


class EmojiMemoryGame : ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static let emojis = ["🚗", "🚕", "🏍", "🚁", "🛩", "🚀", "🛶", "⛵️", "🚙", "🚌", "🚎",
                         "🏎", "🚜", "🚛", "🚚", "🛴", "🛵", "🚲", "🚑", "🚒", "🚓"]

    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            emojis[pairIndex]
        }
    }

    @Published private var model = createMemoryGame()

    var cards: [Card] {
        model.cards
    }

    // MARK: - Intents

    func choose(_ card: Card){
        model.choose(card)
    }
}
