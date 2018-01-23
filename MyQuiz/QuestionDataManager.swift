//
//  QuestionDataManager.swift
//  MyQuiz
//
//  Created by 遠山　聡美 on 2018/01/10.
//  Copyright © 2018年 Simple. All rights reserved.
//

import Foundation

//1つの問題に関する情報を格納するデータクラス
class QuestionData {
    //問題文
    var question:String
    
    //選択肢1〜4
    var answer1:String
    var answer2:String
    var answer3:String
    var answer4:String
    
    //正解の番号
    var correctAnswerNumber:Int
    
    //ユーザが選択した番号
    var userChoiseAnswerNo:Int?
    
    //問題の番号
    var questionNo:Int = 0
    
    //クラスが生成された時の処理
    init(questionSourceDataArray:[String]) {
        question = questionSourceDataArray[0]
        answer1 = questionSourceDataArray[1]
        answer2 = questionSourceDataArray[2]
        answer3 = questionSourceDataArray[3]
        answer4 = questionSourceDataArray[4]
        correctAnswerNumber = Int(questionSourceDataArray[5])!
    }
    //ユーザが選択した答えが正解かどうか判定する
    func isCorrect() -> Bool {
        //答えが一致しているかどうか判定する
        if correctAnswerNumber == userChoiseAnswerNo {
            //正解
            return true
        }
        return false
    }
    
}

//クイズデータ全般の管理と成績を管理するクラス
class QuestionDataManager {
    //シングルトンを作成　シングルトンの書き方のうちのひとつ
    static let sharedInstance = QuestionDataManager()
    
    //問題を格納するための配列
    var questionDataArray = [QuestionData]()
    
    //現在の問題のインデックス
    var nowQuestionIndex:Int = 0
    
    //初期化処理
    private init() {
        //シングルトンであることを保証するためにprivateで宣言する
    }
    
    //問題文の読み込み処理
    func loadQuestion(){
        //格納済みの問題があれば一旦削除しておく
        questionDataArray.removeAll()
        
        //現在の問題のインデックスを初期化
        nowQuestionIndex = 0
        
        //CSVファイルのパスを取得
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv") else {
            //csvなし
            print("CSVなし")
            return
        }
        //CSVファイルの読み込み
        do {
            let csvStringData = try String(contentsOfFile:csvFilePath, encoding: String.Encoding.utf8)
            
            //CSVのデータを1行ずつ読み込む
            csvStringData.enumerateLines(invoking: { (line, stop) in
                //カンマ区切りで分割
                let questionSourceDataArray = line.components(separatedBy: ",")
                //問題データを格納するオブジェクトを作成
                let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
                //問題を追加
                self.questionDataArray.append(questionData)
                //問題番号を追加
                questionData.questionNo = self.questionDataArray.count
                
            })
        } catch let error {
            print("CSV読み込みエラーが発生しました\(error)")
        }
    }
    //次の問題を取り出す
    func nextQuestion() -> QuestionData?{
        if nowQuestionIndex < questionDataArray.count {
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
}







