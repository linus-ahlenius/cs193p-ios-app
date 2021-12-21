import Foundation

struct Theme {
    let name: String
    let content: [String]
    let numPairsInGame: Int
    let appearance: String
}

class ThemeSelector {
    var themes: [Theme]

    func getRandomTheme() -> Theme {
        let selected = themes.randomElement()!
        return sanitized(theme: selected)
    }

    private func sanitized(theme: Theme) -> Theme {
        let numPairs = min(theme.numPairsInGame, theme.content.count)
        return Theme(name: theme.name, content: theme.content, numPairsInGame: numPairs, appearance: theme.appearance)
    }

    init() {
        themes = []
        themes.append(Theme(
                name: "vehicles",
                content: ["🚗", "🚕", "🏍", "🚁", "🛩", "🚀", "🛶", "⛵️", "🚙", "🚌", "🚎", "🏎",
                          "🚜", "🚛", "🚚", "🛴", "🛵", "🚲", "🚑", "🚒", "🚓"],
                numPairsInGame: 25, // numPairsInGame is too large
                appearance: "red")
        )
    }
}

