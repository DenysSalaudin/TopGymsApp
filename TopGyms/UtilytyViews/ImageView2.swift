//
//  ImageView2.swift
//  TopGyms
//
//  Created by Denis on 5/24/23.
//

import Foundation
import SwiftUI

struct ImageView2: View {
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
                .frame(width: 120,height: 120)
                .mask(CubeShape())
        } else {       
                ProgressView()
                    .frame(width: 120,height: 120)
        }
    }
}

struct ImageView_Previews2: PreviewProvider {
    static var previews: some View {
        ImageView2(photoReference: "")
    }
}
struct CubeShape: Shape {
    func path(in rect: CGRect) -> Path {
        let size = min(rect.size.width, rect.size.height)
        let origin = CGPoint(x: rect.midX - size / 2, y: rect.midY - size / 2)
        let cubeRect = CGRect(origin: origin, size: CGSize(width: size, height: size))
        return Path(roundedRect: cubeRect, cornerRadius: size / 6)
    }
}
