//
//  ViewController.swift
//  foodremark
//
//  Created by Apple24 on 19/4/22.
//  Copyright © 2019年 zhy. All rights reserved.
//

import UIKit

class AddFoodCotroller: UIViewController ,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate=self
        initWithMeal()
        updateSaveButton()
    }

    private func initWithMeal(){
        if meal != nil {
            nameTextField.text = meal?.name
            photoImage.image = meal?.photo
            ratingControl.rating = meal?.rating ?? 0

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func updateSaveButton(){
        if nameTextField.text == nil || (nameTextField.text?.isEmpty)! {
            saveButton.isEnabled = false
        }
        else{
            saveButton.isEnabled = true
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //print(textField.text)
        updateSaveButton()
        navbar.title = nameTextField.text
    }
    @IBAction func select_photo(_ sender: UITapGestureRecognizer) {
        //print("hello")
        nameTextField.resignFirstResponder()
        let imagePickerController=UIImagePickerController()
        imagePickerController.delegate=self
        imagePickerController.sourceType = . photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var photoImage: UIImageView!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selected = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImage.image=selected
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    var meal :Meal?
    
    @IBAction func cencel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = (presentingViewController is UINavigationController)
        if isPresentingInAddMealMode{
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
            
        }
        else{
            return
        }

    }
    @IBOutlet weak var ratingControl: RatingController!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let button = sender as? UIBarButtonItem,button === saveButton{
            let name = nameTextField.text ?? ""
            let photo = photoImage.image
            let  rating = ratingControl.rating
            
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
    
}

