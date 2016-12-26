//
//  TableViewCell.swift
//  StoreApp
//
//  Created by Cyberk on 12/4/16.
//  Copyright © 2016 Cyberk. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var priceCell: UILabel!
    @IBOutlet weak var DetailsCell: UILabel!
    
    
    func configureCell(item:Item){
        titleCell.text = item.title
        priceCell.text = "$\(item.price)"
        DetailsCell.text = item.detials
        let imagename = item.toImage?.imagePath
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(imagename!)
        print(imagePAth)
        if fileManager.fileExists(atPath: imagePAth){
            self.imageCell.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }


}
