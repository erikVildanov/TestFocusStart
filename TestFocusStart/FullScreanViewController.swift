//
//  FullScreanViewController.swift
//  TestFocusStart
//
//  Created by Эрик Вильданов on 07.03.17.
//  Copyright © 2017 Эрик Вильданов. All rights reserved.
//

import UIKit

class FullScreanViewController: UIViewController, UIScrollViewDelegate {

    var image = UIImage()
    let fullScreanView = FullScreanView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "FullScreanImage"
        view = fullScreanView
        
        fullScreanView.scrollView.delegate = self
        
        initializeImageView()
        setupGestureRecognizer()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initializeImageView(){
        
        fullScreanView.imageView.image = image
        fullScreanView.imageView.contentMode = UIViewContentMode.center
        fullScreanView.imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        fullScreanView.scrollView.contentSize = image.size
        
        let scrollViewFrame = fullScreanView.scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / fullScreanView.scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / fullScreanView.scrollView.contentSize.height
        let minScale = min(scaleHeight, scaleWidth)
        
        fullScreanView.scrollView.minimumZoomScale = minScale
        fullScreanView.scrollView.maximumZoomScale = 1
        fullScreanView.scrollView.zoomScale = minScale
        
        centerScrollViewContents()
        
    }
    
    func centerScrollViewContents(){
        let boundsSize = fullScreanView.scrollView.bounds.size
        var contentsFrame = fullScreanView.imageView.frame
        
        if contentsFrame.size.width < boundsSize.width{
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2
        }else{
            contentsFrame.origin.x = 0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2
        }else{
            contentsFrame.origin.y = 0
        }
        self.fullScreanView.imageView.frame = contentsFrame
        
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return fullScreanView.imageView
    }
    
    func setupGestureRecognizer() {
        fullScreanView.imageView.isUserInteractionEnabled = true
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        fullScreanView.imageView.addGestureRecognizer(doubleTap)
    }
    
    func handleDoubleTap() {
        if fullScreanView.scrollView.zoomScale > fullScreanView.scrollView.minimumZoomScale {
            fullScreanView.scrollView.setZoomScale(fullScreanView.scrollView.minimumZoomScale, animated: true)
        } else {
            fullScreanView.scrollView.setZoomScale(fullScreanView.scrollView.maximumZoomScale, animated: true)
        }
    }


}
