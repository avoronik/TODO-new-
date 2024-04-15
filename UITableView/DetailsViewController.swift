//
//  DetailsViewController.swift
//  UITableView
//
//  Created by Anastasia on 10/03/24.
//

import UIKit

protocol DetailsViewControllerDelegate: AnyObject {
    
    func save(data: Note)
}

class DetailsViewController: UIViewController {
    
    
    weak var delegate: DetailsViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
    
    var segment = UISegmentedControl()
    
    var imageArray: [UIImage] = [ UIImage(systemName: "cart.fill")!,
                                  UIImage(systemName:       "graduationcap.fill")!,
                                  UIImage(systemName: "bag.fill")!,
                                  UIImage(systemName: "creditcard.fill")!,
                                  UIImage(systemName: "washer.fill")!,
                                  UIImage(systemName: "popcorn.fill")!]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupSegmentedControll()
        
    }
    
    
    @IBAction func saveData(_ sender: UIButton) {
        if let name = textField.text, !name.isEmpty {
            let index = segment.selectedSegmentIndex
            let image: UIImage = imageArray[index]
            let groupName = group[index]
            let note = Note(title: name, image: image, group: groupName, isCompleted: false)

            
            delegate?.save(data: note)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
    
    private extension DetailsViewController {
        
        func setupSegmentedControll() {
            
            self.segment = UISegmentedControl(items: self.imageArray)
            segment.translatesAutoresizingMaskIntoConstraints = false
            self.segment.selectedSegmentIndex = 0
            segment.sendActions(for: .valueChanged)
            
            view.addSubview(segment)
            
            NSLayoutConstraint.activate([
                
                segment.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -50),
                segment.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                segment.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
                segment.heightAnchor.constraint(equalToConstant: 30)
            ])
            
            segment.setImage(imageArray[0], forSegmentAt: 0)
            segment.setImage(imageArray[1], forSegmentAt: 1)
            segment.setImage(imageArray[2], forSegmentAt: 2)
            segment.setImage(imageArray[3], forSegmentAt: 3)
            segment.setImage(imageArray[4], forSegmentAt: 4)
            segment.setImage(imageArray[5], forSegmentAt: 5)
            
        }
    }
    

