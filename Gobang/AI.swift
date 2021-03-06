//
//  AI.swift
//  Gobang
//
//  Created by ZZC on 4/15/16.
//  Copyright © 2016 Zhicong Zang. All rights reserved.
//

import Foundation

class AI {
    let chess: ChessType
    var boardArray: BoardArray2D
    var total = 0
    var cut = 0
    
    init(chess: ChessType, boardArray: BoardArray2D) {
        self.chess = chess
        self.boardArray = boardArray
    }
    
    func getBestResult(deep deep: Int) -> ChessPosition {
        total = 0
        cut = 0
        var bestPositions = [ChessPosition]()
        var bestScore = Int.min
        let positions = genPositions()
        positions.forEach { (position) in
            boardArray[position.column, position.row] = chess.rawValue
            let score = humanMoveScore(deep: deep - 1, alpha: bestScore > Int.min ? bestScore : Int.min, beta: Int.max)
            if score == bestScore {
                bestPositions.append(position)
            } else if score > bestScore {
                bestScore = score
                bestPositions = [position]
            }
            boardArray[position.column, position.row] = ChessType.Empty.rawValue
        }
        print("Total: \(total)")
        print("Cut: \(cut)")
        return bestPositions.first!
    }
    
    // Min
    func humanMoveScore(deep deep: Int, alpha: Int, beta: Int) -> Int {
        total += 1
        //let scores = calculateBoardScores()
        //let score = scores[chess]! - scores[chess.oppoType()]!
        let score = test()
        if deep <= 0 || score >= ScoreType.Win.rawValue {
            return score
        }
        var bestScore = Int.max
        let positions = generatorPositions()
        positions.forEach { (position) in
            boardArray[position.column, position.row] = chess.oppoType().rawValue
            let score = aiMoveScore(deep: deep - 1, alpha: bestScore < alpha ? bestScore : alpha, beta: beta)
            boardArray[position.column, position.row] = ChessType.Empty.rawValue
            if score < bestScore {
                bestScore = score
            }
            if score < beta {
                cut += 1
                return
            }
        }
        return bestScore
        
        
    }
    
    func test() -> Int {
        var score = Int(arc4random() % 10)
        for i in 0...80 {
            score += Int(arc4random() % 10)
        }
        return score
    }
    
    // Max
    func aiMoveScore(deep deep: Int, alpha: Int, beta: Int) -> Int {
        total += 1
        //let scores = calculateBoardScores()
        let score = test()
        //let score = scores[chess]! - scores[chess.oppoType()]!
        if deep <= 0 || score >= ScoreType.Win.rawValue {
            return score
        }
        var bestScore = Int.min
        let positions = generatorPositions()
        positions.forEach { (position) in
            boardArray[position.column, position.row] = chess.rawValue
            let score = humanMoveScore(deep: deep - 1, alpha: alpha, beta: bestScore > beta ? bestScore : beta)
            boardArray[position.column, position.row] = ChessType.Empty.rawValue
            if score > bestScore {
                bestScore = score
            }
            if score > alpha {
                cut += 1
                return
            }
        }
        return bestScore
    }
    
