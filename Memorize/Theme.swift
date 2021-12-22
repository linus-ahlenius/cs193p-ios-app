import Foundation

struct Theme {
    let name: String
    let content: [String]
    let numPairsInGame: Int
    let color: String
}

class ThemeSelector {
    var themes: [Theme]

    func getRandomTheme() -> Theme {
        let selected = themes.randomElement()!
        return sanitized(theme: selected)
    }

    private func sanitized(theme: Theme) -> Theme {
        let numPairs = min(theme.numPairsInGame, theme.content.count)
        return Theme(name: theme.name, content: theme.content, numPairsInGame: numPairs, color: theme.color)
    }

    init() {
        themes = []
        themes.append(Theme(
                name: "Vehicles",
                content: ["🚗", "🚕", "🏍", "🚁", "🛩", "🚀", "🛶", "⛵️", "🚙", "🚌", "🚎", "🏎",
                          "🚜", "🚛", "🚚", "🛴", "🛵", "🚲", "🚑", "🚒", "🚓"],
                numPairsInGame: 25, // numPairsInGame is too large
                color: "red")
        )
        themes.append(Theme(
                name: "Animals",
                content: ["🐶", "🐑", "🐈‍⬛", "🐭", "🐸", "🐷", "🐮", "🐵", "🐥", "🦄", "🪱", "🦀", "🐳", "🦢", "🦒", "🦎", "🐠", "🦋"],
                numPairsInGame: 16,
                color: "green")
        )
        themes.append(Theme(
                name: "Malin",
                content: ["🥐", "🍫", "🏝", "📱", "🐱", "🌻", "🌈", "🎁", "❤️", "🇸🇪"],
                numPairsInGame: 10,
                color: "blue")
        )

    }
}

