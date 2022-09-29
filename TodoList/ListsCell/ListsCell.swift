//
//  ListsCell.swift
//  TodoList
//
//  Created by admin on 28/09/2022.
//

import UIKit

class ListsCell: UITableViewCell {
    @IBOutlet private var imgList: UIImageView!
    @IBOutlet private var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgList.contentMode = .scaleToFill
        imgList.layer.cornerRadius = 8
        imgList.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateUI(_ list: Note){
        lbName.text = list.name
        imgList.image = list.img
    }
    

}
