//
//  ViewController.swift
//  Gobang
//
//  Created by Zhicong Zang on 4/14/16.
//  Copyright © 2016 Zhicong Zang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let boardView = BoardView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.width))
    var tapGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.addChess(_:)))
        self.view.addGestureRecognizer(tapGesture!)
        self.view.addSubview(boardView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addChess(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(boardView)
        let position = chessPosition(point)
        boardView.addStone(column: position.0, row: position.1, type: ChessType.Black)
    }
    
    func chessPosition(point: CGPoint) -> (Int,Int) {
        let column = lroundf(Float((point.x - BorderWidth) / LineWidth))
        let row = lroundf(Float((point.y - BorderWidth) / LineWidth))
        return (column, row)
    }
    
    


}

