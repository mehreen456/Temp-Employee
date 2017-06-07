//
//  ShiftsViewController.swift
//  TempEmployee
//
//  Created by kashif Saeed on 31/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import UIKit
import PKHUD
class ShiftsViewController: UIViewController {

    var footerView: FooterView?
    var footerViewFrame: CGRect?
    var footerNeedsLayout : Bool! = true
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var shiftsData  = [Shift](){
        
        didSet{
            self.footerNeedsLayout = true
            self.tableView.reloadData()
        }
    }
    
    let reuseIndentifier = "ShiftsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: reuseIndentifier, bundle: nil), forCellReuseIdentifier: reuseIndentifier)
        
        footerView = Bundle.main.loadNibNamed("FooterView", owner: self, options: nil)?.first as! FooterView?
        
        footerView?.newShiftButton.addTarget(self, action: #selector(addNewShift),for: .touchUpInside)
        
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! UIView?
        
        self.fetchShifts(service:ShiftsService())
        
        self.tableView.tableHeaderView = headerView
        
        self.navigationController?.navigationBar.isHidden = true
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

    
    func fetchShifts(service:ShiftsService)  {
       
       HUD.show(.progress,onView: self.view)
        
        service.fetchMyShifts(with: {result in
            
            switch result{
                
            case .Success(let response):
                    print(response)
                    HUD.flash(.success, delay: 0.0)
                    if response.success{
                        self.shiftsData = response.shifts
                    }else{
                         HUD.flash(.error, delay: 0.0)
                        self.errorAlert(description: response.message)
                }
            case .Failure(let error):
                HUD.flash(.error, delay: 0.0)
                self.errorAlert(description: error.localizedDescription)
                print(error)
            }
        })
    }
    
    func addNewShift(sender: UIButton!) {
        
        let storyboard = UIStoryboard.init(name: "AddShift", bundle: nil)
        
        let addShiftVC : AddShiftController = storyboard.instantiateViewController()
        
        self.navigationController?.pushViewController(addShiftVC, animated: true)
        
    }
    
}
extension ShiftsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shiftsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier:self.reuseIndentifier , for: indexPath) as! ShiftsCell
        let shift = self.shiftsData[indexPath.row]
        cell.shiftJobAddress.text = shift.address
        cell.shiftJobTitle.text = shift.role
        cell.shiftDate.text = shift.shift_date
        cell.shiftRate.text = "£\(shift.price_per_hour!)"
        //cell.shiftStatus = shift.
       
        return cell
    }
}
