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
    @IBOutlet weak var reserveButton: UIButton!

    @IBAction func reserveButtonTapped(_ sender: UIButton) {
        print("reserve button tapped")
        viewModel?.reserveTeacher()
    }


    private var tags: [String] = []
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: TeacherViewModel?

    override func awakeFromNib() {

        super.awakeFromNib()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        favoriteButton.isUserInteractionEnabled = true
        favoriteButton.addGestureRecognizer(tapGesture)
    }


    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll() // prevent repeated updates
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.accessoryType = .disclosureIndicator
//    }

    func configure(with viewModel: TeacherViewModel) {
        self.viewModel = viewModel

        let teacher = viewModel.teacher

        teacherNameLabel.text = teacher.nameEng
        teacherAddressLabel.text = teacher.countryName
        teacherAge.text = "(Age: \(teacher.age ?? 0))"
        teacherRating.text = String(format: "%.2f", teacher.rating ?? 0.0)
        teacherLessonCount.text = viewModel.favoriteCountText
        teacherCoins.text = viewModel.teacherCoinText

        if let urlString = teacher.imageMain, let url = URL(string: urlString) {
            teacherImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }

        if let urlCountryString = teacher.countryImage, let urlCountry = URL(string: urlCountryString) {
            teacherCountryFlag.kf.setImage(with: urlCountry, placeholder: UIImage(named: "placeholder"))
        }

        viewModel.$teacher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateFavoriteUI()
            }
            .store(in: &cancellables)

        updateFavoriteUI()
    }

//    func configureCell(_ teacher: Teacher){
//        teacherNameLabel.text = teacher.nameEng
//        teacherAddressLabel.text = teacher.countryName
//        teacherAge.text =  "(Age: " + "\(teacher.age ?? 0)" + ")"
//        teacherRating.text = "\(String(format: "%.2f", teacher.rating ?? 0.0))"
//        teacherLessonCount.text =  "\(teacher.lessons ?? 0)"
//        favoriteCount.text = viewModel?.favoriteCountText
//
//        if let urlString = teacher.imageMain, let url = URL(string: urlString) {
//            teacherImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
//        }
//
//        if let urlCountryString = teacher.countryImage, let urlCountry = URL(string: urlCountryString) {
//            teacherCountryFlag.kf.setImage(with: urlCountry, placeholder: UIImage(named: "placeholder"))
//        }
//    }

    @objc private func favoriteTapped() {
        viewModel?.toggleFavorite()
    }

    private func updateFavoriteUI() {
        guard let viewModel = viewModel else { return }

        favoriteButton.image = UIImage(systemName: viewModel.favoriteImageName)?.withRenderingMode(.alwaysTemplate)
        favoriteButton.tintColor = viewModel.favoriteTintColor
        favoriteCount.text = viewModel.favoriteCountText
    }

}
