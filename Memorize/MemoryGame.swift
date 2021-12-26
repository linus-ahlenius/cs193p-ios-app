import Foundation

class MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] = []

    private var firstChosenCard: Card?
    private var secondChosenCard: Card?

    func choose(_ card: Card) {
        if !isValidChoice(card) {
            return
        }

        card.isFaceUp = true

        if firstChosenCard == nil {
            firstChosenCard = card
            return
        } else { // TODO: Remove else since early return?
            secondChosenCard = card

            update_match_fields()
            update_score()
            update_shown_cards()
            unset_chosen_cards()
        }
    }

    private func isValidChoice(_ card: Card) -> Bool {
        !card.isFaceUp && !card.isMatched
    }

    private func update_match_fields() {
        if firstChosenCard!.content == secondChosenCard!.content {
            firstChosenCard!.isMatched = true
            secondChosenCard!.isMatched = true
        }
    }

    private func update_score() {
        // TODO: Implement later
    }

    private func update_shown_cards() {
        firstChosenCard!.hasBeenShown = true
        secondChosenCard!.hasBeenShown = true
    }

    private func unset_chosen_cards() {
        firstChosenCard = nil
        secondChosenCard = nil
    }

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }

    init() {
    }

    class Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenShown: Bool = false
        var content: CardContent

        init(content: CardContent) {
            self.content = content
        }
    }
}
