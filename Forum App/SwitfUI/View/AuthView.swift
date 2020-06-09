//
//  AuthView.swift
//  Forum App
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    @Binding var status : Bool
    var body: some View {
        NavigationView {
            SignIn(status: $status)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(status: Binding.constant(true)).environmentObject(AuthService())
    }
}
