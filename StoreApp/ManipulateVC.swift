//
//  ManipulateVC.swift
//  StoreApp
//
//  Created by Cyberk on 12/4/16.
//  Copyright © 2016 Cyberk. All rights reserved.
//

import UIKit

class ManipulateVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var NewImage: UIImageView!
    @IBOutlet weak var NewTitleFeild: UITextField!
    @IBOutlet weak var NewDetails: UITextField!
    @IBOutlet weak var NewPrice: UITextField!
    
    var imagePicker: UIImagePickerController!
    var itemEdit:Item?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        //set back button no title
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        
        //check if it edit or not to load currentdata or not
        if itemEdit != nil{
            loadData()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Brow Image from Library=========================================================================================
    @IBAction func loadImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            NewImage.image = img
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //func for load current data======================================================================================
    func loadData(){
        if let item = itemEdit {
            NewTitleFeild.text = item.title
            NewPrice.text = "\(item.price)"
            NewDetails.text = item.detials
            //load image from document
            let imagename = item.toImage?.imagePath
            let fileManager = FileManager.default
            let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(imagename!)
            if fileManager.fileExists(atPath: imagePAth){
                self.NewImage.image = UIImage(contentsOfFile: imagePAth)
            }else{
                print("No Image")
            }
        }
    }
    //func to save Data==============================================================================================
    @IBAction func saveData(_ sender: Any) {
        var newitem: Item!
        let picture = Image(context: context)
        
        if let image = NewImage.image {
            if let data = UIImageJPEGRepresentation(image, 0.8) {
                let fileManager = FileManager.default
                //let MyPhoto = getDocumentsDirectory()
                let imagename = "\(UUID()).jpg"
                let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imagename)
                fileManager.createFile(atPath: paths as String, contents: data, attributes: nil)
                print(paths)
                picture.imagePath = imagename
            }}
        if itemEdit == nil{
            newitem = Item(context: context)
        }else {
            newitem = itemEdit
        }
        newitem.toImage = picture
        let created = NSDate()
        newitem.created = created
        if let title = NewTitleFeild.text {
            newitem.title = title
        }
        if let price = NewPrice.text{
            newitem.price = (price as NSString).doubleValue
        }
        if let details = NewDetails.text {
            newitem.detials = details
        }
        AppDelegateAccess.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    //Delete Data=====================================================================================================
    @IBAction func deleteData(_ sender: Any) {
        if itemEdit != nil{
            context.delete(itemEdit!)
            AppDelegateAccess.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    // get Document Directory=========================================================================================
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}
