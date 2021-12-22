//
//  StudentListViewController.swift
//  HSB
//
//  Created by JW Moon on 2021/12/17.
//

import UIKit

fileprivate let reuseIdentifier = "StudentListCell"

enum StudentListFilter: Int, CaseIterable {
    case all = 0
    case myClass
    case myGrade
    
    var description: String {
        switch self {
        case .all: return "전체"
        case .myClass: return "우리 반"
        case .myGrade: return "우리 학년"
        }
    }
    
    static let segmentItems = StudentListFilter.allCases.map({ filter in filter.description })
}

class StudentListViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel = StudentListViewModel()
    
    var currentStudentListFilter = StudentListFilter.all {
        didSet {
            viewModel.changeFilter(to: currentStudentListFilter)
            tableView.reloadData()
        }
    }
    
    lazy var filteringSegmentControl: UISegmentedControl = {
        let sg = UISegmentedControl(items: StudentListFilter.segmentItems)
        sg.selectedSegmentIndex = self.currentStudentListFilter.rawValue
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
        reloadTableView()
    }
    
    // MARK: - Selectors
    
    @objc func segmentValueChanged(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        guard let newFilter = StudentListFilter(rawValue: selectedIndex) else { return }
        currentStudentListFilter = newFilter
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
    
    func reloadTableView() {
        viewModel.resetGuidances()
        viewModel.changeFilter(to: currentStudentListFilter)
        tableView.reloadData()
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
        viewModel.deleteGuidance(guidance)
        reloadTableView()
    }
}
