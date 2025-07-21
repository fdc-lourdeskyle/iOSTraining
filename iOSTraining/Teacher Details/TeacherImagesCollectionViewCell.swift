//
//  TeacherImagesCollectionViewCell.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/15/25.
//

import UIKit

class TeacherImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        // Initialization code
    }

}
