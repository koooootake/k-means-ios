//
//  ViewController.swift
//  k-means
//
//  Created by koooootake on 2015/12/06.
//  Copyright © 2015年 koooootake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // クラスタリングしたいデータ達
    var pointData:[[Double]] = []
    // 初期点
    var pointInitialClusters:[[Double]] = []
    //クラスタ数
    var count:Int = 0
    
    var isGenelate:Bool = true
    var isSelect:Bool = false
    
    @IBOutlet weak var GenerateButton: UIButton!
    @IBOutlet weak var SelectButton: UIButton!
    @IBOutlet weak var ClusteringButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    
    //rgb(38,198,218)薄緑
    let defaultColor:UIColor = UIColor(red: 38/255.0, green: 198/255.0, blue: 218/255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタンの初期設定
        GenerateButton.backgroundColor = UIColor(red: 239/255.0, green: 83/255.0, blue: 80/255.0, alpha: 1.0)
        SelectButton.backgroundColor = defaultColor
        ClusteringButton.backgroundColor = defaultColor
        ResetButton.backgroundColor = defaultColor
        
        SelectButton.alpha = 0.5
        ClusteringButton.alpha = 0.5
        ResetButton.alpha = 0.5
        
        SelectButton.enabled = false
        ClusteringButton.enabled = false
        ResetButton.enabled = false
        
        print("GENERATE")

    }
    
    
    //データを生成するボタン
    @IBAction func GenerateButton(sender: AnyObject) {
        
        print("GENERATE")
        
        GenerateButton.backgroundColor = UIColor(red: 239/255.0, green: 83/255.0, blue: 80/255.0, alpha: 1.0)
        SelectButton.backgroundColor = defaultColor
        ClusteringButton.backgroundColor = defaultColor
        ResetButton.backgroundColor = defaultColor
        
        isGenelate = true
        isSelect = false
        
        ClusteringButton.enabled = false
        ClusteringButton.alpha = 0.5
        
        //初期点初期化
        pointInitialClusters = []
        
        let subviews = self.view.subviews
        for subview in subviews {
            //消去
            if subview.tag == 400{
                subview.removeFromSuperview()
            //色リセット
            }else if subview.tag == 200 || subview.tag == 300{
                subview.backgroundColor = defaultColor
            }
        }

    }
    
    //初期点を選択するボタン
    @IBAction func SelectButton(sender: AnyObject) {
        
        print("SELECT")
        print("Data : \(pointData)")
        
        SelectButton.backgroundColor = UIColor(red: 66/255.0, green: 165/255.0, blue: 245/255.0, alpha: 1.0)
        GenerateButton.backgroundColor = defaultColor
        ClusteringButton.backgroundColor = defaultColor
        ResetButton.backgroundColor = defaultColor
        
        isGenelate = false
        isSelect = true
        
        ClusteringButton.enabled = false
        ClusteringButton.alpha = 0.5
    
        //初期点初期化
        pointInitialClusters = []
        
        //クラスタ数初期化
        count = 0
        
        let subviews = self.view.subviews
        for subview in subviews {
            //消去
            if subview.tag == 200 || subview.tag == 400{
                subview.removeFromSuperview()
            //色リセット
            }else if subview.tag == 100 || subview.tag == 300{
                subview.backgroundColor = defaultColor
                subview.tag = 100
            }
        }

    }
   
    //k-meansクラスタリングするボタン
    @IBAction func ClusteringButton(sender: AnyObject) {
        
        print("CLUSTERING")
        print("InitialClusters : \(pointInitialClusters)")

        ClusteringButton.backgroundColor = UIColor(red: 255/255.0, green: 167/255.0, blue: 38/255.0, alpha: 1.0)
        GenerateButton.backgroundColor = defaultColor
        SelectButton.backgroundColor = defaultColor
        ResetButton.backgroundColor = defaultColor
        
        isGenelate = false
        isSelect = false
        
        //k-means
        let (finalClusters, labels) = kMeans(pointData, clusters: pointInitialClusters, minChange: 0.0001)
        
        //クラスタの重心を出力する
        for (index,finalCluster) in finalClusters.enumerate() {
            print("Cluster[\(index)] at \(finalCluster)")
            
            let x:CGFloat = CGFloat(finalCluster[0])
            let y:CGFloat = CGFloat(finalCluster[1])
            
            let centerPoint:UIView = UIView(frame: CGRectMake(x,y,15,15))
            switch index{
                case 0:
                    //rgb(239,83,80)赤
                    //rgb(198,40,40)濃い赤
                    centerPoint.backgroundColor = UIColor(red: 198/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1.0)
                    break
                case 1:
                    //rgb(66,165,245)青
                    //rgb(21,101,192)濃い青
                    centerPoint.backgroundColor = UIColor(red: 21/255.0, green: 101/255.0, blue: 192/255.0, alpha: 1.0)
                    break
                case 2:
                    //rgb(255,238,88)黄
                    //rgb(249,168,37)濃い黄
                    centerPoint.backgroundColor = UIColor(red: 249/255.0, green: 168/255.0, blue: 37/255.0, alpha: 1.0)
                    break
                case 3:
                    //rgb(255,167,38)オレンジ
                    //rgb(239,108,0)濃いオレンジ
                    centerPoint.backgroundColor = UIColor(red: 239/255.0, green: 108/255.0, blue: 0/255.0, alpha: 1.0)
                    
                    break
                case 4:
                    //rgb(126,87,194)むらさき
                    //rgb(69,39,160)濃いむらさき
                    centerPoint.backgroundColor = UIColor(red: 69/255.0, green: 39/255.0, blue: 160/255.0, alpha: 1.0)
                    break
                default:
                    centerPoint.backgroundColor = defaultColor
                    break
            }
            
            centerPoint.tag = 400//重心
            self.view.addSubview(centerPoint)
            
        }
        
        //クラスタに所属するデータ達を出力する
        for(var label:Int = 0 ; label < finalClusters.count ; label++){
            
            print("Cluster[\(label)] data: ")
            for var i = 0; i < pointData.count; i++ {
                if labels[i] == label {
                    print("(\(pointData[i][0]),\(pointData[i][1]))")
                    let x:CGFloat = CGFloat(pointData[i][0])
                    let y:CGFloat = CGFloat(pointData[i][1])
                    
                    let point:UIView = UIView(frame: CGRectMake(x,y,15,15))
                    
                    switch label{
                        case 0:
                            //rgb(239,83,80)赤
                            point.backgroundColor = UIColor(red: 239/255.0, green: 83/255.0, blue: 80/255.0, alpha: 1.0)
                            break
                        case 1:
                            //rgb(66,165,245)水色
                            point.backgroundColor = UIColor(red: 66/255.0, green: 165/255.0, blue: 245/255.0, alpha: 1.0)
                            break
                        case 2:
                            //rgb(255,238,88)黄色
                            point.backgroundColor = UIColor(red: 255/255.0, green: 238/255.0, blue: 88/255.0, alpha: 1.0)
                            break
                        case 3:
                            //rgb(255,167,38)オレンジ
                            point.backgroundColor = UIColor(red: 255/255.0, green: 167/255.0, blue: 38/255.0, alpha: 1.0)
                            break
                        case 4:
                            //rgb(126,87,194)むらさき
                            point.backgroundColor = UIColor(red: 126/255.0, green: 87/255.0, blue: 194/255.0, alpha: 1.0)
                            break
                        default:
                            point.backgroundColor = defaultColor
                            break
                    }
                    
                    point.tag = 200//クラスタリングされたデータ達
                    //viewを丸く
                    point.layer.cornerRadius = point.frame.size.width/2.0
                    point.layer.masksToBounds = true
                    self.view.addSubview(point)
                    
                }
            }
        }

        
    }
    
    
    //リセットするボタン
    @IBAction func ResetButton(sender: AnyObject) {
        
        print("RESET")
        
        ResetButton.backgroundColor = UIColor(red: 126/255.0, green: 87/255.0, blue: 194/255.0, alpha: 1.0)
        GenerateButton.backgroundColor = defaultColor
        SelectButton.backgroundColor = defaultColor
        ClusteringButton.backgroundColor = defaultColor
        
        isGenelate = false
        isSelect = false
        
        GenerateButton.enabled = true
        GenerateButton.alpha = 1.0
        
        SelectButton.enabled = false
        SelectButton.alpha = 0.5
        
        ClusteringButton.enabled = false
        ClusteringButton.alpha = 0.5
        
        
        let subviews = self.view.subviews
        //消去
        for subview in subviews {
            if subview.tag == 100 || subview.tag == 200 || subview.tag == 300 || subview.tag == 400 {
                subview.removeFromSuperview()
            }
        }
        
        //初期化
        pointData = []
        pointInitialClusters = []
        
    }
    
    
    //タッチ箇所検出
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if isGenelate{
            
            SelectButton.enabled = true
            SelectButton.alpha = 1.0
            
            ResetButton.enabled = true
            ResetButton.alpha = 1.0
            
            for touch in touches{
                let location = touch.locationInView(self.view)
                
                pointData.append([Double(location.x),Double(location.y)])
                
                let point:UIView = UIView(frame: CGRectMake(location.x,location.y,15,15))
                point.backgroundColor = defaultColor
                point.userInteractionEnabled = true
                point.tag = 100//データ達
                //viewを丸く
                point.layer.cornerRadius = point.frame.size.width/2.0
                point.layer.masksToBounds = true
                
                //タップされたら呼び出し設定
                point.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "Selected:"))
                
                self.view.addSubview(point)
                
            }
        }
    }
    
    //View選択検出
    func Selected(gesture: UIGestureRecognizer) {
        
        if isSelect{
            
            if gesture.view!.tag == 300{
                print("重複")
                
            }else{
                
                ClusteringButton.enabled = true
                ClusteringButton.alpha = 1.0
            
                if let selectView = gesture.view{
                    
                    switch count{
                        case 0:
                            //rgb(239,83,80)赤
                            //rgb(198,40,40)濃い赤
                            selectView.backgroundColor = UIColor(red: 198/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1.0)
                            break
                        case 1:
                            //rgb(66,165,245)青
                            //rgb(21,101,192)濃い青
                            selectView.backgroundColor = UIColor(red: 21/255.0, green: 101/255.0, blue: 192/255.0, alpha: 1.0)
                            break
                        case 2:
                            //rgb(255,238,88)黄
                            //rgb(249,168,37)濃い黄
                            selectView.backgroundColor = UIColor(red: 249/255.0, green: 168/255.0, blue: 37/255.0, alpha: 1.0)
                            break
                        case 3:
                            //rgb(255,167,38)オレンジ
                            //rgb(239,108,0)濃いオレンジ
                            selectView.backgroundColor = UIColor(red: 239/255.0, green: 108/255.0, blue: 0/255.0, alpha: 1.0)
                            
                            break
                        case 4:
                            //rgb(126,87,194)むらさき
                            //rgb(69,39,160)濃いむらさき
                            selectView.backgroundColor = UIColor(red: 69/255.0, green: 39/255.0, blue: 160/255.0, alpha: 1.0)
                            break
                        default:
                            selectView.backgroundColor = defaultColor
                            break
                    }
                    selectView.tag = 300//初期点
                    //配列に追加
                    pointInitialClusters.append([Double(selectView.frame.origin.x),Double(selectView.frame.origin.y)])
                    count++
                }
            }
        }
        
    }
    
    //k-means
    func kMeans(data: [[Double]], clusters: [[Double]], minChange: Double) -> ([[Double]], [Int]) {
        var prevClusters = clusters
        var newClusters = [[Double]](count: prevClusters.count, repeatedValue: [0.0, 0.0])
        var changed = true
        var labels: [Int]?
        
        //クラスタに所属するデータ達が変化するまで繰り返す
        while changed {
            //クラスタ分けする
            labels = assignLabels(data, clusters: prevClusters)
            
            //新しく分けたクラスタの重心（平均）を計算する
            //クラスタごとに
            for var i = 0; i < prevClusters.count; i++ {
                var mean = [0.0, 0.0]
                var count = 0
                //所属するものを足し合わせて
                for var j = 0; j < data.count; j++ {
                    if labels![j] == i {
                        mean[0] += data[j][0]
                        mean[1] += data[j][1]
                        count += 1
                    }
                }
                //平均を求める
                newClusters[i][0] = mean[0] / Double(count)
                newClusters[i][1] = mean[1] / Double(count)
            }
            changed = false
            
            //クラスタに所属するデータ達が変化してるかどうかを調べる
            for var i = 0; i < prevClusters.count; i++ {
                if distance(prevClusters[i], b: newClusters[i]) >= minChange {
                    changed = true
                    break
                }
            }
            
            prevClusters = newClusters
        }
        
        return (newClusters, labels!)
    }

    
    //ラベル付け
    func assignLabels(data: [[Double]], clusters: [[Double]]) -> ([Int]) {
       
        // データ達分0が入っている配列を用意
        var labels = [Int](count: data.count, repeatedValue: 0)
        
        // Find the cluster closest to this data and assign it
        // as the new label
        for var i = 0; i < data.count; i++ {
            var minDistance = Double(Int64.max)
            //クラスタの中心の数分まわして
            for var j = 0; j < clusters.count; j++ {
                //距離が最小のものを探す
                let dist = distance(data[i], b: clusters[j])
                if dist < minDistance {
                    minDistance = dist
                    labels[i] = j
                }
            }
        }
        //ラベルを返す
        return labels
    }
    
    
    //距離
    func distance(a: [Double], b: [Double]) -> (Double) {
        return sqrt(pow(a[0]-b[0], 2) + pow(a[1]-b[1], 2))
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

