//
//  StudentListViewController.swift
//  HSB
//
//  Created by JW Moon on 2021/12/17.
//

import UIKit

fileprivate let reuseIdentifier = "StudentListCell"

class StudentListViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel = StudentListViewModel()
    
    lazy var filteringSegmentControl: UISegmentedControl = {
        let sg = UISegmentedControl(items: GuidanceListFilter.segmentItems)
        sg.selectedSegmentIndex = self.viewModel.filter.rawValue
        sg.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], for: .normal)
        sg.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)], for: .selected)
        sg.addTarget(self, action: #selector(segmentValueChanged(sender:)), for: .valueChanged)
        return sg
    }()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "학생 명단"
        configureUI()
        configureTableView()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.resetGuidances()
        tableView.reloadData()
    }
    
    // MARK: - Selectors
    
    @objc func segmentValueChanged(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        guard let newFilter = GuidanceListFilter(rawValue: selectedIndex) else { return }
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
        tableView.register(StudentListCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    
    func showDeleteAlert(guidance: Guidance) {
        let alert = UIAlertController(title: "정말 삭제하시겠습니까?", message: viewModel.guidanceDeletionMessage(guidance: guidance), preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.viewModel.deleteGuidance(guidance) {
                self.tableView.reloadData()
            }
        }
        alert.addAction(cancel)
        alert.addAction(delete)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension StudentListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.guidances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? StudentListCell else { return UITableViewCell() }
        cell.guidance = viewModel.guidances[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension StudentListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - StudentListCellDelegate

extension StudentListViewController: StudentListCellDelegate {
    func deleteButtonTapped(in cell: StudentListCell) {
        guard let guidance = cell.guidance else { return }
        showDeleteAlert(guidance: guidance)
    }
}
