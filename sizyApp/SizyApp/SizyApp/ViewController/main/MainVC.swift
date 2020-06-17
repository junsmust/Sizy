//
//  MainVC.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/22.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit
import Then

class MainVC: UIViewController {
    
    private let testArray: [String] = ["넉넉한 베이지 코트","딱 맞는 검정 자켓","살짝 큰 가디건","넉넉한 베이지 코트","딱 맞는 검정 자켓","살짝 큰 가디건","넉넉한 베이지 코트","딱 맞는 검정 자켓"]
    
    private lazy var searchView: UIView! = UIView().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
    })
    private lazy var appIconIv: UIImageView! = UIImageView().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "appIconDemo")
    })
    private lazy var searchTextFd: UITextField! = UITextField().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "search something"
    })
    private lazy var searchBtn: UIButton! = UIButton().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("검색", for: .normal)
        $0.backgroundColor = .black
       })
    private var mainCategoryCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bounces = false
        debugPrint("collectionView init")

        return collectionView
    }()
    private lazy var bottomStackView: UIStackView! = UIStackView().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 0
    })
    private lazy var sizeBtn: UIButton! = UIButton().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .lightGray
        $0.setTitle(AppStrings.sizeBtn.rawValue, for: .normal)
        $0.setTitleColor(.black, for: .normal)
    })
    private lazy var settingBtn: UIButton! = UIButton().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .brown
        $0.setTitle(AppStrings.settingBtn.rawValue, for: .normal)
        $0.setTitleColor(.black, for: .normal)
    })
    private lazy var addBtn: UIButton! = UIButton().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .darkGray
        $0.setTitle("+", for: .normal)
    })
    private lazy var sizeTableView: UITableView! = UITableView().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.bounces = false
        $0.tableFooterView = UIView(frame: .zero)
    })
    private lazy var bottomButtonsView: UIView! = UIView().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
    })
    
    private var name: String!
    
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        self.name = name
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(searchView)
        setupSearchView()
        searchView.addSubview(appIconIv)
        setupIconIv()
        searchView.addSubview(searchTextFd)
        setupSearchTextFd()
        searchView.addSubview(searchBtn)
        setupSearchBtn()
        view.addSubview(mainCategoryCollectionView)
        setupMainCategoryTableView()
        view.addSubview(bottomButtonsView)
        setupBottomButtonsView()
        view.addSubview(bottomStackView)
        setupBottomStackView()
        view.addSubview(sizeTableView)
        setupSizeTableView()
        view.addSubview(addBtn)
        setupAddBtn()
        
        addBtn.addTarget(self, action: #selector(goAddView(sender:)), for: .touchUpInside)
        
        mainCategoryCollectionView.delegate = self
        mainCategoryCollectionView.dataSource = self
        mainCategoryCollectionView.register(UINib(nibName: "MainCategoryCell", bundle: nil), forCellWithReuseIdentifier: "MainCategoryCell")
        
        sizeTableView.delegate = self
        sizeTableView.dataSource = self
        sizeTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
    }
    
    private func setupSearchView(){
        
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 5),
            searchView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -5),
            searchView.widthAnchor.constraint(equalToConstant: view.frame.width),
            searchView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    private func setupIconIv(){
        NSLayoutConstraint.activate([
            appIconIv.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            appIconIv.widthAnchor.constraint(equalToConstant: view.frame.width * 0.2),
            appIconIv.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            appIconIv.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func setupSearchTextFd(){
        NSLayoutConstraint.activate([
            searchTextFd.leadingAnchor.constraint(equalTo: appIconIv.trailingAnchor,constant: 10),
            searchTextFd.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchTextFd.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5),
            searchTextFd.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func setupSearchBtn(){
        NSLayoutConstraint.activate([
            searchBtn.leadingAnchor.constraint(equalTo: searchTextFd.trailingAnchor,constant: 10),
            searchBtn.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchBtn.widthAnchor.constraint(equalToConstant: view.frame.width * 0.3),
            searchBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupSizeTableView(){
        
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            sizeTableView.topAnchor.constraint(equalTo: mainCategoryCollectionView.bottomAnchor),
            sizeTableView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            sizeTableView.bottomAnchor.constraint(equalTo: bottomButtonsView.topAnchor,constant: -20),
            sizeTableView.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
    }
    private func setupMainCategoryTableView(){
        
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            mainCategoryCollectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            mainCategoryCollectionView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            mainCategoryCollectionView.heightAnchor.constraint(equalToConstant: 100),
            mainCategoryCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
    }
    
    private func setupAddBtn(){
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            addBtn.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor,constant: 30),
            addBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            addBtn.widthAnchor.constraint(equalToConstant: 60),
            addBtn.heightAnchor.constraint(equalToConstant: 60)
        ])
        debugPrint("addBtn.frame.width \(addBtn.frame.width)")
        addBtn.layer.cornerRadius = 0.5 * 60
    }
    
    private func setupBottomStackView(){
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: bottomButtonsView.bottomAnchor),
            bottomStackView.centerXAnchor.constraint(equalTo: bottomButtonsView.centerXAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        bottomStackView.addArrangedSubview(sizeBtn)
        bottomStackView.addArrangedSubview(settingBtn)
    }
    private func setupBottomButtonsView(){
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            bottomButtonsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomButtonsView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            bottomButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomButtonsView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    @objc func goAddView(sender: UIButton){
        navigationController?.pushViewController(CategoryVC(), animated: false)
    }
}
extension MainVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        debugPrint("cellForRowAt")
        cell.sizeTitle.text = testArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
extension MainVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainCategory.menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCategoryCell", for: indexPath) as! MainCategoryCell
        
        cell.mainCategoryLb.text = MainCategory.menus[indexPath.row].rawValue
        cell.mainCategoryIv.image = MainCategory.getIcon(category: MainCategory.menus[indexPath.row])
        
        return cell
    }
}
extension MainVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
}
