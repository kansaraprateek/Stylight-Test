//
//  ViewController.swift
//  Stylight-Test
//
//  Created by Prateek Kansara on 15/05/17.
//  Copyright © 2017 prateek. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {

    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var selectedTableView : UITableView!
    @IBOutlet var brandsTableView : UITableView!
    @IBOutlet var brandTableHeightContraint: NSLayoutConstraint!
    @IBOutlet var selectedTableHeightConstraint: NSLayoutConstraint!
    
    var brandSectionTitles = NSMutableArray()
    var brandSectionIndexTitles = NSMutableArray()
    
    var brandIndexedDictionary = NSMutableDictionary()
    
    var selectedBrandArray : [Brand]? = [Brand]()
    var allBrandArray : [Brand]?
    
    private let brandModelObject = BrandModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupNavigation()
        setupUI()
        
        brandModelObject.brandModelDelegateObject = self
        fetchBrandsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Stting up navigation Items for current view
    func setupNavigation() {
        navigationController?.setNavBackgrounColor(StylightColors().navigationColor)
        let titleAttributes : NSDictionary = [
            NSFontAttributeName : constants().navigationTitleFont!,
            NSForegroundColorAttributeName : UIColor.black
        ]
        navigationController!.navigationBar.titleTextAttributes = titleAttributes as? [String : AnyObject]
        navigationController?.topViewController?.title = "Brands"
        
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(self.reloadButtonPressed)
    }

    /// Stting up UI when loading view
    func setupUI(){
        
        view.layer.insertSublayer(UtilityMethods().appBackground(), at: 0)
        brandsTableView.tableFooterView = UIView.init(frame: .zero)
        hideSelectedTableView()
    }
    
    // Fetching Brand Data
    func fetchBrandsData(){
        if (allBrandArray == nil) || allBrandArray?.count == 0 {
            SVProgressHUD.show()
            brandModelObject.fetchBrandData()
        }
    }
    
    // Refreshing brand data with new data.
    func reloadButtonPressed(){
        selectedBrandArray = [Brand]()
        SVProgressHUD.show()
        brandModelObject.fetchBrandData()
    }
    
    // Method to hide selected data table on first launch
    func hideSelectedTableView() {
        self.selectedTableHeightConstraint.constant = 0.0
        self.brandTableHeightContraint.constant = self.view.frame.height
    }
    
    
    // Method to setup indexed list for all brands table
    func setupIndexedList() {
        
        brandSectionIndexTitles = NSMutableArray.init(array: sectionIndexTitle)
        brandSectionTitles = NSMutableArray.init(array: sectionTitles)
        
        brandIndexedDictionary = UtilityMethods().createIndexedDictionary(data: allBrandArray!)
        
        self.reloadView()
    }
    
    // Method to set table view constrains and reloading data.
    func reloadView() {
        
        if (self.selectedBrandArray == nil || self.selectedBrandArray?.count == 0) {
            self.selectedTableHeightConstraint.constant = 0.0
        }else{
            self.selectedTableHeightConstraint.constant = (CGFloat((self.selectedBrandArray?.count)!)*constants().tableViewCellHeight) + constants().tableTextViewHeight
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.scrollView.layoutIfNeeded()
        })
        
        self.brandTableHeightContraint.constant = (CGFloat((self.allBrandArray?.count)!)*constants().tableViewCellHeight) + constants().tableTextViewHeight + (CGFloat(self.brandIndexedDictionary.allKeys.count)*constants().tableHeaderHeight)
        
        self.selectedTableView.reloadData()
        self.brandsTableView.reloadData()
    }
    
    // Method to get brand object from indexed dictionary
    func brandObject(fromSection : Int, andRow : Int) -> Brand? {
     
        let title = brandSectionTitles.object(at: fromSection)
        if let result = brandIndexedDictionary.object(forKey: title) as? [Brand]{
            return result[andRow]
        }
        return nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if brandsTableView.contentSize.height > self.brandTableHeightContraint.constant{
            self.brandTableHeightContraint.constant = brandsTableView.contentSize.height
        }
    }
}

extension ViewController : BrandModelDelegate{
    
    func reloadBrandData(brandData: NSArray?) {
        SVProgressHUD.dismiss()
        self.allBrandArray = brandData as? [Brand]
        self.setupIndexedList()
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 0{return 1}
        
        return brandSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return selectedBrandArray?.count ?? 0
        }
        
        let title = brandSectionTitles.object(at: section)
        if let result = brandIndexedDictionary.object(forKey: title) as? [Brand]{
            return result.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "brandCell", for: indexPath) as! brandCell

        cell.selectionStyle = .none
        
        var brandObject : Brand
        if tableView.tag == 0{
            brandObject = (selectedBrandArray?[indexPath.row])!
        }else{
            brandObject = self.brandObject(fromSection: indexPath.section, andRow: indexPath.row)!
        }
        cell.brandCheckBox.tag = brandObject.id!
        
        cell.brandCheckBox.addTarget(self, action: #selector(self.brandSelectedButtonPressed(sender:)), for: .touchUpInside)
        cell.brandName.text = brandObject.name
        if brandObject.logoData != nil{
            cell.brandImage.image = UIImage.init(data: brandObject.logoData!)
        }else{
            cell.brandImage.downloadedFrom(url: brandObject.logo!, imageID: brandObject.id, placeholderImage: UIImage(named : "noImg"))
        }
        
        cell.brandCheckBox.setImage(UIImage(named: "check-box-empty"), for: .normal)
        if (selectedBrandArray?.contains(brandObject))!{
            cell.brandCheckBox.setImage(UIImage(named: "check"), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! brandCell
        self.brandSelectedButtonPressed(sender: cell.brandCheckBox)
    }
    
    func brandSelectedButtonPressed(sender : UIButton){
        
        let selectedBrands = selectedBrandArray?.filter {
            (brandObject : Brand) -> Bool in
            if brandObject.id == sender.tag{return true}
            return false
        }
        
        if (selectedBrands?.count)! > 0 {
            if let index = selectedBrandArray?.index(of: (selectedBrands?.first)!){
                selectedBrandArray?.remove(at: index)
                self.reloadView()
            }
        }else{
            let brands = allBrandArray?.filter { (brandObject : Brand) -> Bool in
                if brandObject.id == sender.tag{
                    return true
                }
                return false
            }
            selectedBrandArray?.append((brands?.first)!)
            sender.setImage(image: UIImage(named: "check")!, animated: true)
            let deadlineTime = DispatchTime.now() + .milliseconds(500)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.reloadView()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return constants().tableViewCellHeight
    }
    
    
    // Creating Indexed data
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
//        return brandSectionIndexTitles as NSArray as? [String]
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return brandSectionTitles.index(of: title)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView.tag == 0 {return nil}
        if let count = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section) {
            if count == 0 {
                brandSectionIndexTitles.remove(brandSectionTitles.object(at: section))
                return nil
            }
        }
        return brandSectionTitles.object(at: section) as? String
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if tableView.tag == 1{
            let header = view as? UITableViewHeaderFooterView
            header?.textLabel?.textColor = StylightColors().listHeaderColor
            header?.textLabel?.font = constants().brandListTitleFont
            header?.contentView.backgroundColor = UIColor.clear
            header?.textLabel?.backgroundColor = UIColor.clear
            header?.tintColor = UIColor.clear
            var frame = header?.frame
            frame?.size.height = constants().tableHeaderHeight
            header?.frame = frame!
        }
    }
}
