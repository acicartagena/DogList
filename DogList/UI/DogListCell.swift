//  Copyright © 2020 ACartagena. All rights reserved.

import UIKit
import SnapKit

extension Dog.LifeSpanYear {
    var display: String {
        switch self {
        case let .range(min, max):
            return String.localizedStringWithFormat(NSLocalizedString("%i - %i years", comment: "Life span years with range"), min, max)
        case let .constant(value):
            return String.localizedStringWithFormat(NSLocalizedString("%i years", comment: "Life span constant value"), value)
        }
    }
}

class DogListCell: UITableViewCell {

    private static let imageSize = CGSize(width: 100, height: 100)

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()

    private let temperamentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()

    private let lifeSpanLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()

    private let dogImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        contentView.addSubview(dogImageView)
        dogImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(CGFloat.margin)
            make.size.equalTo(DogListCell.imageSize)
            make.bottom.equalToSuperview().inset(CGFloat.margin).priority(.medium)
        }

        let labelsStack = UIStackView(arrangedSubviews: [nameLabel, temperamentLabel, lifeSpanLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = CGFloat.between

        contentView.addSubview(labelsStack)
        labelsStack.snp.makeConstraints { make in
            make.top.equalTo(dogImageView.snp.top)
            make.leading.equalTo(dogImageView.snp.trailing).offset(CGFloat.between)
            make.trailing.equalToSuperview().inset(CGFloat.margin)
            make.bottom.greaterThanOrEqualToSuperview().inset(CGFloat.margin).priority(.high)
        }
    }

    func configure(with dog: Dog) {
        nameLabel.text = dog.name
        temperamentLabel.text = dog.temperament
        lifeSpanLabel.text = dog.lifeSpan.display
        dogImageView.setImage(dog.imageURL)
    }
}
