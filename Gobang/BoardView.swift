//
//  BoardView.swift
//  Gobang
//
//  Created by Zhicong Zang on 4/14/16.
//  Copyright © 2016 Zhicong Zang. All rights reserved.
//

import UIKit



let BoardWidth = UIScreen.mainScreen().bounds.width
let BoardHeight = UIScreen.mainScreen().bounds.height
let BorderWidth = BoardWidth / (20*2 + 30*14) * 20
let LineWidth = BoardWidth / (20*2 + 30*14) * 30
let ChessSize = LineWidth

let BoardImage = UIImage(named: "board.png")!
let BlackStoneImage = UIImage(named: "stone_black.png")!
let WhiteStoneImage = UIImage(named: "stone_white.png")!

class BoardView: UIView {
    
    var chessViews: [ChessPosition: UIImageView] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        BoardImage.drawInRect(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
    }
    
    func addStone(column column: Int, row: Int, type: ChessType) {
        let point = centerPoint(column: column, row: row)
        let stoneView = UIImageView(frame: CGRect(x: 0, y: 0, width: ChessSize, height: ChessSize))
        stoneView.center = point
        if type == .Black {
            stoneView.image = BlackStoneImage
        } else if type == .White {
            stoneView.image = WhiteStoneImage
        }
        chessViews[ChessPosition(column: column, row: row)] = stoneView
        self.addSubview(stoneView)
    }
    
    func centerPoint(column column: Int, row: Int) -> CGPoint {
        return CGPointMake(BorderWidth + LineWidth * CGFloat(column - 1), BorderWidth + LineWidth * CGFloat(row - 1))
    }
    
    func initBoard() {
        for subview in subviews {
            if let chessView = subview as? UIImageView {
                chessView.removeFromSuperview()
            }
        }
        chessViews.removeAll()
    }
    
    func removeStone(chessPosition: ChessPosition) {
        if let chessView = chessViews.removeValueForKey(chessPosition) {
            chessView.removeFromSuperview()
        }
    }
    
    
    
    
}