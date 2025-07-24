//
//  TeacherReservedSwiftUIView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/21/25.
//

import SwiftUI

struct TeacherFavoritesSwiftUIView: View {
    @ObservedObject var viewModel: TeacherViewModel
    let favoriteTeachers: [Teacher]

    var body: some View {
        VStack(spacing: 4){
            HStack(alignment: .center){
                Text("Favorite Teachers")
                    .font(.headline)
                    .fontWeight(.semibold)
            }

            List(favoriteTeachers, id: \.id) { teacher in
                HStack{
                    AsyncImage(url: URL(string: teacher.imageMain ?? "")) { image in
                        image .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                    } placeholder: {
                        Color.gray
                    }
                    DetailsSection(viewModel: viewModel)
                }
            }
        }
    }
}



//#Preview {
//    TeacherReservedSwiftUIView()
//}
