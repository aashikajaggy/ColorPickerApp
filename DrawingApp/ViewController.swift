//
//  ViewController.swift
//  DrawingApp
//
//  Created by Aashika Jagadeesh on 8/19/21.
//

import UIKit
import Combine
class ViewController: UIViewController {
    var colorButton1:UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
       var colorButton2:UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
       var colorButton3:UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
       var colorButton4:UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
    }
    var cancellable: AnyCancellable?
    @IBAction func changeColor(_ sender: Any) {
           let picker = UIColorPickerViewController()
           picker.selectedColor = self.view.backgroundColor!
           
           //  Subscribing selectedColor property changes.
           self.cancellable = picker.publisher(for: \.selectedColor)
               .sink { color in
                   
                   //  Changing view color on main thread.
                   DispatchQueue.main.async {
                       if (sender as AnyObject).tag == 1{
                           self.color1.backgroundColor = color
                           self.colorButton1 = color
                       } else if (sender as AnyObject).tag == 2 {
                       self.color2.backgroundColor = color
                           self.colorButton2 = color
                       }else if (sender as AnyObject).tag == 3 {
                           self.color3.backgroundColor = color
                           self.colorButton3 = color
                      }else if (sender as AnyObject).tag == 4 {
                       self.color4.backgroundColor = color
                       self.colorButton4 = color
                       }
                   }
               }
           
           
           self.present(picker, animated: true, completion: nil)
       }
var counter = 1
    @IBAction func switchBackgroundColor(_ sender: Any) {
        if counter == 5 {
                 counter = 1
             }
             if counter == 1 {
                 view.backgroundColor = colorButton1
             } else if counter == 2 {
                 view.backgroundColor = colorButton2
             } else if counter == 3 {
                 view.backgroundColor = colorButton3
             } else if counter == 4 {
                 view.backgroundColor = colorButton4
             }
             counter+=1

    }
    
    
    @IBOutlet weak var color1: UIButton!
    
    @IBOutlet weak var color2: UIButton!
    
    @IBOutlet weak var color3: UIButton!
    

    @IBOutlet weak var color4: UIButton!
    // Presenting the Color Picker
  
}
extension ViewController: UIColorPickerViewControllerDelegate {
    
    //  Called once you have finished picking the color.
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.view.backgroundColor = viewController.selectedColor
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.cancellable?.cancel()
            print(self.cancellable == nil)
        }
    }
    
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            self.view.backgroundColor = viewController.selectedColor
        
    }
    
}


