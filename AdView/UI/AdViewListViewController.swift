//
//  AdViewListViewController.swift
//  AdView
//
//  Created by Nicolas SABELLA on 02/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

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
}

extension AdViewListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let adModel = adModelData[indexPath.row]
        let detailsViewController = AdViewDetailViewController()
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
            cell.configure(with: adModel)
            return cell
        }
        return UITableViewCell()
    }
}
