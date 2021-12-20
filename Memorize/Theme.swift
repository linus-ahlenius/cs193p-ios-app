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
        themes.randomElement()!
    }

    init() {
        themes = []
        themes.append(Theme(
                name: "vehicles",
                content: ["🚗", "🚕", "🏍", "🚁", "🛩", "🚀", "🛶", "⛵️", "🚙", "🚌", "🚎", "🏎",
                          "🚜", "🚛", "🚚", "🛴", "🛵", "🚲", "🚑", "🚒", "🚓"],
                numPairsInGame: 21,
                appearance: "red")
        )
    }
}

