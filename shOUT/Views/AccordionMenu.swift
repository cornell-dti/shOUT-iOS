//
//  AccordionMenu.swift
//  AccordionMenu
//
//  Created by Victor on 7/6/16.
//  Copyright © 2016 Victor Sigler. All rights reserved.
//  https://github.com/Vkt0r/AccordionMenuSwift/blob/master/Example/AccordionMenuExample/ViewController.swift
//
//  Modified by Jordan Greissman

import UIKit

open class AccordionTableViewController: UITableViewController {
    
    /// The number of elements in the data source
    open var total = 0
    
    /// The identifier for the parent cells.
    let parentCellIdentifier = "ParentCell"
    
    /// The identifier for the child cells.
    let childCellIdentifier = "ChildCell"
    
    /// The data source
    open var dataSource: [Parent]!
    
    /// Define wether can exist several cells expanded or not.
    open var numberOfCellsExpanded: NumberOfCellExpanded = .one
    
    /// Constant to define the values for the tuple in case of not exist a cell expanded.
    let NoCellExpanded = (-1, -1)
    
    /// The index of the last cell expanded and its parent.
    var lastCellExpanded : (Int, Int)!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.lastCellExpanded = NoCellExpanded
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: parentCellIdentifier)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: childCellIdentifier)
        self.tableView.tableFooterView = UIView()
        
        // Offset by status bar height
//        self.tableView.contentInset = UIEdgeInsetsMake(
//            UIApplication.shared.statusBarFrame.size.height, 0, 0, 0)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /**
     Expand the cell at the index specified.
     
     - parameter index: The index of the cell to expand.
     */
    open func expandItemAtIndex(_ index : Int, parent: Int) {
        
        // the data of the childs for the specific parent cell.
        let currentSubItems = self.dataSource[parent].childs
        
        // update the state of the cell.
        self.dataSource[parent].state = .expanded
        
        // position to start to insert rows.
        var insertPos = index + 1
        
        let indexPaths = (0..<currentSubItems.count).map { _ -> IndexPath in
            let indexPath = IndexPath(row: insertPos, section: 0)
            insertPos += 1
            return indexPath
        }
        
        // insert the new rows
        self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        
        // update the total of rows
        self.total += currentSubItems.count
    }
    
    /**
     Collapse the cell at the index specified.
     
     - parameter index: The index of the cell to collapse
     */
    open func collapseSubItemsAtIndex(_ index : Int, parent: Int) {
        
        var indexPaths = [IndexPath]()
        
        let numberOfChilds = self.dataSource[parent].childs.count
        
        // update the state of the cell.
        self.dataSource[parent].state = .collapsed
        
        guard index + 1 <= index + numberOfChilds else { return }
        
        // create an array of NSIndexPath with the selected positions
        indexPaths = (index + 1...index + numberOfChilds).map { IndexPath(row: $0, section: 0)}
        
        // remove the expanded cells
        self.tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        
        // update the total of rows
        self.total -= numberOfChilds
    }
    
    /**
     Update the cells to expanded to collapsed state in case of allow severals cells expanded.
     
     - parameter parent: The parent of the cell
     - parameter index:  The index of the cell.
     */
    open func updateCells(_ parent: Int, index: Int) {
        
        switch (self.dataSource[parent].state) {
            
        case .expanded:
            self.collapseSubItemsAtIndex(index, parent: parent)
            self.lastCellExpanded = NoCellExpanded
            
        case .collapsed:
            switch (numberOfCellsExpanded) {
            case .one:
                // exist one cell expanded previously
                if self.lastCellExpanded != NoCellExpanded {
                    
                    let (indexOfCellExpanded, parentOfCellExpanded) = self.lastCellExpanded
                    
                    self.collapseSubItemsAtIndex(indexOfCellExpanded, parent: parentOfCellExpanded)
                    
                    // cell tapped is below of previously expanded, then we need to update the index to expand.
                    if parent > parentOfCellExpanded {
                        let newIndex = index - self.dataSource[parentOfCellExpanded].childs.count
                        self.expandItemAtIndex(newIndex, parent: parent)
                        self.lastCellExpanded = (newIndex, parent)
                    }
                    else {
                        self.expandItemAtIndex(index, parent: parent)
                        self.lastCellExpanded = (index, parent)
                    }
                }
                else {
                    self.expandItemAtIndex(index, parent: parent)
                    self.lastCellExpanded = (index, parent)
                }
            case .several:
                self.expandItemAtIndex(index, parent: parent)
            }
        }
    }
    
    /**
     Find the parent position in the initial list, if the cell is parent and the actual position in the actual list.
     
     - parameter index: The index of the cell
     
     - returns: A tuple with the parent position, if it's a parent cell and the actual position righ now.
     */
    open func findParent(_ index : Int) -> (parent: Int, isParentCell: Bool, actualPosition: Int) {
        
        var position = 0, parent = 0
        guard position < index else { return (parent, true, parent) }
        
        var item = self.dataSource[parent]
        
        repeat {
            
            switch (item.state) {
            case .expanded:
                position += item.childs.count + 1
            case .collapsed:
                position += 1
            }
            
            parent += 1
            
            // if is not outside of dataSource boundaries
            if parent < self.dataSource.count {
                item = self.dataSource[parent]
            }
            
        } while (position < index)
        
        // if it's a parent cell the indexes are equal.
        if position == index {
            return (parent, position == index, position)
        }
        
        item = self.dataSource[parent - 1]
        return (parent - 1, position == index, position - item.childs.count - 1)
    }
}

