//
//  ResultViewController.swift
//  MyQuiz
//
//  Created by 遠山　聡美 on 2018/01/29.
//  Copyright © 2018年 Simple. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var correctPersentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //問題数を取得する
        let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        
        //正解数を取得する
        var correctCount:Int = 0
        
        //正解数を計算する
        for questionData in QuestionDataManager.sharedInstance.questionDataArray {
            if questionData.isCorrect() {
                correctCount += 1
            }
        }
        
        //正解率を計算する
        let correctParsent:Float = (Float(correctCount) / Float(questionCount)) * 100
        
        correctPersentLabel.text = String(format:"%.lf", correctParsent) + "%"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
