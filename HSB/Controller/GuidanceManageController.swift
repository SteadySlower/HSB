//
//  GuidanceManageController.swift
//  HSB
//
//  Created by JW Moon on 2022/01/20.
//

import UIKit

fileprivate let reuseIdentifier = "GuidanceManageCell"

class GuidanceManageController: UIViewController {
    // MARK: - Properties
    
    var viewModel = GuidanceManageViewModel()
    
    lazy var filteringSegmentControl: UISegmentedControl = {
        let sg = UISegmentedControl(items: GuidanceManageListFilter.segmentItems)
        sg.selectedSegmentIndex = viewModel.filter.rawValue
        sg.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], for: .normal)
        sg.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)], for: .selected)
        sg.addTarget(self, action: #selector(segmentValueChanged(sender:)), for: .valueChanged)
        return sg
    }()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "봉사 지도"
        configureUI()
        configureTableView()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Selectors
    
    @objc func segmentValueChanged(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        guard let newFilter = GuidanceManageListFilter(rawValue: selectedIndex) else { return }
        viewModel.filter = newFilter
        tableView.reloadData()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(filteringSegmentControl)
        filteringSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        filteringSegmentControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        filteringSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        filteringSegmentControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        filteringSegmentControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: filteringSegmentControl.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GuidanceManageCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDataSource

extension GuidanceManageController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.guidances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? GuidanceManageCell else { return UITableViewCell() }
        cell.guidance = viewModel.guidances[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension GuidanceManageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - UITableViewDelegate

extension GuidanceManageController: GuidanceManageCellDelegate {
    func completeButtonTapped(in cell: GuidanceManageCell) {
        return
    }
    
    func delayButtonTapped(in cell: GuidanceManageCell) {
        return
    }
}

