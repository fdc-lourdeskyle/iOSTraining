//
//  TeacherListViewController.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/8/25.
//

import UIKit
import Combine
import SwiftUI


class TeacherListViewController: UIViewController {

    private var teachers: [Teacher] = []
    private var avatarTeachers: [Teacher] = []
    private var allTeachers: [Teacher] = []
    var filteredTeachers: [Teacher] = []

    var teacherListVM: TeacherListViewModel!

    private var selectedFilterButton: UIButton?
    var isSearching = false


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lessonsTabButton: UIButton!
    @IBOutlet weak var ncAIButton: UIButton!
    @IBOutlet weak var searchTeacher: UIImageView!
    @IBOutlet weak var avatarTeacherCollection: UICollectionView!

    private let cellIdentifier = "TeacherListCell"
    private let avatarTeacherCellIdentifier = "AvatarTeacherCollectionCell"

    //Filter
    let filters = ["Rating", "Kids Rating", "Lesson Count", "Favorite Teachers"]
    var selectedIndex: Int?
    @IBOutlet weak var filterCollectionView: UICollectionView!
    private let filterCellIdentifier = "FilterCell"



    override func viewDidLoad() {
        super.viewDidLoad()

        setupTeacherTableView()
        setupAvatarTeacherTableView()
        setupFilterCollectionView()

        fetchTeachers()
        setupSegmentButtons()

        searchTeacher.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(promptSearch))
        searchTeacher.addGestureRecognizer(tapGesture)

    }

    func setupTeacherTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        let nib = UINib(nibName: cellIdentifier , bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }

    func setupAvatarTeacherTableView() {
        avatarTeacherCollection.dataSource = self
        avatarTeacherCollection.delegate = self

        let avatarNib = UINib(nibName: avatarTeacherCellIdentifier, bundle: nil)
        avatarTeacherCollection
            .register(avatarNib, forCellWithReuseIdentifier: avatarTeacherCellIdentifier)
    }

    func setupFilterCollectionView() {
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self

        filterCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.filterCellIdentifier)
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        filterCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }


    func fetchTeachers(){
        NetworkManager.shared.getTeachers { [weak self] (result: [Teacher]?) in
            guard let self = self, let result = result else { return }

            DispatchQueue.main.async {
                self.teachers = result
                self.allTeachers = result
                self.avatarTeachers = result.filter { $0.countryName == "セルビア" }

//                self.teachers.sort { ($0.rating ?? 0) > ($1.rating ?? 0) }

                let teacherListVM = TeacherListViewModel(teachers: self.teachers)
                self.teacherListVM = teacherListVM

                teacherListVM.refreshFavorites()

                self.tableView.reloadData()
                self.avatarTeacherCollection.reloadData()
            }
        }
    }

    func setupSegmentButtons() {
        [lessonsTabButton, ncAIButton].forEach { button in
            button?.setTitleColor(.systemOrange, for: .normal)
            button?.backgroundColor = .clear
        }

        lessonsTabButton.layoutIfNeeded()
        lessonsTabButton.applyBottomBorder(isSelected: true)

        ncAIButton.layoutIfNeeded()
        ncAIButton.applyBottomBorder(isSelected: false)

        lessonsTabButton.addTarget(self, action: #selector(segmentButtonTapped(_:)), for: .touchUpInside)
        ncAIButton.addTarget(self, action: #selector(segmentButtonTapped(_:)), for: .touchUpInside)
    }

    @objc func segmentButtonTapped(_ sender: UIButton) {
        lessonsTabButton.applyBottomBorder(isSelected: false)
        ncAIButton.applyBottomBorder(isSelected: false)

        sender.layoutIfNeeded()
        sender.applyBottomBorder(isSelected: true)

        if sender == ncAIButton {
            print("NC AI")
        }
    }

    @objc func promptSearch() {
        let alert = UIAlertController(
            title: "Search Teacher",
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField{
            textField in textField.placeholder = "Enter teacher name"
        }

        let searchAction = UIAlertAction(title: "Search", style: .default) { _ in
            let keyword = alert.textFields?.first?.text ?? ""
            self.teacherListVM.searchTeachers(keyword: keyword)
            self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(searchAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

}


extension TeacherListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCollectionView {
            return filters.count
        } else if collectionView == avatarTeacherCollection {
            return avatarTeachers.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == filterCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: filterCellIdentifier,
                for: indexPath
            ) as! FilterCell

            let filter = filters[indexPath.item]

            cell.configure(with: filter)

            return cell

        } else if collectionView == avatarTeacherCollection {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: avatarTeacherCellIdentifier,
                for: indexPath
            ) as! AvatarTeacherCollectionCell

            let avatarTeacher = avatarTeachers[indexPath.item]
            cell.configureCell(avatarTeacher)
            return cell
        }

        fatalError("Unknown collection view")
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            selectedIndex = indexPath.item
            let selectedFilter = filters[indexPath.item]

            teacherListVM.filter(by: selectedFilter)
            tableView.reloadData()

        } else if collectionView == avatarTeacherCollection {
            let selectedTeacher = avatarTeachers[indexPath.item]
            let allTeachers = avatarTeachers

            let teacherListViewModel = TeacherListViewModel(teachers: allTeachers)
            let teacherViewModel = TeacherViewModel(teacher: selectedTeacher)

            let swiftUIView = TeacherDetailsSwiftUIView(viewModel: teacherViewModel)
                .environmentObject(teacherListViewModel)

            let hostingController = UIHostingController(rootView: swiftUIView)
            self.navigationController?.pushViewController(hostingController, animated: true)
        }
    }
}


    extension TeacherListViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            if collectionView == filterCollectionView {
                return CGSize(width: 160, height: 32)
            } else if collectionView == avatarTeacherCollection {
                return CGSize(width: 120, height: 190)
            }

            return .zero
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
    }


    extension TeacherListViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return teacherListVM?.filteredTeachers.count ?? 0
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


            guard let teacherListVM = teacherListVM else {
                return UITableViewCell()
            }

            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TeacherListCell

            let viewModel = teacherListVM.filteredTeachers[indexPath.row]
            cell.configure(with: viewModel)

            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 140
        }
    }


    extension TeacherListViewController: UITableViewDelegate {
        func tableView(
            _ tableView: UITableView,
            didSelectRowAt indexPath: IndexPath
        ){
            let selectedTeacher = teachers[indexPath.row]
            let allTeachers = teachers

            let teacherListViewModel = TeacherListViewModel(teachers: allTeachers)
            let teacherViewModel = TeacherViewModel(teacher: selectedTeacher)

            let swiftUIView = TeacherDetailsSwiftUIView(viewModel: teacherViewModel).environmentObject(teacherListVM!)
            let hostingController = UIHostingController(rootView: swiftUIView)
            self.navigationController?.pushViewController(hostingController, animated: true)

        }
    }


