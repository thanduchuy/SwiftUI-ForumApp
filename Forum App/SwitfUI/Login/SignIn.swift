//
//  SignIn.swift
//  Forum App
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
struct SignIn: View {
    @State var email: String = ""
    @State var pass: String = ""
    @State var error: String = ""
    @Binding var status : Bool
    @EnvironmentObject var OB: getData
    @EnvironmentObject var session: AuthService
    @EnvironmentObject var alert : AlertServices
    @EnvironmentObject var noti : NotificationService
    @EnvironmentObject var user : UserServices
    func signIn() {
        self.session.SignIn(email: self.email, pass: self.pass) { (result, err) in
            if err != nil {
                self.error = err!.localizedDescription
                self.status = false
            } else {
                _ = self.OB.total(uid:Auth.auth().currentUser!.uid)
                self.alert.friend = [UserInfo]()
                self.alert.dataFriend()
                self.noti.data = [Noti]()
                self.noti.getData()
                self.user.reload()
                self.resetForm()
                self.status = true
            }
        }
    }
    func resetForm() {
        self.email = ""
        self.pass = ""
        self.error = ""
    }
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Spacer()
                Text("Hello There!").font(.largeTitle)
                TextField("Enter Email ...", text: $email)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(UIScreen.main.bounds.height/2).padding(.bottom, 15)
                
                SecureField("Enter Password...", text: $pass)
                    .padding(15)
                    .foregroundColor(.white)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(UIScreen.main.bounds.height/2).padding(.bottom, 15)
                Text(self.error).bold()
                Button(action: signIn) {
                    HStack {
                        Text("SIGN IN")
                            .font(.system(size: 20)).bold()
                    }
                    .frame(minWidth: 0, maxWidth: 250)
                    .padding()
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    
                }
                Spacer()
                NavigationLink(destination: SignUp(status:$status)) {
                    HStack {
                        Text("You are not a member?").font(.system(size: 18)).foregroundColor(.white)
                        Text("Sign Up").font(.system(size: 20)).foregroundColor(.white).bold()
                    }
                }
            }.padding()
        }
    }
}
struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(status: Binding.constant(false)).environmentObject(AuthService())
    }
}
