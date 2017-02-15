//
//  BlurViewController.swift
//  Pixed
//
//  Created by Nishanth P on 1/24/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import UIKit


class BlurViewController: UIViewController {
    
    @IBOutlet weak var blurImage: UIImageView!
    @IBOutlet weak var blurScrollView: UIScrollView!
    
    
    func blurButtonTapped(sender: UIButton) {
        let button = sender as UIButton
        
        blurImage.image = button.backgroundImage(for: UIControlState.normal)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var CIBlurNames = [
            
            "CIBoxBlur",
            "CIGaussianBlur",
            "CIMotionBlur",
            "CIMaskedVariableBlur",
            "CIMedianFilter",
            "CINoiseReduction",
            "CIZoomBlur"
        ]
        
        var CIBlur = [ "Box","Gaussian","Motion","Mask","Median","Noise","Zoom"]
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 70
        let buttonHeight: CGFloat = 70
        let gapBetweenButtons: CGFloat = 5
        
        var itemCount = 0
        
        for i in 0..<CIBlurNames.count {
            itemCount = i
            
            
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x:xCoord,y:yCoord,width:buttonWidth,height:buttonHeight)
            filterButton.tag = itemCount
            filterButton.addTarget(self, action: #selector(self.blurButtonTapped(sender:)), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: blurImage.image!)
            let filter = CIFilter(name: "\(CIBlurNames[i])" )
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
            let imageForButton = UIImage(cgImage: filteredImageRef!);
            filterButton.setBackgroundImage(imageForButton, for: .normal)
            filterButton.setTitle("\(CIBlur[i])",for: .normal)
            filterButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-light", size:12)
            // Add Buttons in the Scroll View
            xCoord +=  buttonWidth + gapBetweenButtons
            blurScrollView.addSubview(filterButton)
            blurScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+2),height:yCoord)
            
        }

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
