//
//  TeacherListCell.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/8/25.
//

import UIKit
import Kingfisher
import Combine

class TeacherListCell: UITableViewCell{

    @IBOutlet weak var teacherImage: UIImageView!
    @IBOutlet weak var teacherAddressLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var teacherAddress: CustomUIView!
    @IBOutlet weak var teacherCoins: UILabel!
    @IBOutlet weak var teacherLessonCount: UILabel!
    @IBOutlet weak var teacherRating: UILabel!
    @IBOutlet weak var teacherCountryFlag: UIImageView!
    @IBOutlet weak var teacherAge: UILabel!
    @IBOutlet weak var tagsView: UIStackView!
    @IBOutlet weak var favoriteButton: UIImageView!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var teacherStatus: TeacherStatusIndicatorView!


    private var tags: [String] = []
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: TeacherViewModel?

    override func awakeFromNib() {

        super.awakeFromNib()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        favoriteButton.isUserInteractionEnabled = true
        favoriteButton.addGestureRecognizer(tapGesture)

        updateFavoriteUI()

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll() // prevent repeated updates
    }

    func configure(with viewModel: TeacherViewModel) {
        self.viewModel = viewModel

        let teacher = viewModel.teacher

        teacherNameLabel.text = teacher.nameEng
        teacherAddressLabel.text = teacher.countryName
        teacherAge.text = "(Age: \(teacher.age ?? 0))"
        teacherRating.text = String(format: "%.2f", teacher.rating ?? 0.0)
        teacherLessonCount.text = viewModel.favoriteCountText
        teacherCoins.text = viewModel.teacherCoinText
        teacherStatus.status = teacher.status ?? 0

        if let urlString = teacher.imageMain, let url = URL(string: urlString) {
            teacherImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }

        if let urlCountryString = teacher.countryImage, let urlCountry = URL(string: urlCountryString) {
            teacherCountryFlag.kf.setImage(with: urlCountry, placeholder: UIImage(named: "placeholder"))
        }


        tagsView.arrangedSubviews.forEach { $0.removeFromSuperview() } // Clean up

        if teacher.nativeSpeakerFlg == 1 {
            tagsView.addArrangedSubview(makeCapsuleTag("Native", backgroundColor: .systemGreen))
        }
        if teacher.suitableForChildrenFlg == 1 {
            tagsView.addArrangedSubview(makeCapsuleTag("For Kids", backgroundColor: .systemBlue))
        }
        if teacher.callanDiscountFlg == true {
            tagsView.addArrangedSubview(makeCapsuleTag("Callan", backgroundColor: .systemOrange))
        }
        if teacher.beginnerTeacherFlg == 1 {
            tagsView.addArrangedSubview(makeCapsuleTag("Beginner", backgroundColor: .systemPurple))
        }
        if teacher.freeTalkFlg == 1 {
            tagsView.addArrangedSubview(makeCapsuleTag("Free Talk", backgroundColor: .systemTeal))
        }
        if teacher.nativeNowFlg == 1 {
            tagsView.addArrangedSubview(makeCapsuleTag("Native Now", backgroundColor: .systemPink))
        }

        viewModel.$teacher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateFavoriteUI()
            }
            .store(in: &cancellables)

        updateFavoriteUI()

    }

    @objc private func favoriteTapped() {
        viewModel?.toggleFavorite()
        viewModel?.refreshFavoriteStatus()
        updateFavoriteUI()
    }

    private func updateFavoriteUI() {
        guard let viewModel = viewModel else { return }

        favoriteButton.image = UIImage(systemName: viewModel.favoriteImageName)?.withRenderingMode(.alwaysTemplate)
        favoriteButton.tintColor = viewModel.favoriteTintColor
        favoriteCount.text = viewModel.favoriteCountText
    }

    func makeCapsuleTag(_ text: String, backgroundColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.backgroundColor = backgroundColor
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)

//        label.padding(left: 10, right: 10)

        return label
    }

}
