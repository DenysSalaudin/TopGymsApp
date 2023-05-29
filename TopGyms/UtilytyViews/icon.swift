//
//  icon.swift
//  TopGyms
//
//  Created by Denis on 5/28/23.
//

import SwiftUI

struct icon: View {
    var body: some View {
        HStack(spacing: 4) {
            Text("T")
                .font(.title)
                .bold() 
            Image(systemName: "dumbbell.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 55,height: 55)
                .foregroundColor(.accentColor)
            Text("G")
                .font(.title)
                .bold()
        }
    }
}

struct icon_Previews: PreviewProvider {
    static var previews: some View {
        icon()
    }
}
