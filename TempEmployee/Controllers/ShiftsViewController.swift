//
//  ShiftsViewController.swift
//  TempEmployee
//
//  Created by kashif Saeed on 31/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import UIKit

class ShiftsViewController: UIViewController {

    var footerView: UIView?
    var footerViewFrame: CGRect?
    var footerNeedsLayout : Bool! = true
    @IBOutlet weak var tableView: UITableView!
    let reuseIndentifier = "ShiftsCell"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: reuseIndentifier, bundle: nil), forCellReuseIdentifier: reuseIndentifier)
        
        footerView = Bundle.main.loadNibNamed("FooterView", owner: self, options: nil)?.first as! UIView?
        self.fetchShits(service:ShiftService())
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.footerNeedsLayout! {
            footerView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
             self.footerViewFrame = self.footerView?.frame
            self.setupFooter()
        }
    }
    
    func setupFooter() {
        self.tableView.tableFooterView = nil;
        self.footerView?.frame = self.frameForFooter();
        self.tableView.tableFooterView = self.footerView;
        self.footerNeedsLayout = false;
    }
    func frameForFooter() -> CGRect {
        
            var frame = self.footerView?.frame;
            let visibleSpace : CGFloat = self.tableView.frame.height - self.tableView.contentInset.bottom - self.tableView.contentInset.top;
            if (self.tableView.contentSize.height < visibleSpace - (frame?.height)!) {
                let emptySpace : CGFloat = visibleSpace - self.tableView.contentSize.height;
                frame?.size.height = emptySpace;
            }
            else {
                frame = self.footerViewFrame!;
            }
            
            return frame!;
        
 
        
    }

}
extension ShiftsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier:self.reuseIndentifier , for: indexPath)
        
        return cell
    }
}
