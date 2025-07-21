//
//  TeacherDetailsViewController.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/8/25.
//

import UIKit

class TeacherDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{

//    @IBOutlet weak var shareButton: UIButton!
//    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var teacherImage: UIImageView!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var teacherAddress: UILabel!

    @IBOutlet weak var teacherAge: UILabel!

    @IBOutlet weak var teacherImageBig: UIImageView!
//    @IBOutlet weak var teacherInfoSmall: UILabel!
    @IBOutlet weak var teacherCountryFlag: UIImageView!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var teacherLessonCount: UILabel!
    @IBOutlet weak var teacherKidsRating: UILabel!
//    @IBOutlet weak var teacherLectureHistory: UILabel!
    @IBOutlet weak var teacherFavoriteCount: UILabel!
    @IBOutlet weak var teacherRating: UILabel!

    @IBOutlet weak var traitOne: UILabel!
    @IBOutlet weak var traitThree: UILabel!
    @IBOutlet weak var traitTwo: UILabel!

    @IBOutlet weak var hobbiesView: UIStackView!
    
    @IBOutlet weak var suddenLessonButton: UIButton!
    @IBOutlet weak var bookLessonButton: UIButton!
    @IBOutlet weak var AIConversationButton: UIButton!
    @IBOutlet weak var moreImageView: UIImageView!
    @IBOutlet weak var recommendedTeacherCollection: UICollectionView!

    @IBOutlet weak var imagesCollection: UICollectionView!

    @IBOutlet weak var tagsView: UIStackView!

    private let recTeacherCellIdentifier = "RecommendedTeacherCell"
    private let teacherImageCellIdentifier = "TeacherImagesCollectionViewCell"
    var teacher: Teacher?
    var teacherImages : [String] = ["blackpink","meovv","blackpinkOT4","meovvot5"]
    var recommendedTeachers: [Teacher] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Teacher Detail"

        if MyManager.shared.isLoggedIn {
            print("Im logged in")
        }else{
            print("Im not logged in")
        }

        imagesCollection.delegate = self
        imagesCollection.dataSource = self
        imagesCollection.register(UINib(nibName: teacherImageCellIdentifier, bundle: nil), forCellWithReuseIdentifier: teacherImageCellIdentifier)

        let nib = UINib(nibName: recTeacherCellIdentifier, bundle: nil)
        recommendedTeacherCollection.register(nib, forCellWithReuseIdentifier: recTeacherCellIdentifier)

        recommendedTeacherCollection.dataSource = self
        recommendedTeacherCollection.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMoreIcon))

        displayTeacherDetails()
