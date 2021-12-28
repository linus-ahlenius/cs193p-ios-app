import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] = []

    private var indexOfFirstChosenCard: Int?
    private var indexOfSecondChosenCard: Int?

    mutating func choose(_ card: Card) {
        let chosenIndex = getIndex(of: card)

        if indexOfFirstChosenCard != nil {
            if !isValidChoice(card) {
                return
            }
            indexOfSecondChosenCard = chosenIndex

            updateFaceUpState()
            updateMatchFields()
            unsetChosenCards()
        } else {
            indexOfFirstChosenCard = chosenIndex
            updateFaceUpState()
        }
    }

    private func getIndex(of card: Card) -> Int? {
        cards.firstIndex(where: { $0.id == card.id })
    }

    private func isValidChoice(_ card: Card) -> Bool {
        !card.isFaceUp && !card.isMatched
    }

    private mutating func updateFaceUpState() {
        for index in cards.indices {
            cards[index].isFaceUp = cards[index].isMatched
        }

        if let secondIndex = indexOfFirstChosenCard {
            cards[secondIndex].isFaceUp = true
        }
        if let firstIndex = indexOfSecondChosenCard {
            cards[firstIndex].isFaceUp = true
        }
    }

    private mutating func updateMatchFields() {
        if cards[indexOfFirstChosenCard!].content == cards[indexOfSecondChosenCard!].content {
            cards[indexOfFirstChosenCard!].isMatched = true
            cards[indexOfSecondChosenCard!].isMatched = true
        }
    }

    private mutating func unsetChosenCards() {
        indexOfFirstChosenCard = nil
        indexOfSecondChosenCard = nil
    }

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }

    init() {}

    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent

        var id: Int
    }
}
