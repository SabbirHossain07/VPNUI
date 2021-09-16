//
//  CustomCorners.swift
//  VPNUI
//
//  Created by Sopnil Sohan on 16/9/21.
//

import SwiftUI

struct CustomCorners: Shape {
    
    var redius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: redius, height: redius))
        
        return Path(path.cgPath)
    }
}
