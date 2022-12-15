//
//  HeaderViewModel.swift
//  YouTubeCloneSwiftUI-Day1
//
//  Created by Apple  on 15/12/22.
//

import SwiftUI

class HeaderViewModel: ObservableObject {
//to capture start MinY value for calculations....
    @Published var startMinY:CGFloat = 0
    @Published var offset:CGFloat = 0
    
    //header view property
    @Published var headerOffset:CGFloat = 0
    
    //it will be used for getting top and bottom offsets for header view
    @Published var topScrolledOffset:CGFloat = 0
    @Published var bottomScrolledOffset:CGFloat = 0
    
}
