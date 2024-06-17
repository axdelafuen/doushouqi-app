import Foundation
import DouShouQiModel

public struct GameStatStub: Identifiable {
    public let id: UUID
    public let player: Player
    public var wins: Int
    public var lost: Int
    
    init(player: Player, wins: Int = 0, lost: Int = 0) {
        self.id = UUID()
        self.player = player
        self.wins = wins
        self.lost = lost
    }
    
    public mutating func win() {
        wins = wins + 1
    }
    
    public mutating func lose() {
        lost = lost + 1
    }
}
