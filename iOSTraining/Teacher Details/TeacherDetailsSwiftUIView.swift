//
//  TeacherDetailsSwiftUIView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/19/25.
//

import SwiftUI

struct TeacherDetailsSwiftUIView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @EnvironmentObject var teacherList: TeacherListViewModel

    var body: some View {

        let recommendedTeachers = Array(
            teacherList.teachers
                .filter { $0.teacher.id != viewModel.teacher.id }
                .prefix(5)
        )

        ScrollView {
            VStack(spacing: 25) {
                HeaderView(
                    imageURL: viewModel.teacher.imageMain ?? "",
                    name: viewModel.teacher.nameEng ?? "Unknown",
                    age: viewModel.teacher.age ?? 0,
                    statusColor: viewModel.teacher.status ?? 0
                )

                TeacherDetailView(viewModel: viewModel)
                LessonButtonSection(viewModel: viewModel)
                StudentActions(viewModel: viewModel)
                DetailTabSelector(viewModel: viewModel)

                ImagesGridView()
                RecommendedTeachersCollectionView(viewModel: viewModel, recommendedTeachers: recommendedTeachers)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 40)
            }
        }
}


struct HeaderView: View {
    var imageURL: String
    var name: String
    var age: Int
    var statusColor: Int

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .scaledToFill()
            .frame(width: 30, height: 30)
            .clipShape(Circle())

            TeacherStatusIndicator(status: statusColor)
                .frame(width: 10, height: 10)

            Text(name)
                .font(.subheadline)
                .lineLimit(1)

            Text("(Age: \(age))")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer()

            Button(action: {
                print("Menu tapped")
            }) {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.primary)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.top, 30)
        .padding(.horizontal)
    }
}

struct TeacherDetailView: View {
    let viewModel: TeacherViewModel

    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: viewModel.teacher.imageMain ?? "")) { image in
                    image .resizable()
                    .scaledToFill()
                    .frame(width: 140 , height: 180)
            } placeholder: {
                Color.gray
            }

            DetailsSection(viewModel: viewModel)
        }
        .frame(height: 200)
    }
}

struct DetailsSection: View {
    let viewModel: TeacherViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CountryDetailView(
                imageUrl: viewModel.teacher.countryImage ?? "",
                label: viewModel.teacher.countryName ?? "Unknown"
            )
            IconWithTextView(systemImageName: "training", label: "1 year and 1 month")
            IconWithTextView(systemImageName: "star", label: "\(viewModel.teacher.rating ?? 0.0)")
            IconWithTextView(systemImageName: "children", label: "\(viewModel.teacher.kidsRating ?? 0.0)")
            IconWithTextView(systemImageName: "analysis", label: "\(viewModel.teacher.lessons ?? 0) lessons")
            IconWithTextView(systemImageName: "heart", label: "\(viewModel.teacher.favoriteCount ?? 0) favorites")
            IconWithTextView(systemImageName: "hand", label: "11-11-2025")
        }.padding()
    }
}

struct LessonButtonSection: View {
    @ObservedObject var viewModel: TeacherViewModel

    var body: some View {
        VStack{

            ImageButton(imageName: "history", title: "Proceed to Sudden Lesson") {
                print("Button tapped")
            }

            ImageButton(imageName: "online-lesson", title: "Booked Lesson") {
                print("Delete tapped")
            }

            ImageButton(imageName: "calendar 1", title: "Reserve Teacher") {
                viewModel.reserveTeacher()
            }

        }.frame(maxWidth: .infinity)
    }

}

struct StudentActions: View {
    @ObservedObject var viewModel: TeacherViewModel

    var body: some View{

        HStack(spacing: 30){
            IconAboveLabelView(
                imageName: viewModel.isFavorite ? "heart.fill" : "heart",
                label: "Favorite",
                useSystemImage: true,
                iconSize: 22,
                spacing: 8,
                foregroundColor: viewModel.isFavorite ? Color.orange : Color.white,
                onTap: {
                    viewModel.toggleFavorite()
                }
            )

            IconAboveLabelView(
                imageName: "arrow.clockwise",
                label: "Refresh",
                useSystemImage: true,
                iconSize: 22,
                spacing: 8,
                foregroundColor: Color.white,
                onTap: {
                   print("Refresh")
                }
            )

            IconAboveLabelView(
                imageName: "paperplane",
                label: "Share",
                useSystemImage: true,
                iconSize: 22,
                spacing: 8,
                foregroundColor: Color.white,
                onTap: {
                    print("Share")
                }
            )

            IconAboveLabelView(
                imageName: "note.text",
                label: "Keep Note",
                useSystemImage: true,
                iconSize: 22,
                spacing: 8,
                foregroundColor: Color.white,
                onTap: {
                    print("Noted")
                }
            )
        }.frame(maxWidth: .infinity)

    }

}

struct DetailTabSelector : View {

    @State private var selectedTabIndex: Int = 0
    let tabTitles = ["Tutor's Profile", "Lesson Details", "Reviews"]
    let viewModel: TeacherViewModel

    var body: some View{

        VStack{

            ButtonSelectorView(selectedIndex: $selectedTabIndex, titles: tabTitles)
                .padding(.horizontal)
            Group {
                if selectedTabIndex == 0 {
                    TeacherDetailSectionView(viewModel: viewModel)
                } else if selectedTabIndex == 1 {
                    Text("Lesson Content")
                } else if selectedTabIndex == 2 {
                    Text("Reviews Content")
                }
            }
            .padding()
        }

    }

}

