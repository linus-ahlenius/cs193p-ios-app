import SwiftUI

struct ContentView: View {
    static let transportContent = ["🚗", "🚕", "🏍", "🚁", "🛩", "🚀", "🛶", "⛵️", "🚙", "🚌", "🚎",
                                   "🏎", "🚜", "🚛", "🚚", "🛴", "🛵", "🚲", "🚑", "🚒", "🚓"]
    static let animalContent = ["🐶", "🐑", "🐈‍⬛", "🐭", "🐸", "🐷", "🐮", "🐵", "🐥", "🦄", "🪱", "🦀",
                                "🐳", "🦢", "🦒", "🦎", "🐠", "🦋"]
    static let malinsContent = ["🥐", "🍫", "🏝", "📱", "🐱", "🌻", "🌈", "🎁", "❤️", "🇸🇪"]
    @State var currentTheme: [String]

    @State var emojiCount = 20
    var body: some View {
        VStack {
            Text("Memorize").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(currentTheme[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2 / 3, contentMode: .fit)
                    }
                }
            }.foregroundColor(.red)
            HStack {
                Spacer()
                createThemeButton(
                        theme: ContentView.transportContent,
                        image: Image(systemName: "car"),
                        description: "Vehicles"
                )
                Spacer()
                createThemeButton(
                        theme: ContentView.animalContent,
                        image: Image(systemName: "pawprint"),
                        description: "Animals")
                Spacer()
                createThemeButton(theme: ContentView.malinsContent,
                        image: Image(systemName: "eyes"),
                        description: "Malin")
                Spacer()
            }.font(.largeTitle)
        }.padding(.horizontal)
    }

    func clampEmojiCount() {
        if currentTheme.count < emojiCount {
            emojiCount = currentTheme.count
        }
    }

    func createThemeButton(theme: [String], image: Image, description: String) -> some View {
        let shuffledTheme = theme.shuffled()
        return Button(action: {
            currentTheme = shuffledTheme
            clampEmojiCount()
        }) {
            VStack {
                image
                Text(description).font(.caption)
            }
        }
    }
}


struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }.onTapGesture { isFaceUp.toggle() }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(currentTheme: ContentView.transportContent)
                    .preferredColorScheme(.dark)
                    .previewInterfaceOrientation(.landscapeLeft)
            ContentView(currentTheme: ContentView.transportContent)
                    .preferredColorScheme(.light)
        }
    }
}
