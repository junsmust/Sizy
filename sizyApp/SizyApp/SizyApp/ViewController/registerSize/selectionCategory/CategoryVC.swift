//
//  CategoryVC.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/29.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit
import Then

class CategoryVC: UIViewController {
    
    private lazy var categoryCollectionView: UICollectionView! = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: AppCells.CategoryCell.rawValue, bundle: nil), forCellWithReuseIdentifier: AppCells.CategoryCell.rawValue)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var subCollectionView: UICollectionView! = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: AppCells.SubCategoryCell.rawValue, bundle: nil), forCellWithReuseIdentifier: AppCells.SubCategoryCell.rawValue)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var mainDescriptionLb: UILabel! = UILabel().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = AppStrings.MainCategoryLb.rawValue
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 30)
    })
    private lazy var subDescriptionLb: UILabel! = UILabel().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = AppStrings.SubCategoryLb.rawValue
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 30)
    })
    private lazy var nextBtn: UIButton! = UIButton().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(AppStrings.nextBtn.rawValue, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.red, for: .highlighted)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 7.0
    })
    private lazy var nextBtnView: UIView! = UIView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }
    private var mainCategory: String = ""
    private var subCategory: String = ""
    
    private var mainMenus = MainCategory.menus
    private var subMenus = MainCategory.getSubCategory(subCategory: .top)
    private var defaultMainMenu: MainCategory = .top
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        title = AppStrings.categortTitle.rawValue
        
        view.addSubview(mainDescriptionLb)
        view.addSubview(categoryCollectionView)
        view.addSubview(subDescriptionLb)
        view.addSubview(subCollectionView)
        view.addSubview(nextBtnView)
        nextBtnView.addSubview(nextBtn)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        subCollectionView.delegate = self
        subCollectionView.dataSource = self
        
        setupMainDescriptionLb()
        setupCategoryVC()
        setupSubDescriptionLb()
        setupNextBtnView()
        setupNextBtn()
        setupSubCollectionView()
    }
}
extension CategoryVC{
    private func setupMainDescriptionLb(){
        
        NSLayoutConstraint.activate([
            mainDescriptionLb.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 30),
            mainDescriptionLb.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            mainDescriptionLb.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainDescriptionLb.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func setupCategoryVC(){
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: mainDescriptionLb.bottomAnchor,constant: 10),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    private func setupSubDescriptionLb(){
        NSLayoutConstraint.activate([
            subDescriptionLb.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor,constant: 30),
            subDescriptionLb.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            subDescriptionLb.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subDescriptionLb.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func setupSubCollectionView(){
        NSLayoutConstraint.activate([
            subCollectionView.topAnchor.constraint(equalTo: subDescriptionLb.bottomAnchor,constant: 10),
            subCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            subCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            subCollectionView.bottomAnchor.constraint(equalTo: nextBtnView.topAnchor, constant: -20)
        ])
    }
    private func setupNextBtnView(){
        NSLayoutConstraint.activate([
            nextBtnView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextBtnView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            nextBtnView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nextBtnView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nextBtnView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    private func setupNextBtn(){
        NSLayoutConstraint.activate([
            nextBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextBtn.bottomAnchor.constraint(equalTo: nextBtnView.bottomAnchor),
            nextBtn.leadingAnchor.constraint(equalTo: nextBtnView.leadingAnchor),
            nextBtn.trailingAnchor.constraint(equalTo: nextBtnView.trailingAnchor),
            nextBtn.heightAnchor.constraint(equalToConstant: 70)
        ])
        nextBtn.addTarget(self, action: #selector(goToSizeInput), for: .touchUpInside)
    }
    @objc func goToSizeInput(_ sender: UIButton){
        navigationController?.pushViewController(InputSizeVC(mainCategory: "test", subCategory: "test"), animated: true)
    }
}
extension CategoryVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint(" numberOfItemsInSection ")
        if collectionView == categoryCollectionView{
            return mainMenus.count
        }
        else{
            return subMenus.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        debugPrint(" cellForItemAt ")
        if collectionView == categoryCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCells.CategoryCell.rawValue, for: indexPath) as? CategoryCell else{return CategoryCell()}
            
            if indexPath.row == 0{
                cell.isHighlighted = true
            }
            cell.categoryiV.image = MainCategory.getIcon(category: MainCategory.menus[indexPath.row])
            cell.categoryTitleLb.text = MainCategory.menus[indexPath.row].rawValue
            
            return cell
            
        }
        else if collectionView == subCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCells.SubCategoryCell.rawValue, for: indexPath) as? SubCategoryCell else{return SubCategoryCell()}
            
            switch defaultMainMenu {
            case .onePiece:
                debugPrint("onepiece   \(defaultMainMenu)")
                cell.subLabel.text = MainCategory.OnePiceSubCategory.subCategories[indexPath.row].rawValue
            case .pants:
                debugPrint("pant   \(defaultMainMenu)")
                cell.subLabel.text = MainCategory.PantSubCategory.subCategories[indexPath.row].rawValue
            case .shoe:
                debugPrint("shose   \(defaultMainMenu)")
                cell.subLabel.text = MainCategory.ShoeSubCategory.subCategories[indexPath.row].rawValue
            case .skirt:
                debugPrint("skirt   \(defaultMainMenu)")
                cell.subLabel.text = MainCategory.SkirtSubCategory.subCategories[indexPath.row].rawValue
            case .top:
                debugPrint("top   \(defaultMainMenu)")
                cell.subLabel.text = MainCategory.TopSubCategory.subCategories[indexPath.row].rawValue
            default:
                debugPrint("sub category ")
            }
            
            return cell
        }
        
        return CategoryCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === categoryCollectionView{
            
            defaultMainMenu = mainMenus[indexPath.row]
            if defaultMainMenu != .top{
                collectionView.cellForItem(at: IndexPath(row: 0, section: 0))?.isSelected = false
                debugPrint("test  ")
            }
            switch defaultMainMenu {
            case .onePiece:
                subMenus = MainCategory.OnePiceSubCategory.subCategories
            case .pants:
                subMenus =  MainCategory.PantSubCategory.subCategories
            case .shoe:
                subMenus = MainCategory.ShoeSubCategory.subCategories
            case .skirt:
                subMenus = MainCategory.SkirtSubCategory.subCategories
            case .top:
                subMenus = MainCategory.TopSubCategory.subCategories
            default:
                debugPrint("sub category ")
            }
            mainCategory = defaultMainMenu.rawValue
            subCollectionView.reloadData()
        }
        else{
            subCategory = subMenus[indexPath.row] as! String
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView === categoryCollectionView{
               // let cell = collectionView.cellForItem(at: indexPath)
                //cell?.isSelected = false
        }
    }
}
extension CategoryVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === categoryCollectionView{
             return CGSize(width: 70, height: 90)
        }else{
             return CGSize(width: 100, height: 70)
        }
       
    }
}
