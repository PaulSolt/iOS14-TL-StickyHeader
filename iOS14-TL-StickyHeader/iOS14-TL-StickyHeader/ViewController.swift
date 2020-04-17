//
//  ViewController.swift
//  iOS14-TL-StickyHeader
//
//  Created by Paul Solt on 4/17/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var headerView: StickyHeaderView = {
        // lazy allows us to access view after it exists
        let header = StickyHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: StickyHeaderView.defaultHeight))
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
        
        tableView.contentInset = UIEdgeInsets(top: StickyHeaderView.defaultHeight, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
                
    }
}

extension ViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {     
        headerView.updateViewForScrollPosition(y: scrollView.contentOffset.y,
                                               width: view.bounds.width)
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
