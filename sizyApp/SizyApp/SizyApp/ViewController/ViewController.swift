//
//  ViewController.swift
//  SizyApp
//
//  Created by 임명준 on 2020/04/30.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit
import Then
import NaverThirdPartyLogin
import Alamofire
import KakaoOpenSDK

class ViewController: UIViewController {
   
    private var tutorialCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.bounces = false
        debugPrint("collectionView init")

        return collectionView
    }()
    private lazy var loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    private var kakaoLoginBtn: KOLoginButton! = KOLoginButton().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
    })
    private var naverLoginBtn:UIButton! = UIButton().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "naverDemoLogin"), for: .normal)
    })
    private var emailLoginBtn:UIButton! = UIButton().then({
        $0.setTitle(AppStrings.emailLogin.rawValue, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
    })
    private var contractLb:UILabel! = UILabel().then({
        $0.text = AppStrings.constractLb.rawValue
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .darkGray
        title = AppStrings.Welcome.rawValue
        
        view.addSubview(tutorialCollectionView)
        view.addSubview(naverLoginBtn)
        view.addSubview(kakaoLoginBtn)
        view.addSubview(emailLoginBtn)
        view.addSubview(contractLb)
        
        tutorialCollectionView.delegate = self
        tutorialCollectionView.dataSource = self
        
        setupCollectionView()
        setupNaverBtn()
        setupKakaoBtn()
        setupEmailBtn()
        setupConstractLb()
    }
   
}
//setup view Constraint
extension ViewController{
    func setupCollectionView(){
           tutorialCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
           tutorialCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
           tutorialCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tutorialCollectionView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
           tutorialCollectionView.heightAnchor.constraint(equalTo: tutorialCollectionView.widthAnchor, multiplier: 0.7).isActive = true
       }
    func setupNaverBtn(){
      //  naverLoginBtn.topAnchor.constraint(equalTo: tutorialCollectionView.bottomAnchor, constant: 100).isActive = true
        naverLoginBtn.topAnchor.constraint(equalToSystemSpacingBelow: tutorialCollectionView.bottomAnchor, multiplier: 5).isActive = true
        naverLoginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        naverLoginBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        naverLoginBtn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        naverLoginBtn.addTarget(self, action: #selector(goNaverLogin), for: .touchUpInside)
    }
    func setupKakaoBtn(){
        kakaoLoginBtn.topAnchor.constraint(equalTo: naverLoginBtn.bottomAnchor, constant: 10).isActive = true
        kakaoLoginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        kakaoLoginBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        kakaoLoginBtn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        kakaoLoginBtn.addTarget(self, action: #selector(goKakaoLogin(sender:)), for: .touchUpInside)
    }
    func setupEmailBtn(){
              emailLoginBtn.topAnchor.constraint(equalTo: kakaoLoginBtn.bottomAnchor, constant: 10).isActive = true
              emailLoginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
              emailLoginBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
              emailLoginBtn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        emailLoginBtn.addTarget(self, action: #selector(goLoginWithEmail(sender:)), for: .touchUpInside)
       }
    func setupConstractLb(){
        contractLb.bottomAnchor.constraint(equalTo: emailLoginBtn.bottomAnchor, constant: 40).isActive = true
        contractLb.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        contractLb.heightAnchor.constraint(equalToConstant: 30).isActive = true
        contractLb.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //UITapGestureRecognizer
        contractLb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goConstract)))
        contractLb.isUserInteractionEnabled = true
    }
}

//button action
extension ViewController{
    @objc func goLoginWithEmail(sender:UIButton){
        navigationController?.pushViewController(MainVC(name: ""), animated: true )
        //navigationController?.pushViewController(LoginWithEmailVC(), animated: true)
    }
    @objc func goConstract(sender:UITapGestureRecognizer){
        navigationController?.pushViewController(ConstractVC(), animated: true)
    }
    @objc func goNaverLogin(sender:UIButton){
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    @objc func goKakaoLogin(sender:KOLoginButton){
        //이전 카카오톡 세션 열려있으면 닫기
        guard let session = KOSession.shared() else {
            return
        }
        if session.isOpen() {
            session.close()
        }
        
        session.open(completionHandler: { (error) -> Void in
            if error == nil {
                if session.isOpen() {
                    //accessToken
                    print("login success ")
                   KOSessionTask.userMeTask { (error, user) in
                        guard let name = user?.account?.profile?.nickname else{return}
                        self.navigationController?.pushViewController(MainVC(name: name), animated: true)
                    }
                } else {
                    print("Login failed")
                }
            } else {
                print("Login error : \(String(describing: error))")
            }
            if !session.isOpen() {
                if let error = error as NSError? {
                    switch error.code {
                    case Int(KOErrorCancelled.rawValue):
                        break
                    default:
                        //간편 로그인 취소
                        print("error : \(error.description)")
                    }
                }
            }
        })
    }
}
/*
    카카오 로그인
 */
extension ViewController{
    
    
}
extension ViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        switch indexPath.row {
        case 0:
            cell.tutorialIv.image = #imageLiteral(resourceName: "1")
        case 1:
            cell.tutorialIv.image = #imageLiteral(resourceName: "1")
        case 2:
            cell.tutorialIv.image = #imageLiteral(resourceName: "1")
        case 3:
            cell.tutorialIv.image = #imageLiteral(resourceName: "3")
        case 4:
            cell.tutorialIv.image = #imageLiteral(resourceName: "5")
        default:
            debugPrint("default")
        }
        return cell
    }
}

class CustomCell:UICollectionViewCell{
    fileprivate let tutorialIv: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(tutorialIv)
        tutorialIv.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 40).isActive = true
        tutorialIv.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 40).isActive = true
        tutorialIv.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -40).isActive = true
        tutorialIv.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -40).isActive = true

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/*
   protocol: NaverThirdPartyLoginConnectionDelegate
   description: 로그인 성공, 접근 토큰 갱신, 로그아웃, 모든 에러 관리
*/
//네이버 로그인
extension ViewController: NaverThirdPartyLoginConnectionDelegate{
    
    //로그인 성공헀을 경우
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        debugPrint("naver login success")
        getNaverInfo()
    }
    //접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        debugPrint("oauth20ConnectionDidFinishRequestACTokenWithRefreshToken")
    }
    //로그아웃일 경우 (토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
        loginInstance?.requestDeleteToken()
    }
    //모든 에러
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        debugPrint("naver login error  \(error.debugDescription)")
    }
}
/*
   method: getNaverInfo
    description: 로그인 성공시 사용자 정보 가져오는 로직
 */
extension ViewController{
    private func getNaverInfo() {
      guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
      
      if !isValidAccessToken {
        return
      }
      
      guard let tokenType = loginInstance?.tokenType else { return }
      guard let accessToken = loginInstance?.accessToken else { return }
      let urlStr = "https://openapi.naver.com/v1/nid/me"
      let url = URL(string: urlStr)!
      
      let authorization = "\(tokenType) \(accessToken)"
      
      let req = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
      
      req.responseJSON { response in
        guard let result = response.result.value as? [String: Any] else { return }
        guard let object = result["response"] as? [String: Any] else { return }
        guard let name = object["name"] as? String else { return }
        guard let email = object["email"] as? String else { return }
        guard let nickname = object["nickname"] as? String else { return }
        
        self.navigationController?.pushViewController(MainVC(name: name), animated: true)

        debugPrint("lopgin success response  \(response.debugDescription)")
      }
    }
    func presentWebviewcontrollerWithRequest(request: URLRequest) {
        
        UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)
    }
}