extension AccordionTableViewController {
    
    // MARK: UITableViewDataSource
    
    override open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.total
    }
    
    override  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        let (parent, isParentCell, actualPosition) = self.findParent(indexPath.row)
        
        if !isParentCell {
            let idx = indexPath.row - actualPosition - 1
            
            // Make cell
            cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath)
            cell.textLabel!.text = self.dataSource[parent].childs[idx]
            cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping;
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.sizeToFit()
            let type = self.dataSource[parent].type[idx]
            
            // Make text look like hyperlinks
            if type == "phone" || type == "url" {
                cell.textLabel?.textColor = UIColor.blue
                cell.textLabel?.attributedText = NSAttributedString(string: cell.textLabel!.text!, attributes:  [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
            }
            
            // Or not for text that shouldn't
            else {
                cell.textLabel?.textColor = UIColor.black
                cell.textLabel?.attributedText = NSAttributedString(string: cell.textLabel!.text!, attributes: [:])
            }

        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: parentCellIdentifier, for: indexPath)
            cell.textLabel!.text = self.dataSource[parent].title
        }
        
        return cell
    }
        
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let (parent, isParentCell, actualPosition) = self.findParent(indexPath.row)
        
        guard isParentCell else {
            let idx = indexPath.row - actualPosition - 1
            let str = self.dataSource[parent].childs[idx]
            let type = self.dataSource[parent].type[idx]
            
            if type == "phone" {
                let condensed = str.replacingOccurrences(of: "-", with: "")
                guard let number = URL(string: "telprompt://" + condensed) else { return }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(number, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(number)
                }
            }
            
            else if type == "url" {
                guard let site = URL(string: "http://" + str) else { return }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(site, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(site)
                }

            }
            NSLog("A child was tapped!!!")
            
            // The value of the child is indexPath.row - actualPosition - 1
            NSLog("The value of the child is \(self.dataSource[parent].childs[indexPath.row - actualPosition - 1])")
            
            return
        }
        
        self.tableView.beginUpdates()
        self.updateCells(parent, index: indexPath.row)
        self.tableView.endUpdates()
    }
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let (parent, isParentCell, actualPosition) = self.findParent(indexPath.row)
        
        if isParentCell {
            return 64.0
        }
        
        else {
            let text = self.dataSource[parent].childs[indexPath.row - actualPosition - 1]

            let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.text = text
            
            label.sizeToFit()
            return label.frame.height + 20.0
        }
    }
}

