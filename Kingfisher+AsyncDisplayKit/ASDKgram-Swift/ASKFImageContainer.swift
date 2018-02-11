//
//  ASKFImageContainer.swift
//  ASDKgram-Swift
//
//  Created by Cuong Nguyen on 2/11/18.
//  Copyright © 2018 Calum Harris. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ASKFImageContainer: NSObject, ASImageContainerProtocol {
    var image: UIImage?
    
    init(image: UIImage?) {
        self.image = image
    }
    
    func asdk_image() -> UIImage? {
        return self.image
    }
    
    func asdk_animatedImageData() -> Data? {
        if let image = self.image {
            return UIImagePNGRepresentation(image)
        }
        return nil
    }
}
