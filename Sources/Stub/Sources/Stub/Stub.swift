import Foundation
import DouShouQiModel

@available(iOS 15, *)
@available(macOS 12, *)
public struct Stub {
    
    public static var gamesRecorded: [GameResutlStub] = loadGamesResults()

    public static var gamesLeaderboard: [GameStatStub] = loadGamesOccurence()
    
    static func loadGamesResults() -> [GameResutlStub] {
        var games: [GameResutlStub] = Array()
        
        games.append(GameResutlStub(
            player1: RandomPlayer(withName: "Illidan", andId: .player1)!,
            player2: RandomPlayer(withName: "Sylvanas", andId: .player2)!,
            gameResult: .winner(winner: .player1, reason: .denReached)))
        
        games.append(GameResutlStub(
            player1: RandomPlayer(withName: "Illidan", andId: .player1)!,
            player2: RandomPlayer(withName: "Irion", andId: .player2)!,
            gameResult: .winner(winner: .player2, reason: .noMorePieces)))
        
        games.append(GameResutlStub(
            player1: RandomPlayer(withName: "Sylvanas", andId: .player1)!,
            player2: RandomPlayer(withName: "Irion", andId: .player2)!,
            gameResult: .winner(winner: .player2, reason: .noMovesLeft)))
        
        games.append(GameResutlStub(
            player1: RandomPlayer(withName: "Sylvanas", andId: .player1)!,
            player2: RandomPlayer(withName: "Irion", andId: .player2)!,
            gameResult: .winner(winner: .player1, reason: .noMovesLeft)))
        
        games.append(GameResutlStub(
            player1: RandomPlayer(withName: "Sylvanas", andId: .player1)!,
            player2: RandomPlayer(withName: "Irion", andId: .player2)!,
            gameResult: .winner(winner: .player1, reason: .noMovesLeft)))
        
        
        return games
    }
    
    static func loadGamesOccurence() -> [GameStatStub] {
        var games: [GameStatStub] = Array()
        
        var gameStats1 = GameStatStub(player: RandomPlayer(withName: "Illidan", andId: .player1)!)
        var gameStats2 = GameStatStub(player: RandomPlayer(withName: "Sylvanas", andId: .player1)!)
        var gameStats3 = GameStatStub(player: RandomPlayer(withName: "Irion", andId: .player1)!)

        gameStats1.win()
        gameStats1.win()
        gameStats1.win()
        gameStats1.lose()
        gameStats1.lose()
        
        gameStats2.win()
        gameStats2.win()
        gameStats2.lose()
        gameStats2.lose()
        
        gameStats3.win()
        gameStats3.lose()
        gameStats3.lose()
        
        games.append(gameStats1)
        games.append(gameStats2)
        games.append(gameStats3)

        return games
    }
}
