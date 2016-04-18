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
    
    init(chess: ChessType) {
        self.chess = chess
    }
    
    func getBestResult(boardArray: BoardArray2D) -> (ChessPosition, Int) {
        var bestResult:(ChessPosition, Int) = (ChessPosition(column: 0,row: 0),-90000000000)
        for c in 1...15 {
            for r in 1...15 {
                if boardArray[c,r] == "E" {
                    boardArray[c,r] = chess.rawValue
                    let positionScore = PositionScoresArray.getScore(column: c, row: r)
                    let scores = calculateBoardScores(column: c, row: r, boardArray: boardArray)
                    let blackScore = scores[.Black]!
                    let whiteScore = scores[.White]!
                    let score: Int
                    if chess == .Black {
                        if blackScore > ScoreType.Win.rawValue/10 {
                            boardArray[c,r] = "E"
                            return (ChessPosition(column: c, row: r), blackScore)
                        } else if blackScore > whiteScore + 500 {
                            score = blackScore - whiteScore + positionScore
                        } else {
                            score = blackScore - whiteScore * 2 + positionScore
                        }
                    } else {
                        if whiteScore > ScoreType.Win.rawValue/10 {
                            print("findWin")
                            boardArray[c,r] = "E"
                            return (ChessPosition(column: c, row: r), whiteScore)
                        } else if whiteScore > blackScore + 500 {
                            score = whiteScore - blackScore + positionScore
                        } else {
                            score = whiteScore - blackScore * 2 + positionScore
                        }
                        
                    }
                    if score > bestResult.1 {
                        print("c: \(c) r: \(r) score: \(score)")
                        bestResult = (ChessPosition(column: c, row: r), score)
                    }
                    boardArray[c,r] = "E"
                }
            }
        }
        return bestResult
    }
    
    func calculateBoardScores(column column:Int, row: Int, boardArray: BoardArray2D) -> [ChessType:Int] {
        let values = boardArray.boardAllValues()
        // 白棋分数
        var whiteScore = 0
        for value in values {
            let whiteScoreType: ScoreType
            if isExistWhite_Five(value) {
                whiteScore = ScoreType.Win.rawValue
                break
            } else if isExistWhite_Four_live(value) {
                whiteScore = ScoreType.Win.rawValue
                break
            } else if isExistWhite_Four_rush(value) {
                whiteScoreType = ScoreType.Four_rush
            } else if isExistWhite_Three_live(value) {
                whiteScoreType = ScoreType.Three_live
            } else if isExistWhite_Three_rush(value) {
                whiteScoreType = ScoreType.Three_rush
            } else if isExistWhite_Two_live(value) {
                whiteScoreType = ScoreType.Two_live
            } else if isExistWhite_Two_rush(value) {
                whiteScoreType = ScoreType.Two_rush
            } else if isExistWhite_One_live(value) {
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
                blackScore = ScoreType.Win.rawValue
                break
            } else if isExistBlack_Four_live(value) {
                print("Black Four")
                blackScore = ScoreType.Win.rawValue
                break
            } else if isExistBlack_Four_rush(value) {
                blackScoreType = ScoreType.Four_rush
            } else if isExistBlack_Three_live(value) {
                blackScoreType = ScoreType.Three_live
            } else if isExistBlack_Three_rush(value) {
                blackScoreType = ScoreType.Three_rush
            } else if isExistBlack_Two_live(value) {
                blackScoreType = ScoreType.Two_live
            } else if isExistBlack_Two_rush(value) {
                blackScoreType = ScoreType.Two_rush
            } else if isExistBlack_One_live(value) {
                blackScoreType = ScoreType.One_live
            } else {
                blackScoreType = ScoreType.Defult
            }
            blackScore += blackScoreType.rawValue
        }
        return [ChessType.Black:blackScore, ChessType.White: whiteScore]
        
    }
    
    func isExistWhite_Five(value: String) -> Bool {
        if value.containsString(White_Five) {
            return true
        }
        return false
    }
    
    func isExistWhite_Four_live(value: String) -> Bool {
        for temp in White_Four_live {
            if value.containsString(temp) {
                print("white four")
                return true
            }
        }
        return false
    }
    
    func isExistWhite_Four_rush(value: String) -> Bool {
        for temp in White_Four_rush {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistWhite_Three_live(value: String) -> Bool {
        for temp in White_Three_live {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistWhite_Three_rush(value: String) -> Bool {
        for temp in White_Three_rush {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistWhite_Two_live(value: String) -> Bool {
        for temp in White_Two_live {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistWhite_Two_rush(value: String) -> Bool {
        for temp in White_Two_rush {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistWhite_One_live(value: String) -> Bool {
        for temp in White_One_live {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistBlack_Five(value: String) -> Bool {
        if value.containsString(Black_Five) {
            return true
        }
        return false
    }
    
    func isExistBlack_Four_live(value: String) -> Bool {
        for temp in Black_Four_live {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistBlack_Four_rush(value: String) -> Bool {
        for temp in Black_Four_rush {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistBlack_Three_live(value: String) -> Bool {
        for temp in Black_Three_live {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistBlack_Three_rush(value: String) -> Bool {
        for temp in Black_Three_rush {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistBlack_Two_live(value: String) -> Bool {
        for temp in Black_Two_live {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistBlack_Two_rush(value: String) -> Bool {
        for temp in Black_Two_rush {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
    
    func isExistBlack_One_live(value: String) -> Bool {
        for temp in Black_One_live {
            if value.containsString(temp) {
                return true
            }
        }
        return false
    }
        
        
}