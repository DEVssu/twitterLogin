//
//  ContentView.swift
//  twitterLogin
//
//  Created by 한승수 on 2023/05/15.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var provider = OAuthProvider(providerID: "twitter.com") // 트위터 로그인시 필요
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Button {
                twitterSignIn { response in
                   print("login success")
                }
            } label: {
                ZStack(alignment: .center) {
                    HStack{
                        ZStack{
                            Image("logoTwitter")
                                .frame(width: 15, height: 18, alignment: .center)
                        }
                        .frame(width: 40, height: 40, alignment: .center)
                        
                        Spacer()
                    }
                    .padding(.leading, 6)
                    
                    
                    Text(NSLocalizedString("Twitter로 계속하기", comment: ""))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading, 5)
                }
                .frame(height: 52, alignment: .center)
                .background(
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color(red: 52 / 255, green: 152 / 255, blue: 219 / 255))
                        
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color(red: 52 / 255, green: 152 / 255, blue: 219 / 255))
                    }
                )
            }
        }
        .padding([.horizontal,.bottom], 20)
    }
    
    func twitterSignIn(completion: @escaping (String) -> Void) {
        provider.getCredentialWith(nil) { credential, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let credential = credential {
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }

                    if let authResult = authResult {
                        // user infomation
                        if let userName = authResult.user.displayName,
                           let email = authResult.user.email,
                           let image = authResult.user.photoURL {

                            let userId: String = String(authResult.user.uid)
                            var imageUrl: String = image.absoluteString
                        }
                    }
                }
            }
        }
    }
}