    func calculatePointScore(position position: ChessPosition, chess: ChessType) -> Int {
        var score = 0
        switch chess {
        case .White:
            let values = boardArray.pointAllValues(position)
            values.forEach({ (value) in
                if isExistWhite_Five(value) {
                    score += ScoreType.Five.rawValue
                } else if let _ = isExistWhite_Four_live(value) {
                    score += ScoreType.Four_live.rawValue
                } else if let _ = isExistWhite_Four_rush(value) {
                    score += ScoreType.Four_rush.rawValue
                } else if let _ = isExistWhite_Three_live(value) {
                    score += ScoreType.Three_live.rawValue
                } else if let _ = isExistWhite_Three_rush(value) {
                    score += ScoreType.Three_rush.rawValue
                } else if let _ = isExistWhite_Two_live(value) {
                    score += ScoreType.Two_live.rawValue
                } else if let _ = isExistWhite_Two_rush(value) {
                    score += ScoreType.Two_rush.rawValue
                } else if let _ = isExistWhite_One_live(value) {
                    score += ScoreType.One_live.rawValue
                }
            })
        case .Black:
            let values = boardArray.pointAllValues(position)
            values.forEach({ (value) in
                if isExistBlack_Five(value) {
                    score += ScoreType.Five.rawValue
                } else if let _ = isExistBlack_Four_live(value) {
                    score += ScoreType.Four_live.rawValue
                } else if let _ = isExistBlack_Four_rush(value) {
                    score += ScoreType.Four_rush.rawValue
                } else if let _ = isExistBlack_Three_live(value) {
                    score += ScoreType.Three_live.rawValue
                } else if let _ = isExistBlack_Three_rush(value) {
                    score += ScoreType.Three_rush.rawValue
                } else if let _ = isExistBlack_Two_live(value) {
                    score += ScoreType.Two_live.rawValue
                } else if let _ = isExistBlack_Two_rush(value) {
                    score += ScoreType.Two_rush.rawValue
                } else if let _ = isExistBlack_One_live(value) {
                    score += ScoreType.One_live.rawValue
                }
            })
        default:
            break
        }
        return score
    }

    
    func calculateBoardScores() -> [ChessType: Int] {
        let values = boardArray.boardAllValues()
        // 白棋分数
        var whiteScore = 0
        for value in values {
            let whiteScoreType: ScoreType
            if isExistWhite_Five(value) {
                return [ChessType.White: ScoreType.Win.rawValue, ChessType.Black: 0]
            } else if let _ = isExistWhite_Four_live(value) {
                whiteScoreType = ScoreType.Four_live
            } else if let _ = isExistWhite_Four_rush(value) {
                whiteScoreType = ScoreType.Four_rush
            } else if let _ = isExistWhite_Three_live(value) {
                whiteScoreType = ScoreType.Three_live
            } else if let _ = isExistWhite_Three_rush(value) {
                whiteScoreType = ScoreType.Three_rush
            } else if let _ = isExistWhite_Two_live(value) {
                whiteScoreType = ScoreType.Two_live
            } else if let _ = isExistWhite_Two_rush(value) {
                whiteScoreType = ScoreType.Two_rush
            } else if let _ = isExistWhite_One_live(value) {
                whiteScoreType = ScoreType.One_live
            } else {
                whiteScoreType = ScoreType.Defult
            }
            whiteScore += whiteScoreType.rawValue
        }
        // 黑棋分数
        var blackScore = 0
        for value in values {
            let blackScoreType: ScoreType
            if isExistBlack_Five(value) {
                return [ChessType.White: 0, ChessType.Black: ScoreType.Win.rawValue]
            } else if let _ = isExistBlack_Four_live(value) {
                blackScoreType = ScoreType.Four_live
            } else if let _ = isExistBlack_Four_rush(value) {
                blackScoreType = ScoreType.Four_rush
            } else if let _ = isExistBlack_Three_live(value) {
                blackScoreType = ScoreType.Three_live
            } else if let _ = isExistBlack_Three_rush(value) {
                blackScoreType = ScoreType.Three_rush
            } else if let _ = isExistBlack_Two_live(value) {
                blackScoreType = ScoreType.Two_live
            } else if let _ = isExistBlack_Two_rush(value) {
                blackScoreType = ScoreType.Two_rush
            } else if let _ = isExistBlack_One_live(value) {
                blackScoreType = ScoreType.One_live
            } else {
                blackScoreType = ScoreType.Defult
            }
            blackScore += blackScoreType.rawValue
        }
        return [ChessType.Black:blackScore, ChessType.White: whiteScore]
        
    }

    
    
    
    
    // 生成所有可能的坐标，周围有棋子的优先
    func generatorPositions() -> [ChessPosition] {
        var highLevelPositions = [ChessPosition]()
        var lowLevelPositions = [ChessPosition]()
        for c in 1...15 {
            for r in 1...15 {
                if boardArray[c,r] == ChessType.Empty.rawValue {
                    let position = ChessPosition(column: c,row: r)
                    if boardArray.checkPositionHasNeighbor(position, distance: 1, neighborCount: 1) {
                        highLevelPositions.append(position)
                    } else if boardArray.checkPositionHasNeighbor(position, distance: 2, neighborCount: 2) {
                        lowLevelPositions.append(position)
                    }
                }
            }
        }
        return highLevelPositions + lowLevelPositions
    }
    
