//
//  AdViewListViewController.swift
//  AdView
//
//  Created by Nicolas SABELLA on 02/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import Foundation
import UIKit

class AdViewListViewController: UIViewController {

    // UI vars
    var adViewTableview = UITableView()
    let cellHeight: CGFloat = 100.0
    let cellId = "AdCell"
    let adCategoryService = CategoryService()
    let adModelService = AdService()

    // Data Vars
    var adModelData: [AdModel] = []
    var refreshControl = UIRefreshControl()

    var ascendentSort = false

    override func viewDidLoad() {
        super.viewDidLoad()

        //Init all datas
        adModelService.getAllAdModels()
        adCategoryService.getAllAdCategories()

        title = "Annonces"
        setupAdViewList()
        configureListView()
        adViewTableview.register(AdCell.self, forCellReuseIdentifier: cellId)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.dataUpdated),
                                               name: NSNotification.Name(rawValue: "DataUpdated"),
                                               object: nil)
        adViewTableview.addSubview(refreshControl)

        setutpNavButton()
    }

    @objc func dataUpdated() {
        DispatchQueue.main.async{
            self.refreshControl.endRefreshing()
            self.adModelData = self.adModelService.getAdModels()
            self.adViewTableview.reloadData()
        }
    }

    @objc func refresh(_ sender: Any) {
        adModelService.getAllAdModels()
    }

    private func setupAdViewList() {
        view.addSubview(adViewTableview)
        adViewTableview.translatesAutoresizingMaskIntoConstraints = false

        let leadingConstraint = adViewTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = adViewTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let topConstraint = adViewTableview.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomConstraint = adViewTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }

    private func configureListView() {
        adViewTableview.delegate = self
        adViewTableview.dataSource = self
    }

    private func setutpNavButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Trier", style: .plain, target: self, action: #selector(sortTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
    }

    @objc private func sortTapped() {
        if ascendentSort {
            adModelData = adModelService.getAdModelSortByDate(ascendent: false)
            navigationItem.rightBarButtonItem?.title = "Trier↓"
        } else {
            adModelData = adModelService.getAdModelSortByDate(ascendent: true)
            navigationItem.rightBarButtonItem?.title = "Trier↑"
        }
        ascendentSort = !ascendentSort
        adViewTableview.reloadData()
    }

    @objc private func filterTapped() {

        let alertViewController = UIAlertController(title: "Filtrer par catégorie :", message: "test", preferredStyle: .actionSheet)
        let pickerView = UIPickerView(frame: CGRect(x: 0.0, y:-10.0, width:0.0 , height: 0.0))
        pickerView.dataSource = self
        pickerView.delegate = self

        let filterAction = UIAlertAction(title: "Filtrer", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)

        alertViewController.addAction(filterAction)
        alertViewController.addAction(cancelAction)
        alertViewController.view.addSubview(pickerView)

        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.anchor(top: alertViewController.view.topAnchor,
                          left: alertViewController.view.leftAnchor,
                          bottom: alertViewController.view.bottomAnchor,
                          right: alertViewController.view.rightAnchor,
                          paddingTop: 0.0,
                          paddingLeft: 0.0,
                          paddingBottom: 0.0,
                          paddingRight: 0.0,
                          width: 0.0,
                          height: 200.0,
                          enableInsets: false)

        present(alertViewController, animated: true, completion: nil)
    }
}

extension AdViewListViewController: UIPickerViewDelegate {

}

extension AdViewListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return adCategoryService.getAdCategories().count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return adCategoryService.getAdCategories()[row].name
    }
}

extension AdViewListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let adModel = adModelData[indexPath.row]
        let detailsViewController = AdViewDetailViewController()
        detailsViewController.adModel = adModel
        detailsViewController.category = adCategoryService.getCategory(for: adModel.categoryId)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension AdViewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adModelData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = adViewTableview.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AdCell {
            let adModel = adModelData[indexPath.row]
            cell.configure(with: adModel, categoryService: adCategoryService)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
}
