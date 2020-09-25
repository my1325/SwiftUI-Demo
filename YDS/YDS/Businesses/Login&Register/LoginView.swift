//
//  LoginView.swift
//  YDS
//
//  Created by mayong on 2020/8/5.
//  Copyright © 2020 mayong. All rights reserved.
//

import SwiftUI

struct LoginTextFeild<Label: View>: View {
    
    @State var text: String

    var body: some View {
        TextField("", text: $text)
    }
    
//    init(@ViewBuilder _ icon: () -> View, @ViewBuilder label: () -> View) {
//
//    }
}

struct LoginView: View {
    
    struct InputView: View {
        let iconName: String
        let placeholder: String
        let isSecure: Bool
        
        @State var inputText: String
        
        var body: some View {
            VStack {
                HStack {
                    Image(iconName)
                    if !isSecure {
                    TextField(placeholder, text: $inputText)
                            .keyboardType(.numberPad)
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    } else {
                        SecureField(placeholder, text: $inputText)
                            .keyboardType(.default)
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                }
                Color.colorWithHexString("#6F6F6F").frame(height: 1 / iphone_scale)
            }.frame(height: 50)
        }
    }
    
    struct LoginButton<Label>: View where Label: View {
        
        let content: () -> Label
        let action: () -> Void
        
        init(@ViewBuilder content: @escaping () -> Label, action: @escaping () -> Void) {
            self.content = content
            self.action = action
        }
        
        var body: some View {
            ZStack {
                Color.clear
                self.content()
            }.onTapGesture {
                self.action()
            }
        }
    }
    
    var body: some View {
        ZStack {
            Image("login_main_back")
            VStack(alignment: .leading) {
                InputView(iconName: "login_input_nick", placeholder: "请输入手机号", isSecure: false, inputText: "")
                InputView(iconName: "login_input_password_unselect", placeholder: "请输入密码", isSecure: true, inputText: "")
                Button(action: {
                    /// TODO 验证码登录
                }, label: {
                    Text("验证码登录")
                        .foregroundColor(Color.colorWithHexString("#4CD0CA"))
                        .font(.system(size: 12))
                })
                Spacer().frame(height: 40)
                LoginButton(content: {
                    Text("登录").font(.system(size: 14)).foregroundColor(.white)
                }) {
                    /// TODO 点击登录
                }
                .background(Color.colorWithHexString("#4CD0CA"))
                .frame(height: 50)
                .cornerRadius(25)
                Spacer().frame(height: 20)
                HStack {
                    Button(action: {
                        /// TODO 验证码登录
                    }, label: {
                        Text("忘记密码")
                            .foregroundColor(Color.colorWithHexString("#4CD0CA"))
                            .font(.system(size: 12))
                    })
                    Spacer()
                    Button(action: {
                        /// TODO 验证码登录
                    }, label: {
                        Text("立即注册")
                            .foregroundColor(Color.colorWithHexString("#4CD0CA"))
                            .font(.system(size: 12))
                    })
                }
            }
            .padding([.leading, .trailing], 16)
            .frame(height: iphone_height)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
