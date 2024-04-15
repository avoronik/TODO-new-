//
//  ViewController.swift
//  UITableView
//
//  Created by Anastasia on 10/03/24.
//

import UIKit



class ViewController: UIViewController {
   
   
    var newNote: [Note] = []
    var completed: [Note] = []

    
    private var mainTitle: UILabel = {
    var mainTitle = UILabel()
       let getDate = Date()
        let dateFormater: DateFormatter = {
            let dateFormater = DateFormatter()
            dateFormater.dateStyle = DateFormatter.Style.medium
            dateFormater.timeStyle = DateFormatter.Style.short
            return dateFormater
        }()
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.backgroundColor = .clear
        mainTitle.textColor = .black
        mainTitle.text = "\(dateFormater.string(from: getDate))"
        mainTitle.numberOfLines = 2
        mainTitle.font = .monospacedSystemFont(ofSize: 30, weight: .heavy)
        mainTitle.textAlignment = .left
        
        return mainTitle
    }()
  
    
    
    lazy var tableView = makeTableView()
    
    var note: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        setupUI()
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return newNote.count
        } else if section == 1 {
            return completed.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(newCellTableViewCell.self)", for: indexPath) as? newCellTableViewCell else { fatalError("cell not found")
        }
        
        switch indexPath.section {
        case 0:
            
            if indexPath.row < newNote.count {
                let newNoteCell = newNote[indexPath.row]
                cell.addNote(note: newNoteCell
                             , isCompleted: false)
            }
        case 1:

            if  indexPath.row < completed.count {
                let completedCell = completed[indexPath.row]
                cell.addNote(note: completedCell, isCompleted: true)
                
            }
        default:
            let cellDefault = UITableViewCell()
            return cellDefault
        }
        return cell
       
    }
}
    

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell selected: section \(indexPath.section), row: \(indexPath.row)")
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch indexPath.section {
            case 0:
                newNote.remove(at: indexPath.row)
               
            case 1:
                completed.remove(at: indexPath.row)
                
            default:
                print("nothing to delete")
            }
//            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        newNote.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        // замена индекса перемещаемого объекта на индекс той строки, на которое место он стал
//        completed.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Incompleted"
        case 1:
            return "Completed"
        default:
            return "Unknown section"
        }
    }
}
    
    private extension ViewController {
        
        func setupUI() {
            
            view.addSubview(tableView)
            view.addSubview(mainTitle)
          
            
            NSLayoutConstraint.activate([
                
                mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                mainTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                mainTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
                mainTitle.heightAnchor.constraint(equalToConstant: 80),
                
                tableView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 5),
                tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
               
            ])
            let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapEditButton))
            
            self.navigationItem.leftBarButtonItem = editButton
            
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
            
            self.navigationItem.rightBarButtonItem = addButton
        }
        
        func makeTableView() -> UITableView {
            
            let table = UITableView(frame: .zero, style: .plain)
            table.translatesAutoresizingMaskIntoConstraints = false
            table.delegate = self
            table.dataSource = self
            // регистрация кастомной ячейки, имя файла ячейки, бандл нил, тк ячейка находится в одном файле с проектом
            
            table.register(UINib(nibName: "newCellTableViewCell", bundle: nil ), forCellReuseIdentifier: "newCellTableViewCell")
            
            return table
        }
        
        @objc
        func tapEditButton() {
            
            tableView.isEditing = !tableView.isEditing
        }
        
        @objc
        func addItem() {
//            tableView.reloadData()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {return}
            vc.delegate = self
            
            
           self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
extension ViewController: DetailsViewControllerDelegate {
    func save(data: Note) {
        newNote.append(data)
        tableView.reloadData()
    }
}


    

//ндекс соответствует ячейке сегмент контроля - index
// model[index].count - достаем массив данных относящихся к группе сегмент контроля
// model[index][indexPath.row] - для того, чтобы вытянуть конкретный элемент из массива - это будет тайтл

