//
//  MessageView.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 16/03/2023.
//

import Foundation
import SwiftUI

struct MessageView: View {
    let message: String
    let color: Color

    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.title)
                .foregroundColor(color)
            Spacer()
        }
    }
}
