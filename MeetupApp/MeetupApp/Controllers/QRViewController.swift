//
//  QRViewController.swift
//  MeetupApp
//
//  Created by Gerardo Castillo Duran  on 1/5/19.
//  Copyright © 2019 Gerardo. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgQR: UIImageView!
    @IBOutlet weak var lblContador: UILabel!
    var name:String = ""
    var codesQr = [String]()
    var codesQRImages = [UIImage]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = name
        codesQRImages = fromStringToImage(codes: codesQr)
        imgQR.image = codesQRImages[0]
        lblContador.text = " 1 / \(codesQRImages.count )"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblTitle.text = name
        codesQRImages = fromStringToImage(codes: codesQr)
        imgQR.image = codesQRImages[0]
        lblContador.text = " 1 / \(codesQRImages.count )"
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        print("Izquierda")
        if codesQRImages.count == 1{
            imgQR.image = codesQRImages[0]
            lblContador.text = " 1 / \(codesQRImages.count )"
        }else{
            if codesQRImages.count - 1 == index{
                index = 0
                imgQR.image = codesQRImages[index]
                lblContador.text = " \(index + 1) / \(codesQRImages.count )"
            }else{
                index += 1
                imgQR.image = codesQRImages[index]
                lblContador.text = " \(index + 1) / \(codesQRImages.count )"
                
            }
        }
        print(index)
    }
    
    @IBAction func swipeRigth(_ sender: UISwipeGestureRecognizer) {
        print("Derecha")
        if codesQRImages.count == 1{
            imgQR.image = codesQRImages[0]
            lblContador.text = " 1 / \(codesQRImages.count )"
        }else{
            if index == 0{
                index = codesQRImages.count - 1
                imgQR.image = codesQRImages[index]
                lblContador.text = " \(index + 1) / \(codesQRImages.count )"
            }else{
                index -= 1
                imgQR.image = codesQRImages[index]
                lblContador.text = " \(index + 1) / \(codesQRImages.count )"
                
            }
        }
        print(index)
        
    }
    
    func fromStringToImage(codes: [String]) -> [UIImage]{
        var images = [UIImage]()
        for code in codes{
            images.append(CodigoQR.generateQRCode(from: code)!)
        }
        return images
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
