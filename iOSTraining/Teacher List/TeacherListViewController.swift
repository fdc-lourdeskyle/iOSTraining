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

    // MARK: - Properties
    private var teachers: [Teacher] = []
    var avatarTeachers: [Teacher] = []
    var teacherListVM: TeacherListViewModel!
    private let cellIdentifier = "TeacherListCell"
    private var selectedFilterButton: UIButton?


    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterScrollView: UIScrollView!
    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var lessonsTabButton: UIButton!
    @IBOutlet weak var ncAIButton: UIButton!

    // Avatars
    @IBOutlet weak var avatarTeacherCollection: UICollectionView!
    private let avatarTeacherCellIdentifier = "AvatarTeacherCollectionCell"


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        let nib = UINib(nibName: cellIdentifier , bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)

        avatarTeacherCollection.dataSource = self
        avatarTeacherCollection.delegate = self

        let avatarNib = UINib(nibName: avatarTeacherCellIdentifier, bundle: nil)
        avatarTeacherCollection
            .register(avatarNib, forCellWithReuseIdentifier: avatarTeacherCellIdentifier)


        fetchTeachers()
        setupSegmentButtons()
        setupFilters()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lessonsTabButton.applyBottomBorder(isSelected: lessonsTabButton.isSelected)
        ncAIButton.applyBottomBorder(isSelected: ncAIButton.isSelected)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func fetchTeachers(){
        NetworkManager.shared.getTeachers { [weak self] (result: [Teacher]?) in
            guard let self = self, let result = result else { return }


            DispatchQueue.main.async {
                self.teachers = result
                self.avatarTeachers = result.filter { $0.countryName == "セルビア" }


                self.teachers.sort { ($0.rating ?? 0) > ($1.rating ?? 0) }

                let teacherListVM = TeacherListViewModel(teachers: self.teachers)
                self.teacherListVM = teacherListVM

                teacherListVM.refreshFavorites()

                self.tableView.reloadData()
                self.avatarTeacherCollection.reloadData()
            }
        }
    }

    func setupFilters(){

        filterStackView.axis = .horizontal
        filterStackView.spacing = 4
        filterScrollView.addSubview(filterStackView)

        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterStackView.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            filterStackView.bottomAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor),
            filterStackView.trailingAnchor.constraint(equalTo: filterScrollView.trailingAnchor),
            filterStackView.heightAnchor.constraint(equalTo: filterScrollView.heightAnchor)
        ])

        let filters = ["Rating", "Kids Rating", "Lesson Count", "Reservation List"]

        for title in filters {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor
                .constraint(greaterThanOrEqualToConstant: 40).isActive = true

            var config = UIButton.Configuration.plain()
            config.title = title
            config.background.backgroundColor = .clear
            config.baseForegroundColor = .white
            config.cornerStyle = .capsule
            config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            button.configuration = config

            button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)

            button.configurationUpdateHandler = { button in
                var updatedConfig = button.configuration

                if button.isSelected{
                    updatedConfig?.background.backgroundColor = .white
                    updatedConfig?.baseForegroundColor = .black
                }else{
                    updatedConfig?.background.backgroundColor = .clear
                    updatedConfig?.baseForegroundColor = .white
                }

                button.configuration = updatedConfig
            }

            filterStackView.addArrangedSubview(button)

            if title == "Rating" {
                button.isSelected = true
                selectedFilterButton = button
            }
        }
    }


    func setupSegmentButtons(){
        lessonsTabButton.applyBottomBorder(isSelected: true)
        ncAIButton.applyBottomBorder(isSelected: false)

        lessonsTabButton.addTarget(self, action: #selector(segmentButtonTapped(_:)), for: .touchUpInside)
        ncAIButton.addTarget(self, action: #selector(segmentButtonTapped(_:)), for: .touchUpInside)

    }

    @objc func segmentButtonTapped(_ sender: UIButton) {

        lessonsTabButton.isSelected = (sender == lessonsTabButton)
        ncAIButton.isSelected = (sender == ncAIButton)

        lessonsTabButton.applyBottomBorder(isSelected: lessonsTabButton.isSelected)
        ncAIButton.applyBottomBorder(isSelected: ncAIButton.isSelected)

        

        if sender == ncAIButton {
            //            let ncaiView = NCAISwiftUIView()
            //            let hostingController = UIHostingController(rootView: ncaiView)
            //            self.navigationController?.pushViewController(hostingController, animated: true)
            print("NCxAI")
        } else {
            // do nothing since it's the default
        }
    }

    @objc private func filterButtonTapped(_ sender: UIButton) {
        let title = sender.configuration?.title ?? ""
        print("Tapped:", title)
//        guard let title = sender.currentTitle else { return }

        if selectedFilterButton != sender {
            selectedFilterButton?.isSelected = false
            sender.isSelected = true
            selectedFilterButton = sender
        }

        switch title {
            case "Rating":
                teachers.sort { ($0.rating ?? 0) > ($1.rating ?? 0) }
                print("Sorted by rating:", teachers.map { $0.rating ?? 0 })
            case "Kids Rating":
                teachers.sort { ($0.kidsRating ?? 0) > ($1.kidsRating ?? 0) }
            case "Lesson Count":
                teachers.sort { ($0.lessons ?? 0) > ($1.lessons ?? 0) }
            case "Reservation List":
                openReservationList()
                return
            default:
                break
        }

        tableView.reloadData()
        print("Table reloaded")
    }

    func openReservationList() {
        let reservedTeachers = ReservedTeacherManager.shared.getReservedTeachers()
        let totalCoins = ReservedTeacherManager.shared.getTotalReservedCoin()

        let reservationList = TeacherReservedSwiftUIView(
            reservedTeachers: reservedTeachers,
            totalReservedCoin: totalCoins
        )

        let hostingController = UIHostingController(rootView: reservationList)
        navigationController?.pushViewController(hostingController, animated: true)
    }

}

    extension TeacherListViewController: UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return avatarTeachers.count
        }


        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: avatarTeacherCellIdentifier,
                for: indexPath
            ) as! AvatarTeacherCollectionCell

            let avatarTeacher = avatarTeachers[indexPath.item]
            cell.configureCell(avatarTeacher)

            return cell
        }

    }

    extension TeacherListViewController: UICollectionViewDelegate{

    }

    extension TeacherListViewController: UICollectionViewDelegateFlowLayout{

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 140, height: 250)

        }

        // Left & right padding
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        }

        // Spacing between cells
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
    }

    extension TeacherListViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return teachers.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: cellIdentifier,
                for: indexPath
            ) as! TeacherListCell

            let teacher = teachers[indexPath.row]
            let viewModel = TeacherViewModel(teacher: teacher)
            cell.configure(with: viewModel)

            return cell
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
