//
//  BoardData.swift
//  Gobang
//
//  Created by ZZC on 4/14/16.
//  Copyright © 2016 Zhicong Zang. All rights reserved.
//

import Foundation

enum ChessType: Character {
    case Empty = "E"
    case Black = "B"
    case White = "W"
    case Line = "L"
    
    func oppoType() -> ChessType {
        switch self {
        case .Black:
            return .White
        case .White:
            return .Black
        default:
            return .Empty
        }
    }
}

let WhiteWin = "WWWWW"
let BlackWin = "BBBBB"

protocol BoardDataDelegate {
    func winTheGame()
}

class BoardDataManager {
    let columns: Int
    let rows: Int
    var delegate: BoardDataDelegate?
    
    var boardArray: BoardArray2D
    var recordArray: [(ChessPosition, ChessType)] = []
    
    var chess = ChessType.Black
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        boardArray = BoardArray2D(columns: columns, rows: rows)
        initBoard()
    }
    
    subscript(column: Int, row: Int) -> Character {
        get {
            return boardArray[column, row]
        }
        set {
            boardArray[column, row] = newValue
            recordArray.append((ChessPosition(column: column, row: row), chess))
            if isWin(column: column, row: row) {
                delegate!.winTheGame()
            } else {
                if chess == .Black {
                    chess = .White
                } else {
                    chess = .Black
                }
            }
        }
    }
    
    func initBoard() {
        for c in 0...16 {
            for r in 0...16 {
                if c == 0 || r == 0 || c == 16 || r == 16 {
                    boardArray[c, r] = "L"
                } else {
                    boardArray[c, r] = "E"
                }
            }
        }
        chess = .Black
        recordArray = []
    }
    
    func isLegal(column column: Int, row: Int) -> Bool {
        if boardArray[column, row] == "E" {
            return true
        }
        return false
    }
    
    
    func isWin(column column: Int, row: Int) -> Bool {
        let winResult: String
        if chess == .Black {
            winResult = BlackWin
        } else {
            winResult = WhiteWin
        }
        for value in boardArray.positionValues(column: column, row: row) {
            if value.containsString(winResult) {
                return true
            }
        }

        return false
    }
    
    func undoOnce() -> ChessPosition? {
        if recordArray.count < 1 {
            return nil
        } else {
            let record = recordArray.removeLast()
            boardArray[record.0.column, record.0.row] = "E"
            chess = record.1
            return record.0
        }
    }
    
    func printBoard() {
        boardArray.printBoard()
    }
    
    
    
    
    
    
    
    
    
}

