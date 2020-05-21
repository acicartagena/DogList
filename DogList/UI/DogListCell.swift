//
//  DogListCell.swift
//  DogList
//
//  Created by Angela Cartagena on 21/5/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import UIKit

class DogListCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
