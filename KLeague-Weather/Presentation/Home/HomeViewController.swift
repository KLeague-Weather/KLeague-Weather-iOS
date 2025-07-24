//
//  HomeViewController.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import UIKit
import SnapKit
import SwiftUI

class HomeViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "HomeView"
        label.font = UIFont(name: "GmarketSansMedium", size: 20)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Preview
#if DEBUG
struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
#endif
