//
//  BoardView.swift
//  Gobang
//
//  Created by Zhicong Zang on 4/14/16.
//  Copyright © 2016 Zhicong Zang. All rights reserved.
//

import UIKit

enum ChessType: Int {
    case Empty = 0
    case Black = 1
    case White = -1
}

let BoardWidth = UIScreen.mainScreen().bounds.width
let BoardHeight = UIScreen.mainScreen().bounds.height
let BorderWidth = BoardWidth / (20*2 + 30*14) * 20
let LineWidth = BoardWidth / (20*2 + 30*14) * 30
let ChessSize = LineWidth

let BoardImage = UIImage(named: "board.png")!
let BlackStoneImage = UIImage(named: "stone_black.png")!
let WhiteStoneImage = UIImage(named: "stone_white.png")!

class BoardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        BoardImage.drawInRect(self.frame)
    }
    
    func addStone(column column: Int, row: Int, type: ChessType) {
        let point = centerPoint(column: column, row: row)
        let stone = UIImageView(frame: CGRect(x: 0, y: 0, width: ChessSize, height: ChessSize))
        stone.center = point
        if type == .Black {
            stone.image = BlackStoneImage
        } else if type == .White {
            stone.image = WhiteStoneImage
        }
        self.addSubview(stone)
    }
    
    func centerPoint(column column: Int, row: Int) -> CGPoint {
        return CGPointMake(BorderWidth + LineWidth * CGFloat(column), BorderWidth + LineWidth * CGFloat(row))
    }
    
    
}