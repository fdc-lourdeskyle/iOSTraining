//
//  TeacherDetailsSwiftUIView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/19/25.
//

import SwiftUI

struct TeacherDetailsSwiftUIView: View {
    let viewModel: TeacherViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderView(
                    imageURL: viewModel.teacher.imageMain ?? "",
                    name: viewModel.teacher.nameEng ?? "Unknown",
                    age: viewModel.teacher.age ?? 0,
                    statusColor: .red
                )

                TeacherDetailView(viewModel: viewModel)
                LessonButtonSection()
                StudentActions()
                DetailTabSelector(viewModel: viewModel)
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
    var statusColor: Color

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

            Circle()
                .fill(statusColor)
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
            } placeholder: {
                Color.gray
            }
            .aspectRatio(140/300, contentMode: .fit)
            .clipped()

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

    var body: some View {
        VStack{

            ImageButton(imageName: "history", title: "Proceed to Sudden Lesson") {
                print("Button tapped")
            }

            ImageButton(imageName: "calendar 1", title: "Booked Lesson") {
                print("Delete tapped")
            }

        }.frame(maxWidth: .infinity)
    }

}

struct StudentActions: View {

    var body: some View{

        HStack(spacing: 30){
            IconAboveLabelView(
                imageName: "heart.fill",
                label: "Favorite",
                useSystemImage: true,
                iconSize: 22,
                spacing: 8
            )

            IconAboveLabelView(
                imageName: "arrow.clockwise",
                label: "Refresh",
                useSystemImage: true,
                iconSize: 22,
                spacing: 8
            )

            IconAboveLabelView(
                imageName: "paperplane",
                label: "Share",
                useSystemImage: true,
                iconSize: 22,
                spacing: 8
            )

            IconAboveLabelView(
                imageName: "note.text",
                label: "Keep Note",
                useSystemImage: true,
                iconSize: 22,
                spacing: 8
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

                ImagesGridView()

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
        GridItem(.fixed(100), spacing: 8),
        GridItem(.fixed(100), spacing: 8),
        GridItem(.fixed(100), spacing: 8)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text("Gallery")
                .font(.headline)

            // ✅ Removed inner ScrollView
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(showAll ? images : Array(images.prefix(3)), id: \.self) { image in
                    Image(image)
                        .resizable()
                        .frame(width: 100, height: 90)
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 8)

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
                    .padding(.trailing, 8)
                }
            }
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

