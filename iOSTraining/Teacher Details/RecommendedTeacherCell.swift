//
//  RecommendedTeacherCell.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/10/25.
//

import UIKit

class RecommendedTeacherCell: UICollectionViewCell {

    @IBOutlet weak var teacherImage: UIImageView!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var teacherCountryImg: UIImageView!
    @IBOutlet weak var teacherAddress: UILabel!
    @IBOutlet weak var teacherRating: UILabel!
    @IBOutlet weak var teacherLessonCount: UILabel!
    @IBOutlet weak var teacherFavoriteCount: UILabel!

//    let cellIdentifier = "RecommendedTeacherCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(_ teacher: Teacher){
//        teacherImage.image = UIImage(named: teacher.imageMain ?? "")
        teacherName.text = teacher.nameEng
//        teacherCountryImg.image = UIImage(named: teacher.countryImage ?? "")
        teacherAddress.text = teacher.countryName
        teacherRating.text = String(format: "%.2f", teacher.rating ?? 0.0)
        teacherLessonCount.text = "\(String(describing: teacher.lessons))"
        teacherFavoriteCount.text = "\(String(describing: teacher.favoriteCount))"

        if let urlString = teacher.imageMain, let url = URL(string: urlString) {
            teacherImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }

        if let urlCountryString = teacher.countryImage, let url = URL(string: urlCountryString) {
            teacherCountryImg.image = UIImage(named: teacher.countryImage ?? "")
        }
    }



}
