//
//  ImageView.swift
//  TopGyms
//
//  Created by Denis on 5/23/23.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var urlImage : UrlImageModel
    init(photoReference: String?) {
        self.urlImage = UrlImageModel(photoReference: photoReference)
    }
    @State private var isProgres = false
    var body: some View {
        if let image = urlImage.image {
            Image(uiImage: image)
                .resizable()
                .frame(width: 60,height: 60)
                .clipShape(Circle())
        } else {
            ProgressView()
                .frame(width: 60,height: 60)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(photoReference: "")
    }
}

