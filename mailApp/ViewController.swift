//
//  ViewController.swift
//  mailApp
//
//  Created by Mahmoud on 9/12/17.
//  Copyright © 2017 Mahmoud. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate{
     
     let mailVC = MFMailComposeViewController()
     
     @IBOutlet weak var nameTextField: UITextField!
     @IBOutlet weak var cream: UISwitch!
     @IBOutlet weak var chocolate: UISwitch!
     @IBOutlet weak var quantityLabel: UILabel!
     
     var dataArray = [String: String]()
     var price = 0
     var itemPrice = 5
     var addCream = 0
     var addChocolate = 0
     
     @IBAction func quantityChanged(_ sender: UIStepper) {
          if sender.value >= 1 {
               quantityLabel.text = "\(Int(sender.value))"
          }
     }
     
     func getOrderDetails() -> [String]{
          
          if let username = nameTextField.text{
               if username != ""{
                    dataArray["username"] = username
               }else{
                    let alert = UIAlertController(title: "Wrong input", message: "Please enter your name", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(action)
                    present(alert, animated: true, completion: nil)
               }
          }
          
          if cream.isOn{
               addCream = 2
          }else{
               addCream = 0
          }
          if chocolate.isOn{
               addChocolate = 3
          }else{
               addChocolate = 0
          }
          
          price = (itemPrice + addCream + addChocolate)  * Int(quantityLabel.text!)!
          
          dataArray["price"] = "\(price)"
          
          guard let finalPrice = dataArray["price"], let name = dataArray["username"] else{return [""]}
          return ["\(name)","\(finalPrice)"]
     }
     
     @IBAction func orderButtonTapped(sender: AnyObject) {
          
          let mailComposeViewController = configuredMailComposeViewController()
          
          if MFMailComposeViewController.canSendMail() {
               present(mailComposeViewController, animated: true, completion: nil)
          } else {
               self.showSendMailErrorAlert()
          }
          
     }
     
     func configuredMailComposeViewController() -> MFMailComposeViewController {
          let mailVC = MFMailComposeViewController()
          mailVC.mailComposeDelegate = self
          
          mailVC.setToRecipients(["ma7moud.hany158@gmail.com"])
          if let name = getOrderDetails().first, let price = getOrderDetails().last{
               mailVC.setSubject("Order From \(name)")
               
               mailVC.setMessageBody("\(name) Ordered coffee for \(price)$", isHTML: true)
          }
          return mailVC
     }
     
     
     func showSendMailErrorAlert() {
          let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check e-mail configuration and try again.", preferredStyle: .alert)
          let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
          sendMailErrorAlert.addAction(action)
          present(sendMailErrorAlert, animated: true, completion: nil)
     }
     
     // MARK: MFMailComposeViewControllerDelegate
     
     func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
          
          switch result{
          case .cancelled:
               controller.dismiss(animated: true, completion: nil)
               break
          case .saved:
               controller.dismiss(animated: true, completion: nil)
               break
          case .failed:
               controller.dismiss(animated: true, completion: nil)
               break
          case .sent:
               controller.dismiss(animated: true, completion: nil)
               break
          }
     }
     
     
}













