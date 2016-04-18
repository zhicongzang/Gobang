//
//  Array2D.swift
//  Gobang
//
//  Created by ZZC on 4/15/16.
//  Copyright © 2016 Zhicong Zang. All rights reserved.
//

import Foundation

class BoardArray2D: NSCopying {
    let columns: Int
    let rows: Int
    
    var array: [Character]
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<Character>.init(count: columns * rows, repeatedValue: "L")
    }
    
    init(columns: Int, rows: Int, array: [Character]) {
        self.columns = columns
        self.rows = rows
        self.array = array
    }
    
    subscript(column: Int, row: Int) -> Character {
        get {
            return array[columns * row + column]
        }
        set {
            array[columns * row + column] = newValue
        }
    }
    
    @objc func copyWithZone(zone: NSZone) -> AnyObject {
        return BoardArray2D(columns: self.columns, rows: self.rows, array: self.array)
    }
    
    // 行值
    func rowValue(row row: Int) -> String {
        var value = ""
        for c in 1...15 {
            value.append(self[c, row])
        }
        return value
    }
    
    // 列值
    func columnValue(column column: Int) -> String {
        var value = ""
        for r in 1...15 {
            value.append(self[column, r])
        }
        return value
    }
    
    // 左上右下值
    func leftDiagonalValue(column column: Int, row: Int) -> String {
        var value = String(self[column, row])
        for i in 1...15 {
            if row - i > 0 && column - i > 0 {
                value = String(self[column - i, row - i]) + value
            } else {
                break
            }
        }
        for i in 1...15 {
            if row + i < 16 && column + i < 16 {
                value = value + String(self[column + i, row + i])
            } else {
                break
            }
        }
        return value
        
    }
    // 左下右上值
    func rightDiagonalValue(column column: Int, row: Int) -> String {
        var value = String(self[column, row])
        for i in 1...15 {
            if row + i < 16 && column - i > 0 {
                value = String(self[column - i, row + i]) + value
            } else {
                break
            }
        }
        for i in 1...15 {
            if row - i > 0 && column + i < 16 {
                value = value + String(self[column + i, row - i])
            } else {
                break
            }
        }
        return value
        
    }
    
    func positionValues(column column: Int, row: Int) -> [String] {
        return [columnValue(column: column),                        // 列值
            rowValue(row: row),                                 // 行值
            leftDiagonalValue(column: column, row: row),        // 左上右下对角线值
            rightDiagonalValue(column: column, row: row)]       // 左下右上对角线值
    }
    
    func boardAllValues() -> [String] {
        var values = [String]()
        for c in 1...15 {
            values.append(columnValue(column: c))
        }
        for r in 1...15 {
            values.append(rowValue(row: r))
        }
        for c in 1...11 {
            values.append(leftDiagonalValue(column: c, row: 1))
        }
        for r in 2...11 {
            values.append(leftDiagonalValue(column: 1, row: r))
        }
        for c in 5...15 {
            values.append(rightDiagonalValue(column: c, row: 1))
        }
        for r in 2...11 {
            values.append(rightDiagonalValue(column: 15, row: r))
        }
        return values
    }
    
    
}

struct ChessPosition: Hashable {
    let column: Int
    let row: Int
    
    init(column: Int, row: Int) {
        self.column = column
        self.row = row
    }
    
    var hashValue: Int {
        return column.hashValue ^ row.hashValue
    }
}

func ==(lhs: ChessPosition, rhs: ChessPosition) -> Bool {
    return (lhs.column == rhs.column) && (lhs.row == rhs.row)
}