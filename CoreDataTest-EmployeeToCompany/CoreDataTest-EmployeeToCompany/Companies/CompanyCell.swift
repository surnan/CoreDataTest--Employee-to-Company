//
//  CompanyCell.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class CompanyCell: UITableViewCell {
    let companyImageViewConstant: CGFloat = 40
    var company: Company?{
        didSet {
            if let name = company?.name, let founded = company?.founded {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let foundedDateString = dateFormatter.string(from: founded)
                nameFoundedDateLabel.text = "\(name) - \(foundedDateString)"
            } else {
                nameFoundedDateLabel.text = "\(company?.name ?? "")"
            }
            
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    lazy var companyImageView: UIImageView = {
       let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = companyImageViewConstant / 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameFoundedDateLabel: UILabel = {
       let label = UILabel()
        label.text = "Company Name"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [companyImageView, nameFoundedDateLabel].forEach{addSubview($0)}

        NSLayoutConstraint.activate([
            companyImageView.heightAnchor.constraint(equalToConstant: companyImageViewConstant),
            companyImageView.widthAnchor.constraint(equalToConstant: companyImageViewConstant),
            companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameFoundedDateLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 15),
            nameFoundedDateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
