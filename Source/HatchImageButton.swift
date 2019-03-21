//
//  HatchImageButton.swift
//  Hatch
//
//  Created by Анатолий on 21/03/2019.
//  Copyright © 2019 Anatoliy. All rights reserved.
//

import UIKit

public final class HatchImageButton: HatchElementProtocol {
    
    var image: UIImage?
    
    var size: CGSize
    
    var edgeInset: UIEdgeInsets
    
    var inBoundsEdgeInsets: UIEdgeInsets
    
    var action: Selector
    
    init(image: UIImage?,
         size: CGSize,
         edgeInset: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
         inBoundsEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
         action: Selector)
    {
        self.image = image
        self.size = size
        self.edgeInset = edgeInset
        self.inBoundsEdgeInsets = inBoundsEdgeInsets
        self.action = action
    }
}
