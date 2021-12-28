import Foundation

class MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] = []
    private var score: Int = 0

    private var firstChosenCard: Card?
    private var secondChosenCard: Card?

    func choose(_ card: Card) {
        if !isValidChoice(card) {
            return
        }

        card.isFaceUp = true

        if firstChosenCard == nil {
            firstChosenCard = card
            updateFaceUpState()
            return
        } else {
            secondChosenCard = card

            updateFaceUpState()
            updateMatchFields()
            updateScore()
            updateShownCards()
            unsetChosenCards()
        }
    }

    private func isValidChoice(_ card: Card) -> Bool {
        !card.isFaceUp && !card.isMatched
    }

    private func updateMatchFields() {
        if firstChosenCard!.content == secondChosenCard!.content {
            firstChosenCard!.isMatched = true
            secondChosenCard!.isMatched = true
        }
    }

    private func updateFaceUpState() {
        for card in cards{
            card.isFaceUp = card.isMatched
        }

        if let firstCard = firstChosenCard {
            firstCard.isFaceUp = true
        }
        if let secondCard = secondChosenCard {
            secondCard.isFaceUp = true
        }
    }

    private func updateScore() {
        updateScoreFor(firstChosenCard!)
        updateScoreFor(secondChosenCard!)
    }

    private func updateScoreFor(_ card: Card) {
        if card.isMatched {
            score += 1
        } else if card.hasBeenShown {
            score -= 1
        }
    }

    private func updateShownCards() {
        firstChosenCard!.hasBeenShown = true
        secondChosenCard!.hasBeenShown = true
    }

    private func unsetChosenCards() {
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
