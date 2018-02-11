//
//  ASKFImageManager.swift
//  ASDKgram-Swift
//
//  Created by Cuong Nguyen on 2/11/18.
//  Copyright © 2018 Calum Harris. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit
import Kingfisher

class ASKFImageManager: NSObject, ASImageCacheProtocol, ASImageDownloaderProtocol {
    
    static let shareInstance: ASKFImageManager = ASKFImageManager()
    
    // CacheImageProtocol
    
    func cachedImage(with URL: URL, callbackQueue: DispatchQueue, completion: @escaping ASImageCacherCompletion) {
        let image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: URL.absoluteString)
        completion(ASKFImageContainer(image: image))
    }
    
    // DownloadImageProtocol
    
    func downloadImage(with URL: URL, callbackQueue: DispatchQueue, downloadProgress: ASImageDownloaderProgress?, completion: @escaping ASImageDownloaderCompletion) -> Any? {
        var weakImageTask: RetrieveImageTask?
        let imageTask = KingfisherManager.shared.retrieveImage(with: URL, options: nil, progressBlock: { (recivedSize, totalSize) in
            downloadProgress?(CGFloat(recivedSize) / CGFloat(totalSize))
        }) { (image, error, typ, url) in
            completion(ASKFImageContainer(image: image), error, weakImageTask)
        }
        weakImageTask = imageTask
        return imageTask
    }
    
    func cancelImageDownload(forIdentifier downloadIdentifier: Any) {
        if let downloadTask = downloadIdentifier as? RetrieveImageTask {
            downloadTask.cancel()
        }
    }
    
}
