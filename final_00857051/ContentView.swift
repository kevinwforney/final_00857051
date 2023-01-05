//
//  ContentView.swift
//  final_00857051
//
//  Created by User03 on 2022/12/21.
//

import SwiftUI

extension Text {
    func MessageStyle() -> some View {
        self
            .font(.custom("FrizQua-ReguItalOS", size: 17))
            .foregroundColor(Color("ButtonColor"))
    }
}

struct ContentView: View {
    @EnvironmentObject var saver:ChampionSaver
    /*
    View Mode:
     0: Sign Up View
     1: App View
     ２：Log In View
    */
    @State private var selection: Int = 1
    init() {
        UITabBar.appearance().barTintColor = UIColor.black//(Color("LeagueGold"))
    }
    @State private var viewMode: Int = 0
    @State private var showPassword: Bool = false
    @State private var isLoading: Bool = false
    @State private var signUpUserNameMessage = ""
    @State private var signUpEmailMessage = ""
    @State private var signUpPasswordMessage = ""
    @State private var userNameSignUpInput = ""
    @State private var emailSignUpInput = ""
    @State private var passwordSignUpInput = ""
    @State private var logInPasswordMessage = ""
    @State private var userAccountLoginInput = ""
    @State private var passwordLoginInput = ""
    
    func FavQsSignUp(userName: String = "", email: String = "", password: String = "") {
        var isValid: Bool = true
        if userName.trimmingCharacters(in: CharacterSet.whitespaces) == "" || userName.count < 2{
            signUpUserNameMessage = "2-20 character length"
            isValid = false
        } else if userName.contains("_") {
            signUpUserNameMessage = "Invalid character(s)"
            isValid = false
        }
        if email.trimmingCharacters(in: CharacterSet.whitespaces) == "" {
            signUpEmailMessage = "Email must not be empty"
            isValid = false
        }
        if password.trimmingCharacters(in: CharacterSet.whitespaces) == "" || password.count < 5 || password.count > 20 {
            signUpPasswordMessage = "5-20 character length"
            isValid = false
        }
        if !isValid {
            isLoading = false
            return
        }
        
        let url = URL(string: "https://favqs.com/api/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token token=dd1e779881e3541da7af1ed7ec2b18d3", forHTTPHeaderField: "Authorization")
        let data = "{\"user\": {\"login\": \"\(userName)\",\"email\": \"\(email)\",\"password\": \"\(password)\"}}".data(using: .utf8)
        request.httpBody = data
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                if statusCode == 200{
                    let dataToString = String(data: data, encoding: .utf8)!
                    print(dataToString)
                    if !dataToString.contains("error_code") {
                        let decoder = JSONDecoder()
                        do {
                            let dataItem = try decoder.decode(UserTokenForLogin.self, from: data)
                            DispatchQueue.main.async {
                                saver.UserData.removeAll()
                                saver.UserData.append(dataItem)
                                signUpUserNameMessage  = ""
                                signUpEmailMessage = ""
                                signUpPasswordMessage = ""
                                isLoading = false
                                viewMode = 1
                            }
                            return
                        } catch {
                            print(error)
                        }
                    } else {
                        if dataToString.contains("Username") {
                            if dataToString.contains("Username has already been taken"){
                                signUpUserNameMessage = "Username has already been taken"
                            } else if dataToString.contains("Username is too") {
                                signUpUserNameMessage = "2-20 character length"
                            } else {
                                signUpUserNameMessage = "Invalid character(s)"
                            }
                        }
                        if dataToString.contains("Email") {
                            if dataToString.contains("Email has already been taken"){
                                signUpEmailMessage = "Email has already been taken"
                            } else {
                                signUpEmailMessage = "Invalid email format"
                            }
                        }
                        if dataToString.contains("Password") {
                            signUpPasswordMessage = "5-20 character length"
                        }
                        isLoading = false
                        return
                    }
                }
            } else if let error = error {
                isLoading = false
                print(error)
            }
        }.resume()
    }
    
    func FavQsLogIn(userNameOrEmail: String = "", password: String = "") {
        if userNameOrEmail.trimmingCharacters(in: CharacterSet.whitespaces) == "" {
            logInPasswordMessage = "Invalid login or password"
            isLoading = false
            return
        }
        if password.trimmingCharacters(in: CharacterSet.whitespaces) == "" {
            logInPasswordMessage = "Invalid login or password"
            isLoading = false
            return
        }
        let url = URL(string: "https://favqs.com/api/session")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token token=dd1e779881e3541da7af1ed7ec2b18d3", forHTTPHeaderField: "Authorization")
        let data = "{\"user\": {\"login\": \"\(userNameOrEmail)\",\"password\": \"\(password)\"}}".data(using: .utf8)
        request.httpBody = data
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                if statusCode == 200 {
                    let dataToString = String(data: data, encoding: .utf8)!
                    print(dataToString)
                    if !dataToString.contains("error_code") {
                        let decoder = JSONDecoder()
                        do {
                            let dataItem = try decoder.decode(UserTokenForLogin.self, from: data)
                            DispatchQueue.main.async {
                                saver.UserData.removeAll()
                                saver.UserData.append(dataItem)
                                logInPasswordMessage = ""
                                isLoading = false
                                viewMode = 1
                            }
                            return
                        } catch {
                            isLoading = false
                            print(error)
                        }
                    } else {
                        if dataToString.contains("Invalid login or password") {
                            logInPasswordMessage = "Invalid login or password"
                        } else {
                            logInPasswordMessage = "Account lost!"
                        }
                        isLoading = false
                        return
                    }
                }
                
            } else if let error = error {
                isLoading = false
                print(error)
            }
        }.resume()
    }
    
    var body: some View {
        if viewMode == 1 {
            TabView(selection: $selection) {
                ChampionsTab()
                    .tabItem {
                        Label("Champions", systemImage: "person.3")
                    }
                    .tag(0)
                SummonerTab(viewMode: $viewMode)
                    .tabItem {
                        Label("Summoner", systemImage: "person.crop.square")
                    }
                    .tag(1)
                FavoritesTab()
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
                    .tag(2)
            }
            .accentColor(Color("LeagueGold"))
        } else if viewMode == 0 { // Sign Up View
            ZStack{
                Image("wallpaper0")
                    .resizable()
                    .scaledToFill()
                    .offset(x: 200)
                    .clipped()
                VStack{
                    Group {
                        HStack {
                            Text("Account")
                                .font(.custom("FrizQua-ReguOS", size: 20))
                            Spacer()
                            Text(signUpUserNameMessage != "" ? "\(signUpUserNameMessage)" : "")
                                .MessageStyle()
                        }
                        .padding(.horizontal)
                        TextField("2-20 characters", text: $userNameSignUpInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        HStack {
                            Text("Email")
                                .font(.custom("FrizQua-ReguOS", size: 20))
                            Spacer()
                            Text(signUpEmailMessage != "" ? "\(signUpEmailMessage)" : "")
                                .MessageStyle()
                        }
                        .padding(.horizontal)
                        TextField("mail@mail.com", text: $emailSignUpInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        HStack{
                            Text("Password")
                                .font(.custom("FrizQua-ReguOS", size: 20))
                            Spacer()
                            Text(signUpPasswordMessage != "" ? "\(signUpPasswordMessage)" : "")
                                .MessageStyle()
                            Button{
                                showPassword.toggle()
                            } label: {
                                Image(systemName:showPassword ? "eye.fill" : "eye.slash.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)
                        if showPassword {
                            TextField("5-20 characters", text: $passwordSignUpInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                        } else {
                            SecureField("5-20 characters", text: $passwordSignUpInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                        }
                    }
                    HStack {
                        Spacer()
                        Button {
                            userNameSignUpInput = ""
                            emailSignUpInput = ""
                            passwordSignUpInput = ""
                            logInPasswordMessage = ""
                            showPassword = false
                            viewMode = 2
                        } label: {
                            ButtonView(color: "ButtonColorInv", image: "key")
                        }
                        Button {
                            signUpUserNameMessage = ""
                            signUpEmailMessage = ""
                            signUpPasswordMessage = ""
                            isLoading = true
                            FavQsSignUp(userName: userNameSignUpInput, email: emailSignUpInput, password: passwordSignUpInput)
                        } label: {
                            ButtonView(color: "ButtonColor", image: "arrow.right")
                        }
                    }
                    .padding([.top, .leading, .trailing])
                }
                .frame(width: UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width+50)
                .background(Color("BWFlipped"))
                .cornerRadius(15)
                .padding([.leading, .bottom, .trailing], 50)
                LoginTitle(text: "Sign Up")
                if isLoading {
                    ProgressView()
                        .scaleEffect(x: 4, y: 4)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .background(Color.secondary)
                        .ignoresSafeArea()
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                if !saver.UserData.isEmpty {
                    viewMode = 1
                }
            }
        } else if viewMode == 2 { // Login View
            ZStack {
                Image("wallpaper1")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                VStack(alignment: .leading) {
                    Text("Account")
                        .font(.custom("FrizQua-ReguOS", size: 20))
                        .padding(.leading)
                    TextField("Email or Account", text: $userAccountLoginInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    HStack{
                        Text("Password")
                            .font(.custom("FrizQua-ReguOS", size: 20))
                        Spacer()
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName:showPassword ? "eye.fill" : "eye.slash.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    if showPassword {
                        TextField("Password", text: $passwordLoginInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                    } else {
                        SecureField("Password", text: $passwordLoginInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                    }
                    HStack {
                        Text(logInPasswordMessage != "" ? "\(logInPasswordMessage)" : "")
                            .MessageStyle()
                        Spacer()
                        Button {
                            userAccountLoginInput = ""
                            passwordLoginInput = ""
                            signUpUserNameMessage = ""
                            signUpEmailMessage = ""
                            signUpPasswordMessage = ""
                            viewMode = 0
                            showPassword = false
                        } label: {
                            ButtonView(color: "ButtonColorInv", image: "person.badge.plus")
                        }
                        Button {
                            logInPasswordMessage = ""
                            isLoading = true
                            FavQsLogIn(userNameOrEmail: userAccountLoginInput, password: passwordLoginInput)
                        } label: {
                            ButtonView(color: "ButtonColor", image: "arrow.right")
                        }
                    }
                    .padding([.top, .leading, .trailing])
                }
                .frame(width: UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width+50)
                .background(Color("BWFlipped"))
                .cornerRadius(15)
                .padding([.leading, .bottom, .trailing], 50)
                LoginTitle(text: "Log In")
                if isLoading {
                    ProgressView()
                        .scaleEffect(x: 4, y: 4)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .background(Color.secondary)
                        .ignoresSafeArea()
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UserTokenForLogin: Codable {
    let userToken: String
    let userName: String
    
    enum CodingKeys: String, CodingKey { //http://aiur3908.blogspot.com/2020/06/ios-swiftjson.html
        case userToken = "User-Token"
        case userName = "login"
    }
}

struct ButtonView: View {
    let color: String
    let image: String
    var body: some View {
        ZStack {
            Color(color)
            Image(systemName: image)
        }
        .foregroundColor(.white)
        .frame(width: 50, height: 50)
        .cornerRadius(15)
    }
}

struct LoginTitle: View {
    let text: String
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .font(.custom("FrizQuadrataBold", size: 40))
                .foregroundColor(Color("LeagueGold"))
            Spacer()
        }
        .offset(y: -200)
    }
}
