//
//  TeacherListViewController.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/8/25.
//

import UIKit
import Combine
import SwiftUI


class TeacherListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterScrollView: UIScrollView!
    @IBOutlet weak var filterStackView: UIStackView!

    private var teachers: [Teacher] = []
    var avatarTeachers: [Teacher] = []
    private let cellIdentifier = "TeacherListCell"


    // Avatars
    @IBOutlet weak var avatarTeacherCollection: UICollectionView!
    private let avatarTeacherCellIdentifier = "AvatarTeacherCollectionCell"

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

        NetworkManager.shared.getTeachers { [weak self] (result: [Teacher]?) in
            guard let self = self, let result = result else { return }
            DispatchQueue.main.async {
                self.teachers = result
                self.avatarTeachers = result.filter { $0.countryName == "セルビア" }
                print("Avatar", self.avatarTeachers)
                self.tableView.reloadData()
                self.avatarTeacherCollection.reloadData()
            }
        }

        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterStackView.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            filterStackView.bottomAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor),
            filterStackView.trailingAnchor.constraint(equalTo: filterScrollView.trailingAnchor),

            // 👇 This line is key to enable horizontal scrolling
            filterStackView.heightAnchor.constraint(equalTo: filterScrollView.heightAnchor)
        ])


        setupFilters()

    }

    func setupFilters(){

        let filters = ["Rating", "Kids Rating", "Lesson Count", "Reservation List"]

        for title in filters {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            button.layer.cornerRadius = 12
            button.layer.masksToBounds = true
            button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
            button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
            filterStackView.addArrangedSubview(button)
        }
    }

    @objc private func filterButtonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }

        switch title {
        case "Rating":
            teachers.sort { ($0.rating ?? 0) > ($1.rating ?? 0) }
        case "Kids Rating":
            teachers.sort { ($0.kidsRating ?? 0) > ($1.kidsRating ?? 0) }
        case "Lesson Count":
            teachers.sort { ($0.lessons ?? 0) > ($1.lessons ?? 0) }
        case "Reservation List":
            print("Reservation List")
            openReservationList()
            return
        default:
            break
        }

        tableView.reloadData()
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

            let teacherViewModel = TeacherViewModel(teacher: selectedTeacher)
            dump(selectedTeacher)
            let swiftUIView = TeacherDetailsSwiftUIView(viewModel: teacherViewModel)
            let hostingController = UIHostingController(rootView: swiftUIView)
            self.navigationController?.pushViewController(hostingController, animated: true)

        }

    }
