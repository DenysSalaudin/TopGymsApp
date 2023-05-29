//
//  StarsView.swift
//  TopGyms
//
//  Created by Denis on 5/25/23.
//

import SwiftUI

struct StarsView: View {
    var rating : Double?
    var body : some View {
        HStack {
            if rating ?? 0.0 >= 0.5 && rating ?? 0.0 <= 0.9 {
                Image(systemName: "star.leadinghalf.filled")
                    .foregroundColor(.yellow)
            } else {
                if rating ?? 0.0 >= 1 {
                    Image(systemName:"star.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName:"star")
                        .foregroundColor(.yellow)
                }
            }
            
            if rating ?? 0.0 >= 1.5 && rating ?? 0.0 <= 1.9 {
                Image(systemName: "star.leadinghalf.filled")
                    .foregroundColor(.yellow)
            } else {
                if rating ?? 0.0 >= 2 {
                    Image(systemName:"star.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName:"star")
                        .foregroundColor(.yellow)
                }
            }
            
            if rating ?? 0.0 >= 2.5 && rating ?? 0.0 <= 2.9 {
                Image(systemName: "star.leadinghalf.filled")
                    .foregroundColor(.yellow)
            } else {
                if rating ?? 0.0 >= 3 {
                    Image(systemName:"star.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName:"star")
                        .foregroundColor(.yellow)
                }
            }
            
            if rating ?? 0.0 >= 3.5 && rating ?? 0.0 <= 3.9 {
                Image(systemName: "star.leadinghalf.filled")
                    .foregroundColor(.yellow)
            } else {
                if rating ?? 0.0 >= 4 {
                    Image(systemName:"star.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName:"star")
                        .foregroundColor(.yellow)
                }
            }
            
            if rating ?? 0.0 >= 4.5 && rating ?? 0.0 <= 4.9 {
                Image(systemName: "star.leadinghalf.filled")
                    .foregroundColor(.yellow)
            } else {
                if rating ?? 0.0 >= 5 {
                    Image(systemName:"star.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName:"star")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView()
    }
}
