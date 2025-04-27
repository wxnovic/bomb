//
//  Untitled.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//

import SwiftUI
import UIKit

struct GIFImageView: UIViewRepresentable {
    let gifName: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        if let path = Bundle.main.path(forResource: gifName, ofType: "gif"),
           let data = NSData(contentsOfFile: path) as Data?,
           let source = CGImageSourceCreateWithData(data as CFData, nil) {
            
            var images = [UIImage]()
            let count = CGImageSourceGetCount(source)
            
            for i in 0..<count {
                if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    images.append(UIImage(cgImage: cgImage))
                }
            }
            
            imageView.animationImages = images
            imageView.animationDuration = Double(count) * 0.1 // 각 프레임당 0.1초
            imageView.startAnimating()
        }
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {}
}
