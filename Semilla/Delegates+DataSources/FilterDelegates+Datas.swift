//
//  FilterDelegates+Datas.swift
//  Semilla
//
//  Created by netset on 13/12/23.
//

import UIKit

class FiltersDatasource: NSObject,UITableViewDataSource {
    
    //MARK: Variable Declaration
    var viewModel: FilterVM!
    var filterProperties: FilterProperties!
    var reloadTblVWCallback:(()->())?
    
    //MARK: Intialization
    init(viewModel: FilterVM!, filterProperties: FilterProperties!) {
        self.viewModel = viewModel
        self.filterProperties = filterProperties
    }
    
    //MARK: TableView Datasource Method
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.arrSectionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.arrCategoryList.count
        } else if section == 1 {
            return viewModel.arrRatingsList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.filterLocationTVC) as! FilterLocationTVC
            cell.lblStartingKM.text = "0km"
            cell.lblEndingKM.text = "100km"
            cell.sliderVwLocation.thumbTintColor = AppStyle.AppColors.appColorGreen
            cell.sliderVwLocation.setThumbImage(UIImage(named: "ic_SliderThumb"), for: .normal)
            cell.sliderVwLocation.setThumbImage(UIImage(named: "ic_SliderThumb"), for: .highlighted)
            cell.configureSliderValue(viewModel.distance)
            cell.callbackSliderVal = { (valDistance) in
                self.viewModel.distance = valDistance
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.filterRowTVC, for: indexPath) as! FilterRowTVC
            if indexPath.section == 0 {
                let data = viewModel.arrCategoryList[indexPath.row]
                cell.lblItemsName.isHidden = false
                cell.vwRating.isHidden = true
                
                cell.lblItemsName.text = data.name ?? ""
                cell.btnCheckbox.isSelected = viewModel.selectCategoryId.contains((data.id ?? 0))
                cell.btnCheckbox.isUserInteractionEnabled = false
            } else {
                let data = viewModel.arrRatingsList[indexPath.row]
                cell.lblItemsName.isHidden = true
                cell.vwRating.isHidden = false
                cell.vwRating.isUserInteractionEnabled = false
                cell.vwRating.rating = Float(data.nameStr ?? "0") ?? 0
                
                cell.lblItemsName.text = data.nameStr ?? ""
                cell.btnCheckbox.isSelected = viewModel.selectRatingIndex == indexPath.row
                cell.btnCheckbox.isUserInteractionEnabled = false
            }
            if cell.btnCheckbox.isSelected {
                cell.lblItemsName.textColor = AppStyle.AppColors.appColorGreen
            } else  {
                cell.lblItemsName.textColor = UIColor.label
            }
            //cell.btnCheckbox.accessibilityHint = "\(indexPath.section),\(indexPath.row)"
            //cell.btnCheckbox.addTarget(self, action: #selector(btnFilteredItems(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    /*
    //MARK: Buttons Action's
    @objc func btnFilteredItems(_ sender:UIButton) {
        let arrRow = sender.accessibilityHint
        if let filterArr = arrRow?.components(separatedBy: ",") {
            if filterArr.count > 1 {
                let selectSection = Int(filterArr[0]) ?? 0
                let selectRow = Int(filterArr[1]) ?? 0
                if (viewModel.filterData[selectSection].rows?[selectRow].isSelectedVal ?? false) {
                    (viewModel.filterData[selectSection].rows![selectRow].isSelectedVal) = false
                } else {
                    (viewModel.filterData[selectSection].rows![selectRow].isSelectedVal) = true
                }
                self.reloadTblVWCallback?()
            }
        }
    }
    */
}

//MARK: TableView Delegate Method
class FiltersDelegate: NSObject,UITableViewDelegate {
    
    //MARK: Variable Declaration
    var viewModel: FilterVM!
    var filterProperties: FilterProperties!
    
    //MARK: Intialization
    init(viewModel: FilterVM!, filterProperties: FilterProperties!) {
        self.viewModel = viewModel
        self.filterProperties = filterProperties
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: TableCells.filterSectionTVC) as! FilterSectionTVC
        header.lblSectionNames.text = viewModel.arrSectionList[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let data = viewModel.arrCategoryList[indexPath.row]
            if viewModel.selectCategoryId.contains((data.id ?? 0)) {
                viewModel.selectCategoryId.remove((data.id ?? 0))
            } else {
                viewModel.selectCategoryId.add((data.id ?? 0))
            }
        } else if indexPath.section == 1 {
            if viewModel.selectRatingIndex == indexPath.row {
                viewModel.selectRatingIndex = -1
            } else {
                viewModel.selectRatingIndex = indexPath.row
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 85
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
