//
//  NewPatientMedicalIDViewController.swift
//  HosaProject
//
//  Created by Darvyn Martinez on 2/10/19.
//  Copyright © 2019 Darvyn Martinez. All rights reserved.
//

import UIKit

class NewPatientMedicalIDViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //outlets and actions regarding profile picture
    @IBOutlet weak var profilePictureImage: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func importImage(_ sender: AnyObject) {
       imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //pickerviews for gender selection
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorityTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorityTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = priorityTypes[row]
        sexField.text = selectedPriority
        
        if selectedPriority == "Custom" {
            sexField.inputView = nil
        }
    }
    
    var selectedPriority : String?
    
    var priorityTypes = ["Male", "Female","Custom"]
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        sexField.inputView = pickerView
    }
    
    //return action
    @IBAction func goBackOnKeyboardButton(_ sender: UITapGestureRecognizer) {
        nameField.resignFirstResponder()
        dateOfBirthField.resignFirstResponder()
        ageField.resignFirstResponder()
        sexField.resignFirstResponder()
        condition1Field.resignFirstResponder()
        condition2Field.resignFirstResponder()
        condition3Field.resignFirstResponder()
        condition1DiagnosisDate.resignFirstResponder()
        condition2DiagnosisDate.resignFirstResponder()
        condition3DiagnosisDate.resignFirstResponder()
        contact1Field.resignFirstResponder()
        contact1phonenumberField.resignFirstResponder()
        contact2Field.resignFirstResponder()
        contact2PhoneNumberField.resignFirstResponder()
    }
    //textfields
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateOfBirthField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    //conditions
    @IBOutlet weak var condition1Field: UITextField!
    @IBOutlet weak var condition2Field: UITextField!
    @IBOutlet weak var condition3Field: UITextField!
    @IBOutlet weak var condition1Image: UIImageView!
    @IBOutlet weak var condition2Image: UIImageView!
    @IBOutlet weak var condition3Image: UIImageView!
    @IBOutlet weak var condition1DiagnosisDate: UITextField!
    @IBOutlet weak var condition2DiagnosisDate: UITextField!
    @IBOutlet weak var condition3DiagnosisDate: UITextField!
    //contacts
    @IBOutlet weak var contact1Field: UITextField!
    @IBOutlet weak var contact1phonenumberField: UITextField!
    @IBOutlet weak var contact2Field: UITextField!
    @IBOutlet weak var contact2PhoneNumberField: UITextField!
    
    
    
    //UIDatePicker var
    private var datePicker: UIDatePicker?
    
    
    //not too sure what this stuff is
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //code for profile image
        profilePictureImage.layer.cornerRadius = profilePictureImage.frame.size.width / 2
        profilePictureImage.clipsToBounds = true
        
        imagePicker.delegate = self
        
        //code to initiate UIDatePicker
        createPickerView()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(NewPatientMedicalIDViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        
        dateOfBirthField.inputView = datePicker
        condition1DiagnosisDate.inputView = datePicker
        condition2DiagnosisDate.inputView = datePicker
        condition3DiagnosisDate.inputView = datePicker
        
        //code for large title
self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //code for saving name
        if let name = UserDefaults.standard.string(forKey: "name") {
            nameField.text = name
        }
        
        if let dateOfBirth = UserDefaults.standard.string(forKey: "dateOfBirth") {
            dateOfBirthField.text = dateOfBirth
        }
        
        if let sex = UserDefaults.standard.string(forKey: "sex") {
            sexField.text = sex
        }
        
        
        
    }
    
    @IBAction func dateOfBirthFieldPressed(_ sender: Any) {
        datePicker?.tag = 0
    }
    
    @IBAction func condition1DiagnosisDatePressed(_ sender: Any) {
        datePicker?.tag = 1
    }
    
    @IBAction func conditions2DiagnosisDatePressed(_ sender: Any) {
        datePicker?.tag = 2
    }
    
    @IBAction func condition3DiagnosisDatePressed(_ sender: Any) {
        datePicker?.tag = 3
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        if datePicker.tag == 0 {
            dateOfBirthField.text = dateFormatter.string(from: datePicker.date)
            ageField.text = String(calcAge(birthday: dateFormatter.string(from: datePicker.date)))
        } else if datePicker.tag == 1 {
            condition1DiagnosisDate.text = dateFormatter.string(from: datePicker.date)
        } else if datePicker.tag == 2 {
            condition2DiagnosisDate.text = dateFormatter.string(from: datePicker.date)
        } else if datePicker.tag == 3 {
            condition3DiagnosisDate.text = dateFormatter.string(from: datePicker.date)
        }
    }
    
    
    //action to save userdata
    @IBAction func nameField(_ sender: UITextField) {
        UserDefaults.standard.set(sender.text!, forKey: "name")
    }
    
    
    @IBAction func dateOfBirthField(_ sender: UITextField) {
        UserDefaults.standard.set(sender.text!, forKey: "dateOfBirth")
       
    }
    
    @IBAction func sexField(_ sender: UITextField) {
        UserDefaults.standard.set(sender.text!, forKey: "sex")
    }
    
    //actions to change imageview after setting condition
    @IBAction func condition1Field(_ sender: UITextField) {
        if condition1Field.text?.lowercased() == "type 1 Diabetes" {
            condition1Image.image = UIImage(named: "diabetes")
        }
        
        if condition1Field.text?.lowercased() == "hypertension" {
            condition1Image.image = UIImage(named: "hypertension")
        }
        
        if condition1Field.text?.lowercased() == "asthma" {
            condition1Image.image = UIImage(named: "asthma")
        }
        
        if condition1Field.text?.lowercased() == "anemia" {
            condition1Image.image = UIImage(named: "anemiaIcon")
        }
    }
    
}
//stuff for changing profile picture
extension NewPatientMedicalIDViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            profilePictureImage.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}

func calcAge(birthday: String) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let birthdayDate = dateFormatter.date(from: birthday)
    let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
    let now = Date()
    let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
    let age = calcAge.year
    return age!
}
