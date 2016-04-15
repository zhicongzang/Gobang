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
}

let WhiteWin = "WWWWW"
let BlackWin = "BBBBB"

protocol BoardDataDelegate {
    func winTheGame()
}

class BoardData {
    let columns: Int
    let rows: Int
    let delegate: BoardDataDelegate
    
    var array: Array<Character>
    var chess = ChessType.Black
    
    init(columns: Int, rows: Int, delegate: BoardDataDelegate) {
        self.columns = columns
        self.rows = rows
        self.delegate = delegate
        array = Array<Character>.init(count: columns * rows, repeatedValue: "L")
        initBoard()
    }
    
    subscript(column: Int, row: Int) -> Character {
        get {
            return array[columns * row + column]
        }
        set {
            array[columns * row + column] = newValue
            if isWin(column: column, row: row) {
                delegate.winTheGame()
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
                    array[columns * r + c] = "L"
                } else {
                    array[columns * r + c] = "E"
                }
            }
        }
        chess = .Black
    }
    
    func isLegal(column column: Int, row: Int) -> Bool {
        if array[columns * row + column] == "E" {
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
        var result = ""
        // 判断行
        for c in 1...15 {
            result.append(array[columns * row + c])
        }
        if result.containsString(winResult) {
            return true
        } else {
            result = ""
        }
        // 判断列
        for r in 1...15 {
            result.append(array[columns * r + column])
        }
        if result.containsString(winResult) {
            return true
        } else {
            result = ""
        }
        // 判断左上右下
        result = String(array[columns * row + column])
        for i in 1...15 {
            if row - i > 0 && column - i > 0 {
                result = String(array[columns * (row - i) + (column - i)]) + result
            } else {
                break
            }
        }
        for i in 1...15 {
            if row + i < 16 && column + i < 16 {
                result = result + String(array[columns * (row + i) + (column + i)])
            } else {
                break
            }
        }
        if result.containsString(winResult) {
            return true
        } else {
            result = ""
        }
        // 判断左下右上
        result = String(array[columns * row + column])
        for i in 1...15 {
            if row + i < 16 && column - i > 0 {
                result = String(array[columns * (row + i) + (column - i)]) + result
            } else {
                break
            }
        }
        for i in 1...15 {
            if row - i > 0 && column + i < 16 {
                result = result + String(array[columns * (row - i) + (column + i)])
            } else {
                break
            }
        }
        if result.containsString(winResult) {
            return true
        }

        return false
    }
    
    
    
    
    
    
    
    
    
}