struct TeacherDetailSectionView: View {
    let viewModel: TeacherViewModel

    var body: some View {
            VStack(alignment: .leading, spacing: 24) {

                VStack(alignment: .leading, spacing: 8) {
                    Text("Introduction")
                        .font(.headline)
                    if let message = viewModel.teacher.messageEng, !message.isEmpty {
                        Text(message)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                    } else {
                        Text("No introduction provided.")
                            .font(.body)
                            .italic()
                            .foregroundColor(.gray)
                    }
                }


                VStack(alignment: .leading, spacing: 8) {
                    Text("Coins consumed")
                        .font(.headline)
                    Text("Sudden Lesson : No coins required")
                    Text("Booked Lesson : 100 coins")
                }


                VStack(alignment: .leading, spacing: 8) {
                    Text("Features")
                        .font(.headline)
                    HStack {
                        TagView(
                            text: "Friendly" ,
                            backgroundColor: .white,
                            foregroundColor: .black,
                            padding: EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
                        )
                        TagView(text: "Good Listener", backgroundColor: .white,                             foregroundColor: .black,
                                padding: EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
                        )
                        TagView(text: "Good Grammar", backgroundColor: .white,                             foregroundColor: .black,
                                padding: EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
                        )
                    }
                }


                VStack(alignment: .leading, spacing: 8) {
                    Text("Hobbies")
                        .font(.headline)
                    HStack {
                        TagView(
                            text: "Singing" ,
                            backgroundColor: .white,
                            foregroundColor: .black,
                            padding: EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
                        )
                        TagView(text: "Music", backgroundColor: .white,                             foregroundColor: .black,
                                padding: EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
                    }
                }


                VStack(alignment: .leading, spacing: 8) {
                    Text("Generation choosing this instructor")
                        .font(.headline)

                    GenerationBar(label: "~9 ye...", percentage: 0.0)
                    GenerationBar(label: "the t...", percentage: 0.0)
                    GenerationBar(label: "one's...", percentage: 66.67)
                    GenerationBar(label: "30s", percentage: 0.0)
                    GenerationBar(label: "40s", percentage: 0.0)
                    GenerationBar(label: "50s", percentage: 33.33)
                    GenerationBar(label: "60s-", percentage: 0.0)
                }
                //Spacer()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.black)
        }
}

struct GenerationBar: View {
    let label: String
    let percentage: Double

    var body: some View {
        HStack {
            Text(label)
                .frame(width: 60, alignment: .leading)
                .font(.footnote)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 10)

                    Capsule()
                        .fill(Color.white)
                        .frame(width: geometry.size.width * CGFloat(percentage / 100), height: 10)
                }
            }
            .frame(height: 10)

            Text(String(format: "%.2f%%", percentage))
                .frame(width: 60, alignment: .trailing)
                .font(.footnote)
        }
    }
}

struct ImagesGridView: View {

    let images = ["blackpink", "meovv", "meovvot5", "blackpinkOT4"]

    @State private var showAll = false

    let columns = [
        GridItem(.fixed(110), spacing: 8),
        GridItem(.fixed(110), spacing: 8),
        GridItem(.fixed(110), spacing: 8)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text("Gallery")
                .font(.headline)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(showAll ? images : Array(images.prefix(3)), id: \.self) { image in
                    Image(image)
                        .resizable()
                        .frame(width: 130, height: 130)
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
            }

            if images.count > 3 {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showAll.toggle()
                        }
                    }) {
                        Text(showAll ? "See less" : "See more")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }
                    .padding(.trailing, 18)
                }
            }
        }
    }
}

struct RecommendedTeachersCollectionView: View {
    let viewModel: TeacherViewModel // current teacher
    let recommendedTeachers: [TeacherViewModel]
    @EnvironmentObject var teacherList: TeacherListViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended Teachers")
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(recommendedTeachers, id: \.teacher.id) { teacherVM in
                        NavigationLink(destination: TeacherDetailsSwiftUIView(viewModel: teacherVM).environmentObject(teacherList)
                        ) {
                            RecommendedTeacherView(viewModel: teacherVM)
                                .frame(width: 140, height: 230)
                                .cornerRadius(12)
                                .shadow(radius: 2)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RecommendedTeacherView: View {
    let viewModel: TeacherViewModel

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Top Half – Image
                AsyncImage(url: URL(string: viewModel.teacher.imageMain ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: geometry.size.height / 2)
                        .clipped()
                } placeholder: {
                    Color.gray
                        .frame(height: geometry.size.height / 2)
                }

                // Bottom Half – Info
                VStack(alignment: .leading ,spacing: 4) {
                    Text(viewModel.teacher.nameEng ?? "")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(alignment: .center)
                    CountryDetailView(
                        imageUrl: viewModel.teacher.countryImage ?? "",
                        label: viewModel.teacher.countryName ?? "Unknown"
                    )
                    IconWithTextView(systemImageName: "star", label: "\(viewModel.teacher.rating ?? 0.0)")
                    IconWithTextView(systemImageName: "analysis", label: "\(viewModel.teacher.lessons ?? 0) lessons")
                    IconWithTextView(systemImageName: "heart", label: "\(viewModel.teacher.favoriteCount ?? 0) favorites")
                }
                .padding(6)
                .frame(height: geometry.size.height / 2)
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
        }
    }
}


// MARK: - Preview

//struct TeacherDetailsSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeacherDetailsSwiftUIView(viewModel: TeacherViewModel(teacher: .previewSample)
//        ) .preferredColorScheme(.dark)
//    }
//}

