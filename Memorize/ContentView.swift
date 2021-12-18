import SwiftUI

struct ContentView: View {
    static let transportContent = ["🚗", "🚕", "🏍", "🚁", "🛩", "🚀", "🛶", "⛵️", "🚙", "🚌", "🚎", "🏎", "🚜", "🚛", "🚚", "🛴", "🛵", "🚲", "🚑", "🚒", "🚓"]
    static let animalContent = ["🐶", "🐑", "🐈‍⬛", "🐭", "🐸", "🐷", "🐮", "🐵", "🐥", "🦄", "🪱", "🦀", "🐳", "🦢", "🦒", "🦎", "🐠", "🦋"]
    static let malinsContent = ["🥐", "🍫", "🏝", "📱", "🐱", "🌻", "🌈", "🎁", "❤️", "🇸🇪"]
    @State var currentTheme: [String]

    @State var emojiCount = 7
    var body: some View {
        VStack {
            Text("Memorize").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(currentTheme[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            HStack {
                Spacer()
                Button(action: { currentTheme = ContentView.transportContent}){ Image(systemName: "car") }
                Spacer()
                Button(action: { currentTheme = ContentView.animalContent }){ Image(systemName: "pawprint") }
                Spacer()
                Button(action: { currentTheme = ContentView.malinsContent }){ Image(systemName: "eyes") }
                Spacer()
            }.font(.largeTitle)
        }
        .padding(.horizontal)
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
        }
        .onTapGesture {isFaceUp.toggle()}
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(currentTheme: ContentView.malinsContent)
                .preferredColorScheme(.dark)
.previewInterfaceOrientation(.landscapeLeft)
            ContentView(currentTheme: ContentView.malinsContent)
                .preferredColorScheme(.light)
        }
    }
}
