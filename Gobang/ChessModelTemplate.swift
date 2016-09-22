//
//  ChessModelTemplate.swift
//  Gobang
//
//  Created by ZZC on 4/15/16.
//  Copyright © 2016 Zhicong Zang. All rights reserved.
//

import Foundation

struct PositionScoresArray {
    static var scores: [Int] {
        var s = Array.init(count: 17*17, repeatedValue: 0)
        for c in 0...16 {
            for r in 0...16 {
                let cScore = c<=8 ? c : 16 - c
                let rScore = r<=8 ? r : 16 - r
                s[16 * r + c] = cScore + rScore
            }
        }
        return s
    }
    static func getScore(column column: Int, row: Int) -> Int {
        return scores[16 * row + column]
    }
}

enum ScoreType: Int {
    case Five = 10000000
    case Four_live = 100000
    case Four_rush = 900
    case Three_live = 500
    case Three_rush = 100
    case Two_live = 50
    case Two_rush = 15
    case One_live = 1
    case Defult = 0
    case Win = 100000000
}


// 白棋
let White_Five = "WWWWW"

let White_Four_live = ["EWWWWE",
                       "WEWwWEW"]

let White_Four_rush = ["EWWWW",
                       "WEWWW",
                       "WWEWW",
                       "WWWEW",
                       "WWWWE"]

let White_Three_live = ["EEWWWE",
                        "EWEWWE",
                        "EWWEWE",
                        "EWWWEE"]

let White_Three_rush = ["EEWWW",
                        "EWWWE",
                        "WWWEE",
                        "EWEWW",
                        "EWWEW",
                        "WWEWE",
                        "WEWWE",
                        "WWEEW",
                        "WEEWW",
                        "WEWEW"]

let White_Two_live = ["EEEWWE",
                      "EEWWEE",
                      "EWWEEE",
                      "EEWEWE",
                      "EWEWEE",
                      "EWEEWE"]

let White_Two_rush = ["EEEWW",
                      "EEWWE",
                      "EWWEE",
                      "WWEEE",
                      "EEWEW",
                      "EWEWE",
                      "WEWEE",
                      "EWEEW",
                      "WEEWE"]

let White_One_live = ["EWEEEE",
                      "EEEEWE"]


// 黑棋
let Black_Five = "BBBBB"

let Black_Four_live = ["EBBBBE",
                       "BEBBBEB"]

let Black_Four_rush = ["EBBBB",
                       "BEBBB",
                       "BBEBB",
                       "BBBEB",
                       "BBBBE"]

let Black_Three_live = ["EEBBBE",
                        "EBEBBE",
                        "EBBEBE",
                        "EBBBEE"]

let Black_Three_rush = ["EEBBB",
                        "EBBBE",
                        "BBBEE",
                        "EBEBB",
                        "EBBEB",
                        "BBEBE",
                        "BEBBE",
                        "BBEEB",
                        "BEEBB",
                        "BEBEB"]

let Black_Two_live = ["EEEBBE",
                      "EEBBEE",
                      "EBBEEE",
                      "EEBEBE",
                      "EBEBEE",
                      "EBEEBE"]

let Black_Two_rush = ["EEEBB",
                      "EEBBE",
                      "EBBEE",
                      "BBEEE",
                      "EEBEB",
                      "EBEBE",
                      "BEBEE",
                      "EBEEB",
                      "BEEBE"]

let Black_One_live = ["EBEEEE",
                      "EEEEBE"]


