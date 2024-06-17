import Foundation
import DouShouQiModel


public struct GameResutlStub: Identifiable {
    public let id: UUID
    public let player1: Player
    public let player2: Player
    public let gameResult: Result
    
    init(player1: Player, player2: Player, gameResult: Result) {
        self.id = UUID()
        self.player1 = player1
        self.player2 = player2
        self.gameResult = gameResult
    }
}
