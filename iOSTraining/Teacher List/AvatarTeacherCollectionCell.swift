//
//  AvatarTeacherCollectionCell.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/18/25.
//

import UIKit

class AvatarTeacherCollectionCell: UICollectionViewCell {

    @IBOutlet weak var teacherImage: UIImageView!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var teacherCountryImg: UIImageView!
    @IBOutlet weak var teacherAddress: UILabel!
    @IBOutlet weak var teacherRating: UILabel!
    @IBOutlet weak var teacherLessonCount: UILabel!
    @IBOutlet weak var teacherFavoriteCount: UILabel!

    @IBOutlet weak var stackContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        stackContainerView.layer.cornerRadius = 12
        stackContainerView.layer.masksToBounds = true
        stackContainerView.layer.borderWidth = 1
        stackContainerView.layer.borderColor = UIColor.black.cgColor
//        stackContainerView.backgroundColor = .white
    }

    func configureCell(_ teacher: Teacher){
        teacherName.text = teacher.nameEng
        teacherAddress.text = teacher.countryName
        teacherRating.text = String(format: "%.2f", teacher.rating ?? 0.0)
        teacherLessonCount.text = "\(teacher.lessons ?? 0)"
        teacherFavoriteCount.text = "\(teacher.favoriteCount ?? 0)"

        if let urlString = teacher.imageMain, let url = URL(string: urlString) {
            teacherImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }

        if let urlCountryString = teacher.countryImage, let url = URL(string: urlCountryString) {
            teacherCountryImg.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
    }

}
