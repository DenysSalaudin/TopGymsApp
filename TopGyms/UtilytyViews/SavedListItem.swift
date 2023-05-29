//
//  SavedListItem.swift
//  TopGyms
//
//  Created by Denis on 5/26/23.
//

import SwiftUI

struct SavedListItem: View {
    @ObservedObject var savedModel : SavedModel
    @ObservedObject var viewModel : ViewModel
    @State private var load = true
    init(placeID: String?,viewModel:ViewModel) {
        self.savedModel = SavedModel(placeID: placeID)
        self.viewModel = viewModel
    }
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                ImageView2(photoReference: savedModel.photoReference)
                VStack(alignment: .leading) {
                    Text(savedModel.name)
                        .foregroundColor(.black)
                        .font(savedModel.name.count > 20 ? .headline : .title)
                        .bold()
                        .multilineTextAlignment(.leading)
                    HStack {
                        StarsView(rating: savedModel.rating)
                        Text(savedModel.openNow ? "Open":"Closed")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 80, height: 28)
                            .background(savedModel.openNow ? Color.green : Color.red)
                            .cornerRadius(12)
                            .bold()
                    }
                }
            }
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 1)
                .padding(.top,8)
                .foregroundColor(.accentColor)
        }
    }
}

struct SavedListItem_Previews: PreviewProvider {
    static var previews: some View {
        SavedListItem(placeID: "", viewModel: ViewModel())
    }
}
