//
//  newCellTableViewCell.swift
//  toDoList2
//
//  Created by Anastasia on 14/04/24.
//

import UIKit

protocol newCellDelegate: AnyObject {
    func noteIsDone(cell: newCellTableViewCell)
}

class newCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    
    weak var delegate: newCellDelegate?
    
    var text1: String = ""
    var note: Note!
    
    func addNote(note: Note, isCompleted: Bool) {
        
        let setImage = isCompleted ? "checkmark.circle.fill" : "checkmark.circle"
        
        firstTitle.textColor = .black
        firstTitle.textAlignment = .left
        firstTitle.numberOfLines = 2
        firstTitle.font = .monospacedSystemFont(ofSize: 20, weight: .regular)
        firstTitle.text = text1
        
        secondTitle.textColor = .systemGray
        secondTitle.textAlignment = .left
        secondTitle.numberOfLines = 1
        secondTitle.font = .systemFont(ofSize: 13, weight: .thin)
        
        groupImage.tintColor = .black
        
        let checkmark = UIButton(type: .custom)
        checkmark.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        checkmark.setImage(UIImage(systemName: setImage), for: .normal)
        checkmark.tintColor = .black
        checkmark.addTarget(self, action: #selector(checkmarkDone), for: .touchUpInside)
        accessoryView = checkmark
        
        let attrString = NSMutableAttributedString(string: note.title)
        attrString.addAttributes([
            .foregroundColor: UIColor.systemBlue
        ], range: NSRange(location: .zero, length: 1))
        attrString.addAttributes([
            .font: UIFont(name: "Phosphate", size: 20)!
        ], range: NSRange(location: .zero, length: attrString.string.count))
        firstTitle.attributedText = attrString
        secondTitle.text = note.group
        groupImage.image = note.image
        
    }
    
    @objc private func checkmarkDone(_ sender: UIButton) {
    
        delegate?.noteIsDone(cell: self)
        
        sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        sender.tintColor = .black
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
    

