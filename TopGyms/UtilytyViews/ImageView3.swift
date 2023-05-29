//
//  ImageView3.swift
//  TopGyms
//
//  Created by Denis on 5/25/23.
//

import Foundation
import SwiftUI

struct ImageView3: View {
    @ObservedObject var urlImage : UrlImageModel
    init(photoReference: String?) {
        self.urlImage = UrlImageModel(photoReference: photoReference)
    }
    @State private var isProgres = false
    var body: some View {
        if let image = urlImage.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200,height: 300)
                .cornerRadius(15)
        } else {
                ProgressView()
                    .frame(width: 200,height: 300)
            }
    }
}

struct ImageView_Previews3: PreviewProvider {
    static var previews: some View {
        ImageView3(photoReference: "")
    }
}
