//
//  ViewController.swift
//  iOS14-TL-StickyHeader
//
//  Created by Paul Solt on 4/17/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let headerViewHeight: CGFloat = 300

    lazy var headerView: HeaderView = {
//        self.view is loaded at this point because this is lazy
        let header = HeaderView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: headerViewHeight))
        
        return header
    }()
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setUpViews()
    }
    
    func setUpViews() {
        view.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 0, right: 0)
    }
}

extension ViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     
        var y: CGFloat = -scrollView.contentOffset.y
        print("y: \(y)")
        
        var height = y
        if height >= headerView.minHeight && height <= headerViewHeight {
            height = y
        } else if height < headerView.minHeight {
            height = headerView.minHeight
        } else { // height > headerViewHeight
            // if you want to prevent it from stretching, add this constraint
            height = headerViewHeight
        }
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: height)
        
        // Hide content
        
        let defaultHeight: CGFloat = 300
        let cutOff: CGFloat = 100
        var alpha: CGFloat = 1
        
//        y = abs(y)
        print("y: \(y)")
        if y < defaultHeight && y >= defaultHeight - cutOff {
            alpha = (y - (defaultHeight - cutOff)) / cutOff
            print("partial alpha: \(alpha)")
        } else if y < (defaultHeight - cutOff) {
            alpha = 0
            print("no alpha")
        } else if y >= defaultHeight {
            alpha = 1
            print("full alpha")
        }
        
        headerView.hideImage(alpha: alpha)

        
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
}