//        setupTeacherImage()
        setupLessonButtons()

        moreImageView.isUserInteractionEnabled = true
        moreImageView.addGestureRecognizer(tapGesture)


        print("Recommended teachers count: \(recommendedTeachers.count)")
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imagesCollection {
            return teacherImages.count
        } else if collectionView == recommendedTeacherCollection {
            return recommendedTeachers.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imagesCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teacherImageCellIdentifier, for: indexPath) as! TeacherImagesCollectionViewCell
            cell.imageView.image = UIImage(named: teacherImages[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recTeacherCellIdentifier, for: indexPath) as! RecommendedTeacherCell
            let recommendedTeacher = recommendedTeachers[indexPath.item]
            cell.configureCell(recommendedTeacher)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == imagesCollection {
            return CGSize(width: 170, height: 168)
        } else if collectionView == recommendedTeacherCollection {
            return CGSize(width: 140, height: 250)
        }
        return .zero

    }

    @objc func didTapMoreIcon() {
        print("Icon Tapped")

        let alertController = UIAlertController(
            title: "More Icon",
            message: "More teacher details",
            preferredStyle: .actionSheet
        )

        let reportAction = UIAlertAction(
            title: "Report",
            style: .destructive
        )

        let cancelAction = UIAlertAction (
            title: "Cancel",
            style: .cancel,
            handler: nil
        )

        alertController.addAction(reportAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true)


    }

    func setupLessonButtons() {
        configureButton(suddenLessonButton, title: "Sudden Lesson", imageName: "online-lesson" , color: "SlateBlue",  fontColor: "")
        configureButton(bookLessonButton, title: "Book Lesson", imageName: "calendar", color: "White", fontColor: "Black")
        configureButton(AIConversationButton, title: "AI English Conversation / Free Talk", imageName: "online-advise", color: "SlateBlue",  fontColor: "")
    }

    private func configureButton(_ button: UIButton, title: String, imageName: String, color: String, fontColor: String) {
        guard let originalImage = UIImage(named: imageName) else { return }
        let resizedImage = resizeImage(originalImage, to: CGSize(width: 24, height: 24))

        var config = UIButton.Configuration.filled()
        config.title = title
        config.image = resizedImage
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.baseBackgroundColor = UIColor(named: color)
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)

        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        if let uiColor = UIColor(named: fontColor) {
            container.foregroundColor = uiColor
        }
        config.attributedTitle = AttributedString(title, attributes: container)

        button.configuration = config
    }

    private func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }


    func displayTeacherDetails() {
        guard let teacher = teacher else { return }
        print(teacher.countryImage)
        teacherName.text = teacher.nameEng
        teacherAge.text = "(Age: \(String(describing: teacher.age)))"
        teacherAddress.text = teacher.countryName
//        teacherImage.image = UIImage(named: teacher.imageMain ?? "" )
//        teacherImageBig.image = UIImage(named: teacher.imageMain ?? "")
//        teacherCountryFlag.image = UIImage(named: teacher.countryImage ?? "")

        teacherLessonCount.text = "\(String(describing: teacher.lessons)) lessons"
        teacherKidsRating.text = "\(String(format: "%.2f", teacher.kidsRating ?? 0.0))"
        //        teacherLectureHistory.text = teacher.lectureHistory
        teacherFavoriteCount.text = "\(String(describing: teacher.favoriteCount ?? Int(0.0))) favorites"
        teacherRating.text = "\(String(format: "%.2f", teacher.rating ?? 0.0))"

        if let urlString = teacher.imageMain, let url = URL(string: urlString) {
            teacherImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            teacherImageBig.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }

        if let urlCountryString = teacher.countryImage, let urlCountry = URL(string: urlCountryString) {
            print(urlCountryString)
            teacherCountryFlag.kf.setImage(with: urlCountry, placeholder: UIImage(named: "placeholder"))
        }

        traitOne.text = "Friendly"
        traitTwo.text = "Good Grammar"
        traitThree.text = "Good Listener"

        let tags: [String] = ["50% OFF Callan","100% OFF Callan","For Kids"]
        configureTags(tags)

        let hobbies: [String] = ["Travelling","Swimming","Reading"]
        configureHobbies(hobbies)
    }

    func configureTags(_ tags: [String]) {
        // Clear any existing rows
        tagsView.arrangedSubviews.forEach {
            tagsView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        var index = 0
        while index < tags.count {
            // Create a horizontal row
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 8
            rowStack.alignment = .leading
            rowStack.distribution = .fillProportionally

            // Add up to 2 tags per row
            for _ in 0..<2 {
                if index < tags.count {
                    let label = UILabel()
                    label.text = "  \(tags[index])  "
                    label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
                    label.textColor = .white
                    label.backgroundColor = .systemBlue
                    label.layer.cornerRadius = 5
                    label.layer.masksToBounds = true
                    label.setContentHuggingPriority(.required, for: .horizontal)
                    rowStack.addArrangedSubview(label)
                    index += 1
                }
            }

            tagsView.addArrangedSubview(rowStack) // Add horizontal row to the vertical stack
        }
    }

    func configureHobbies(_ hobbies: [String]) {
        // Clear any existing rows
        hobbiesView.arrangedSubviews.forEach {
            hobbiesView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        var index = 0
        while index < hobbies.count {
            // Create a horizontal row
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 8
            rowStack.alignment = .leading
            rowStack.distribution = .fillProportionally

            // Add up to 2 tags per row
            for _ in 0..<2 {
                if index < hobbies.count {
                    let label = UILabel()
                    label.text = "  \(hobbies[index])  "
                    label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
                    label.textColor = .white
                    label.backgroundColor = .subPurple
                    label.layer.cornerRadius = 5
                    label.layer.masksToBounds = true
                    label.setContentHuggingPriority(.required, for: .horizontal)
                    rowStack.addArrangedSubview(label)
                    index += 1
                }
            }

            hobbiesView.addArrangedSubview(rowStack) // Add horizontal row to the vertical stack
        }
    }

    func setupTeacherImage(){
        teacherImage.layer.cornerRadius = teacherImage.frame.size.width / 2
        teacherImage.clipsToBounds = true
    }

//    func setupButtons(){
//        var favoriteConfig = UIButton.Configuration.plain()
//        favoriteConfig.title = "Favorite"
//        favoriteConfig.image = UIImage(systemName: "heart.fill")
//        favoriteConfig.imagePadding = 8
//        favoriteConfig.baseForegroundColor = .white
//        favoriteConfig.cornerStyle = .medium
//        favoriteButton.configuration = favoriteConfig
//
//        var shareConfig = UIButton.Configuration.plain()
//        shareConfig.title = "Share teacher"
//        shareConfig.image = UIImage(systemName: "square.and.arrow.up")
//        shareConfig.imagePadding = 8
//        shareConfig.baseForegroundColor = .white
//        shareConfig.cornerStyle = .medium
//        shareButton.configuration = shareConfig
//    }

//    override func viewDidLayoutSubviews()
//    {
//        super.viewDidLayoutSubviews()
//
//        let color1 = UIColor(hue: 40/360, saturation: 0.63, brightness: 0.85, alpha: 1)
//        let color2 = UIColor(hue: 22/360, saturation: 0.94, brightness: 0.79, alpha: 1)
//
//        applyGradient(to: favoriteButton, colors: [color1, color2])
//        applyGradient(to: shareButton, colors: [color1, color2])
//    }

//    func applyGradient(to button: UIButton, colors: [UIColor]) {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = colors.map { $0.cgColor }
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        gradientLayer.frame = button.bounds
//        gradientLayer.cornerRadius = button.layer.cornerRadius
//
//
//        button.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
//        button.layer.insertSublayer(gradientLayer, at: 0)
//    }

}