    func genPositions() -> [ChessPosition] {
        
        var fiveKills = [ChessPosition]()
        var fourKills = [ChessPosition]()
        var threeKills = [ChessPosition]()
        var threes = [ChessPosition]()
        var twos = [ChessPosition]()
        var neighbors = [ChessPosition]()
        var nextNeighbors = [ChessPosition]()
        
        for c in 1...15 {
            for r in 1...15 {
                if boardArray[c,r] == ChessType.Empty.rawValue {
                    let position = ChessPosition(column: c,row: r)
                    if boardArray.checkPositionHasNeighbor(position, distance: 1, neighborCount: 1) {
                        let aiScore = calculatePointScore(position: position, chess: chess)
                        let humanScore = calculatePointScore(position: position, chess: chess.oppoType())
                        if aiScore >= ScoreType.Five.rawValue {
                            return [position]
                        } else if humanScore >= ScoreType.Five.rawValue {
                            fiveKills.append(position)
                        } else if aiScore >= ScoreType.Four_live.rawValue {
                            fourKills.insert(position, atIndex: 0)
                        } else if humanScore >= ScoreType.Four_live.rawValue {
                            fourKills.append(position)
                        } else if aiScore >= 2 * ScoreType.Three_live.rawValue {
                            threeKills.insert(position, atIndex: 0)
                        } else if humanScore >= 2 * ScoreType.Three_live.rawValue {
                            threeKills.append(position)
                        } else if aiScore >= ScoreType.Three_live.rawValue {
                            threes.insert(position, atIndex: 0)
                        } else if humanScore >= ScoreType.Three_live.rawValue {
                            threes.append(position)
                        } else if aiScore >= ScoreType.Two_live.rawValue {
                            twos.insert(position, atIndex: 0)
                        } else if humanScore >= ScoreType.Two_live.rawValue {
                            twos.append(position)
                        } else {
                            neighbors.append(position)
                        }
                    } else if boardArray.checkPositionHasNeighbor(position, distance: 2, neighborCount: 2) {
                        nextNeighbors.append(position)
                    }
                }
            }
        }
        
        if fiveKills.count > 0 {
            return [fiveKills.first!]
        }
        if fourKills.count > 0 {
            return fourKills
        }
        if threeKills.count > 0 {
            return threeKills
        }
        return threes + twos + neighbors + nextNeighbors
    }
    
    
    
    
    
    
    
//    func getBestResult(boardArray: BoardArray2D) -> (ChessPosition, Int) {
//        var bestResult:(ChessPosition, Int) = (ChessPosition(column: 0,row: 0),-90000000000)
//        for c in 1...15 {
//            for r in 1...15 {
//                if boardArray[c,r] == "E" {
//                    boardArray[c,r] = chess.rawValue
//                    let positionScore = PositionScoresArray.getScore(column: c, row: r)
//                    let scores = calculateBoardScores(column: c, row: r, boardArray: boardArray)
//                    let blackScore = scores[.Black]!
//                    let whiteScore = scores[.White]!
//                    let score: Int
//                    if chess == .Black {
//                        if blackScore > whiteScore + 500 {
//                            score = blackScore - whiteScore + positionScore
//                        } else {
//                            score = blackScore - whiteScore * 2 + positionScore
//                        }
//                    } else {
//                        if whiteScore > blackScore + 500 {
//                            score = whiteScore - blackScore + positionScore
//                        } else {
//                            score = whiteScore - blackScore * 2 + positionScore
//                        }
//                        
//                    }
//                    if score > bestResult.1 {
//                        //print("c: \(c) r: \(r) score: \(score)")
//                        bestResult = (ChessPosition(column: c, row: r), score)
//                    }
//                    boardArray[c,r] = "E"
//                }
//            }
//        }
//        return bestResult
//    }
//    
//    func calculateBoardScores(column column:Int, row: Int, boardArray: BoardArray2D) -> [ChessType:Int] {
//        let values = boardArray.boardAllValues()
//        // 白棋分数
//        var whiteScore = 0
//        for value in values {
//            let whiteScoreType: ScoreType
//            if isExistWhite_Five(value) {
//                whiteScore = ScoreType.Win.rawValue
//                break
//            } else if isExistWhite_Four_live(value) {
//                whiteScore = ScoreType.Win.rawValue
//                break
//            } else if isExistWhite_Four_rush(value) {
//                whiteScoreType = ScoreType.Four_rush
//            } else if isExistWhite_Three_live(value) {
//                whiteScoreType = ScoreType.Three_live
//            } else if isExistWhite_Three_rush(value) {
//                whiteScoreType = ScoreType.Three_rush
//            } else if isExistWhite_Two_live(value) {
//                whiteScoreType = ScoreType.Two_live
//            } else if isExistWhite_Two_rush(value) {
//                whiteScoreType = ScoreType.Two_rush
//            } else if isExistWhite_One_live(value) {
//                whiteScoreType = ScoreType.One_live
//            } else {
//                whiteScoreType = ScoreType.Defult
//            }
//            whiteScore += whiteScoreType.rawValue
//        }
//        // 黑棋分数
//        var blackScore = 0
//        for value in values {
//            let blackScoreType: ScoreType
//            if isExistBlack_Five(value) {
//                blackScore = ScoreType.Win.rawValue
//                break
//            } else if isExistBlack_Four_live(value) {
//                print("Black Four")
//                blackScore = ScoreType.Win.rawValue
//                break
//            } else if isExistBlack_Four_rush(value) {
//                blackScoreType = ScoreType.Four_rush
//            } else if isExistBlack_Three_live(value) {
//                blackScoreType = ScoreType.Three_live
//            } else if isExistBlack_Three_rush(value) {
//                blackScoreType = ScoreType.Three_rush
//            } else if isExistBlack_Two_live(value) {
//                blackScoreType = ScoreType.Two_live
//            } else if isExistBlack_Two_rush(value) {
//                blackScoreType = ScoreType.Two_rush
//            } else if isExistBlack_One_live(value) {
//                blackScoreType = ScoreType.One_live
//            } else {
//                blackScoreType = ScoreType.Defult
//            }
//            blackScore += blackScoreType.rawValue
//        }
//        return [ChessType.Black:blackScore, ChessType.White: whiteScore]
//    
//    }
    
