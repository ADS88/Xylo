import UIKit

struct GameModeOption {
    let title: String
    let description: String
    let color: UIColor
    let imageName: String
    let notes: [String]
    let gameMode: GameMode
    
    init(title: String, description: String, color: UIColor, imageName: String, notes: [String] = ["lowC", "D", "E", "F", "G", "A", "B", "highC"], gameMode: GameMode) {
        self.title = title
        self.description = description
        self.color = color
        self.imageName = imageName
        self.notes = notes
        self.gameMode = gameMode
    }
}
    
