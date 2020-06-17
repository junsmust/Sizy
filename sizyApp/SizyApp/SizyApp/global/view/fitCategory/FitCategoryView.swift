//
//  FitCategoryView.swift
//  SizyApp
//
//  Created by 임명준 on 2020/06/17.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit
import Then

class FitCategoryView: UIView {

    private var descriptionLb: UILabel! = UILabel().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.text = "옷의 특징을 \n 선택해주세요"
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 20)
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
    private lazy var fitCollectionView: UICollectionView! = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
       
        return collectionView
    }()
    let datasource = FitCategoryDatasource()

    
    init() {
        super.init(frame: .zero)
        addSubview(descriptionLb)
        setupDescriptionLb()
        addSubview(nextBtnView)
        addSubview(nextBtn)
        setupNextBtnView()
        setupNextBtn()
        addSubview(fitCollectionView)
        setupFitCollectionView()
        
        fitCollectionView.dataSource = datasource//self//datasource
        fitCollectionView.delegate = self
        fitCollectionView.register(UINib(nibName: AppCells.SubCategoryCell.rawValue, bundle: nil), forCellWithReuseIdentifier: AppCells.SubCategoryCell.rawValue)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupDescriptionLb(){
        NSLayoutConstraint.activate([
            descriptionLb.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 20),
            descriptionLb.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            descriptionLb.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    private func setupNextBtnView(){
          NSLayoutConstraint.activate([
              nextBtnView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
              nextBtnView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
              nextBtnView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              nextBtnView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              nextBtnView.heightAnchor.constraint(equalToConstant: 80)
          ])
      }
      private func setupNextBtn(){
          NSLayoutConstraint.activate([
              nextBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
              nextBtn.bottomAnchor.constraint(equalTo: nextBtnView.bottomAnchor),
              nextBtn.leadingAnchor.constraint(equalTo: nextBtnView.leadingAnchor),
              nextBtn.trailingAnchor.constraint(equalTo: nextBtnView.trailingAnchor),
              nextBtn.heightAnchor.constraint(equalToConstant: 70)
          ])
      }
    private func setupFitCollectionView(){
        NSLayoutConstraint.activate([
            fitCollectionView.topAnchor.constraint(equalTo: descriptionLb.bottomAnchor),
            fitCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            fitCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            fitCollectionView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
}
extension FitCategoryView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        debugPrint("FitCategoryView  \(FitData.shared.fits[indexPath.row].getString())")
    }
}
extension FitCategoryView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
    }
}