    func isExistWhite_Five(value: String) -> Bool {
        if value.containsString(White_Five) {
            return true
        }
        return false
    }
    
    func isExistWhite_Four_live(value: String) -> String? {
        for temp in White_Four_live {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistWhite_Four_rush(value: String) -> String? {
        for temp in White_Four_rush {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistWhite_Three_live(value: String) -> String? {
        for temp in White_Three_live {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistWhite_Three_rush(value: String) -> String? {
        for temp in White_Three_rush {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistWhite_Two_live(value: String) -> String? {
        for temp in White_Two_live {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistWhite_Two_rush(value: String) -> String? {
        for temp in White_Two_rush {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistWhite_One_live(value: String) -> String? {
        for temp in White_One_live {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistBlack_Five(value: String) -> Bool {
        if value.containsString(Black_Five) {
            return true
        }
        return false
    }
    
    func isExistBlack_Four_live(value: String) -> String? {
        for temp in Black_Four_live {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistBlack_Four_rush(value: String) -> String? {
        for temp in Black_Four_rush {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistBlack_Three_live(value: String) -> String? {
        for temp in Black_Three_live {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistBlack_Three_rush(value: String) -> String? {
        for temp in Black_Three_rush {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistBlack_Two_live(value: String) -> String? {
        for temp in Black_Two_live {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistBlack_Two_rush(value: String) -> String? {
        for temp in Black_Two_rush {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
    func isExistBlack_One_live(value: String) -> String? {
        for temp in Black_One_live {
            if value.containsString(temp) {
                return temp
            }
        }
        return nil
    }
    
        
}