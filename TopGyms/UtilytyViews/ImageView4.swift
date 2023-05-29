//
//  ImageView4.swift
//  TopGyms
//
//  Created by Denis on 5/25/23.
//

import Foundation
import SwiftUI

struct ImageView4: View {
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
                .frame(width: 145,height: 145)
                .mask(CubeShape())
        } else {
                ProgressView()
                    .frame(width: 145,height: 145)
            }
    }
}

struct ImageView_Previews4: PreviewProvider {
    static var previews: some View {
        ImageView4(photoReference: "")
    }
}
