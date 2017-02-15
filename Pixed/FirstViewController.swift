//
//  FirstViewController.swift
//  Pixed
//
//  Created by Nishanth P on 1/23/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import UIKit
import CoreImage
import CoreGraphics



class FirstViewController: UIViewController {
    

    @IBOutlet weak var filteredImage: UIImageView!
    @IBOutlet weak var filterOptions: UIScrollView!
    
    var swiped : Bool = false
    var lastPoint : CGPoint = CGPoint.zero
    var currentPoint : CGPoint = CGPoint.zero
    
    var cropView : UIView!
    
    func filterButtonTapped(sender: UIButton) {
        let button = sender as UIButton
        
        filteredImage.image = button.backgroundImage(for: UIControlState.normal)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tabBarController?.tabBar.tintColor = UIColor.white
        
        var CIFilters = [ "Chrome","Fade","Instant","Noir","Process","Tonal","Transfer","Sepia"]
        
        var CIFilterNames = [
            "CIPhotoEffectChrome",
            "CIPhotoEffectFade",
            "CIPhotoEffectInstant",
            "CIPhotoEffectNoir",
            "CIPhotoEffectProcess",
            "CIPhotoEffectTonal",
            "CIPhotoEffectTransfer",
            "CISepiaTone",
            
        ]
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 70
        let buttonHeight: CGFloat = 70
        let gapBetweenButtons: CGFloat = 5
        
        var itemCount = 0
        
        for i in 0..<CIFilterNames.count {
            itemCount = i
            
            
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x:xCoord,y:yCoord,width:buttonWidth,height:buttonHeight)
            filterButton.tag = itemCount
            filterButton.addTarget(self, action: #selector(self.filterButtonTapped(sender:)), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: filteredImage.image!)
            let filter = CIFilter(name: "\(CIFilterNames[i])" )
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
            let imageForButton = UIImage(cgImage: filteredImageRef!);
            filterButton.setBackgroundImage(imageForButton, for: .normal)
            filterButton.setTitle("\(CIFilters[i])",for: .normal)
            filterButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-light", size:12)
            
            // Add Buttons in the Scroll View
            xCoord +=  buttonWidth + gapBetweenButtons
            filterOptions.addSubview(filterButton)
            filterOptions.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+2),height:yCoord)
           
                    }
        
        let frameCrop = CGRect(x:16,y:70,width:343,height:441)
        cropView = UIView(frame:frameCrop)
        cropView.tag = 0
        cropView.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(cropView)
    }
    
    func crop() {
        
        
        
    }
    
    
    func draw2d(from:CGPoint,to:CGPoint) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(4.0)
        context?.setStrokeColor(UIColor.blue.cgColor)
        let rectangle = CGRect(x: from.x,y:from.y,width: to.x,height: to.y)
        context?.addRect(rectangle)
        context?.strokePath()


        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.tintColor = UIColor.white
        self.tabBarController?.tabBar.backgroundColor = UIColor.clear
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        swiped = false
        if let touch = touches.first{
            lastPoint = touch.location(in:self.filteredImage)
            print(lastPoint)
        }
       
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = true
        if let touch = touches.first{
            currentPoint = touch.location(in:self.filteredImage)
            draw2d(from: lastPoint, to: currentPoint)
            //lastPoint = currentPoint
            
        }

        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped{
            
            draw2d(from: lastPoint, to: currentPoint)
            
        }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x:posX, y:posY,width:cgwidth,height:cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

