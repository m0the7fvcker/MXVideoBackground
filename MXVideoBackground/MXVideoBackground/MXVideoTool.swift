//
//  MXVideoTool.swift
//  MXVideoBackground
//
//  Created by maRk on 2017/5/31.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit
import AVFoundation

class MXVideoTool: NSObject {
    class func cropVideoWith(url: URL, startTime: CGFloat, duration: CGFloat, completion:@escaping (_ url: URL?, _ error: Error?) -> ()?) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            var outputUrl = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray).firstObject as! String
            
            let fileManager = FileManager.default
            
            do {
                try fileManager.createDirectory(atPath: outputUrl, withIntermediateDirectories: true, attributes: nil)
                } catch _ {
            }
            outputUrl = (outputUrl as NSString).appendingPathComponent("output.mp4")
            do {
                try fileManager.removeItem(atPath: outputUrl)
                } catch _ {
            }
            
            if let exportSession = exportSession as AVAssetExportSession? {
                exportSession.outputURL = URL(fileURLWithPath: outputUrl)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileTypeMPEG4
                let start = CMTimeMakeWithSeconds(Float64(startTime), 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), 600)
                let range = CMTimeRangeMake(start, duration)
                exportSession.timeRange = range
                
                exportSession.exportAsynchronously {
                    switch exportSession.status {
                        
                    case AVAssetExportSessionStatus.completed:
                        completion(exportSession.outputURL, nil)
                    case AVAssetExportSessionStatus.failed:
                        print("Failed: \(exportSession.error!)")
                    case AVAssetExportSessionStatus.cancelled:
                        print("Failed: \(exportSession.error!)")
                    default:
                        print("DefaultCase")
                    }
                    
                }
            }
        }
            
    }
}


