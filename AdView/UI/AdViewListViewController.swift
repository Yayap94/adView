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
    private var adViewTableview = UITableView()
    private let cellHeight: CGFloat = 100.0
    private let cellId = "AdCell"
    private let adCategoryService = CategoryService()
    private let adModelService = AdService()


    // Data Vars
    var adModelData: [AdModel] = []
    var refreshControl = UIRefreshControl()

    var ascendentSort = true

    override func viewDidLoad() {
        super.viewDidLoad()

        //Init all datas
        adModelService.getAllAdModels()
        adCategoryService.getAllAdCategories()

        title = "Annonces"
        setutpNavButton()
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
    }

    @objc func dataUpdated() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.adModelData = self.adModelService.getAdModelSortByDate(ascendent: true)
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
        let rightBarButton = UIBarButtonItem(title: "Ascendant↑",
                                             style: .plain,
                                             target: self,
                                             action: #selector(sortTapped))
        let leftBarButton = UIBarButtonItem(title: "Filtrer",
                                            style: .plain,
                                            target: self,
                                            action: #selector(filterTapped))
        rightBarButton.tintColor = .orange
        leftBarButton.tintColor = .orange
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }

    @objc private func sortTapped() {
        ascendentSort = !ascendentSort
        adModelData = adModelService.getAdModelSortByDate(ascendent: ascendentSort, for: adModelData)
        navigationItem.rightBarButtonItem?.title = ascendentSort ? "Ascendant↑" : "Descendant↓"
        adViewTableview.reloadData()
    }

    @objc private func filterTapped() {
        let alertViewController = UIAlertController(title: "Categorie:", message: nil, preferredStyle: .actionSheet)
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self

        let filterAction = UIAlertAction(title: "Filtrer", style: .default, handler: { _ in
            let selectedRow = pickerView.selectedRow(inComponent: 0)
            let selectedCategory = self.adCategoryService.getAdCategories()[selectedRow]
            DispatchQueue.main.async {
                self.adModelData = self.adModelService.getFilteredAdModel(for: selectedCategory.categoryId,
                                                                          in: self.adModelData)
                self.adViewTableview.reloadData()
            }
        })
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alertViewController.view.addSubview(pickerView)
        alertViewController.addAction(filterAction)
        alertViewController.addAction(cancelAction)
        alertViewController.view.heightAnchor.constraint(equalToConstant: 350).isActive = true

        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.anchor(top: alertViewController.view.topAnchor,
                          left: alertViewController.view.leftAnchor,
                          bottom: nil,
                          right: alertViewController.view.rightAnchor,
                          paddingTop: 16.0,
                          paddingLeft: 0.0,
                          paddingBottom: 0.0,
                          paddingRight: 0.0,
                          width: 0.0,
                          height: 0.0,
                          enableInsets: false)

        present(alertViewController, animated: true, completion: nil)
    }
}

extension AdViewListViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return adCategoryService.getAdCategories()[row].name
    }
}

extension AdViewListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return adCategoryService.getAdCategories().count
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
