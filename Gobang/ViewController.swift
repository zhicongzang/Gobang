//
//  ViewController.swift
//  Gobang
//
//  Created by Zhicong Zang on 4/14/16.
//  Copyright © 2016 Zhicong Zang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let boardView = BoardView(frame: CGRect(x: 0, y: 100, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.width))
    var tapGesture: UITapGestureRecognizer?
    var boardDataManager = BoardDataManager(columns: 17, rows: 17)
    var ai: AI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        boardDataManager.delegate = self
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.addChess(_:)))
        self.view.addGestureRecognizer(tapGesture!)
        self.view.addSubview(boardView)
        ai = AI(chess: ChessType.White, boardArray: boardDataManager.boardArray)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addChess(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(boardView)
        let position = chessPosition(point)
        if boardDataManager.isLegal(column: position.column, row: position.row) {
            boardView.addStone(column: position.column, row: position.row, type: boardDataManager.chess)
            boardDataManager[position.column, position.row] = boardDataManager.chess.rawValue
            
        }
        let aiP = ai.getBestResult(deep: 1)
        if boardDataManager.isLegal(column: aiP.column, row: aiP.row) {
            boardView.addStone(column: aiP.column, row: aiP.row, type: boardDataManager.chess)
            boardDataManager[aiP.column, aiP.row] = boardDataManager.chess.rawValue
            
        }
    }
    
    func chessPosition(point: CGPoint) -> ChessPosition {
        let column = lroundf(Float((point.x - BorderWidth) / LineWidth)) + 1
        let row = lroundf(Float((point.y - BorderWidth) / LineWidth)) + 1
        if column < 1 || column > 15 || row < 1 || row > 15 {
            return ChessPosition(column: 0, row: 0)
        }
        return ChessPosition(column: column, row: row)
    }
    
    @IBAction func Undo(sender: UIButton) {
        if let chessPosition = boardDataManager.undoOnce() {
            boardView.removeStone(chessPosition)
        }
    }
    
    @IBAction func printBoard(sender: AnyObject) {
        boardDataManager.printBoard()
    }


}

extension ViewController: BoardDataDelegate {
    func winTheGame() {
        var message = " is Win!"
        if boardDataManager.chess == .Black {
            message = "Black" + message
        } else {
            message = "White" + message
        }
        let controller = UIAlertController(title: "Win", message: message, preferredStyle: .Alert)
        let okayAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){ (action) in
            self.boardDataManager.initBoard()
            self.boardView.initBoard()
        }
        controller.addAction(okayAction)
        self.presentViewController(controller, animated: true, completion: nil)
    }
}

