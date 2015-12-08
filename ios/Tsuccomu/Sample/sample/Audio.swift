//
//  Audio.swift
//  Tsuccomu
//
//  Created by kazuma maekawa on 2015/12/08.
//  Copyright © 2015年 speechrec. All rights reserved.
//

import Foundation

class Audio:NSObject,NSURLSessionDownloadDelegate{
    
    
    func Download(array:NSArray,voice_url:NSString)->NSDictionary{
        
        let dict:NSDictionary = NSMutableDictionary()
        
        for arr in array{
            let name = arr as! String
            // 通信のコンフィグを用意
            let myConfig:NSURLSessionConfiguration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("backgroundSession");
            
            // Sessionを作成する
            let mySession:NSURLSession = NSURLSession(
                configuration: myConfig,
                delegate: self,
                delegateQueue: nil);
            
            // ダウンロード先のURLからリクエストを生成
            let myURL:NSURL = NSURL(string: (voice_url as String)+"/"+name)!;
            let myRequest:NSURLRequest = NSURLRequest(URL: myURL);
            
            // ダウンロードタスクを生成
            let myTask:NSURLSessionDownloadTask = mySession.downloadTaskWithRequest(myRequest);
            
            // タスクを実行
            myTask.taskDescription = name
            myTask.resume()
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String

            dict.setValue("\(documentsPath)/\(name)", forKey: name)
        }
        
        return dict
        
    }
    
    
    func MakeDict(array:NSArray,voice_url:NSString)->NSDictionary{
        let dict:NSDictionary = NSMutableDictionary()
        
        for arr in array{
            let name = arr as! String
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            dict.setValue("\(documentsPath)/\(name)", forKey: name)
        }
        
        return dict

    }
    /*
    ダウンロード終了時に呼び出されるデリゲート
    */
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        /* ファイルを保存して，保存したパスを返したい．*/
        
        
        let fileData = NSData(contentsOfURL:location)
        let fileName = downloadTask.taskDescription!
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        //print("\(location)")
        //print("\(documentsPath)/\(fileName)")
        fileData!.writeToFile("\(documentsPath)/\(fileName)", atomically: true)
        
        
        //        AVAudioPlayerUtil.setValue(NSURL(string: "\(documentsPath)/\(fileName)")!);
        //        AVAudioPlayerUtil.play();
    }
    
    /*
    タスク終了時に呼び出されるデリゲート
    */
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        
    }
    
}