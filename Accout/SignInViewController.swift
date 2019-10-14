//
//  SignInViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/28.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import Authorize
import SnapKit
import Alamofire

class SignInViewController: UIViewController {
    
    let oauth = OAuth1Swift(consumerKey: "ceab0dcd7b9fb9fa2ef5785bcd320e70",
                            consumerSecret: "bc9d15a8458d863cc6524feb6d495f4b",
                            requestTokenUrl: "https://fanfou.com/oauth/request_token",
                            authorizeUrl: "https://fanfou.com/oauth/authorize",
                            accessTokenUrl: "https://fanfou.com/oauth/access_token")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let it = UIButton(type: .roundedRect)
        it.titleLabel?.text = "GO"
        it.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        it.titleLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        it.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        view.addSubview(it)
        it.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(32)
        }
        it.addTarget(self, action: #selector(self.go), for: UIControl.Event.touchUpInside)
    }
    
    private var handler: OAuthSwiftRequestHandle? = nil
    
    @objc dynamic func go(){
        print("GO")
//        handler = oauth.authorize(
//            withCallbackURL: URL(string: "http://fanfou.com/")!,
//            success: { credential, response, parameters in
//                print(credential.oauthToken)
//                print(credential.oauthTokenSecret)
//                // Do your request
//        },
//            failure: { error in
//                print(error.localizedDescription)
//        })
        let it = XAuth()
        let params = generateFanfouXAuthParams(username: "80998062@qq.com", password: "rabbit7run")
        Alamofire.request(it.getAccessToken(baseUrl: "https://fanfou.com/oauth/access_token", parameters: params)).response{ response in
            print("Response: \(String(describing: response.response))") // http url response
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        handler?.cancel()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


func generateFanfouXAuthParams(username aUsername:String,password aPassword:String,override aParams:[XAuth.Parameters:String]? = nil) -> [XAuth.Parameters:String]{
    var params:[XAuth.Parameters:String] = [:]
    params[.ConsumerKey] = "ceab0dcd7b9fb9fa2ef5785bcd320e70"
    params[.Mode] = "client_auth"
    params[.SignatureMethod] = "HMAC-SHA1"
    params[.Version] = "1.0"
    params[.Timestamp] = Clock().mills()
    params[.Username] = aUsername
    params[.Password] = aPassword
    let nonce = Nonce(length: 32)
    params[.Nonce] = nonce.hexString
    if nil != aParams{
        for k in aParams!.keys{
            params[k] = aParams![k]
        }
    }
    return params
}
