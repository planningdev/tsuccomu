//
//  AVAudioPlayerUtil.swift
//  Tsuccomu
//
//  Created by kazuma maekawa on 2015/12/07.
//  Copyright © 2015年 speechrec. All rights reserved.
//

import Foundation
import AVFoundation

class AVAudioPlayerUtil:NSObject {
    
    static var audioPlayer:AVAudioPlayer = AVAudioPlayer();
    static var sound_data:NSURL = NSURL();
    
    static func setValue(nsurl:NSURL){
        
        
        self.sound_data = nsurl;
        
        do{
            self.audioPlayer = try AVAudioPlayer(contentsOfURL: self.sound_data)
            self.audioPlayer.prepareToPlay()
            
        }catch let error as NSError {


            print(error)

        }
        

    }
    
    static func play(){
        self.audioPlayer.play();
        //sleep(1)
    }
}