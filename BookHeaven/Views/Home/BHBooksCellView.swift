//
//  BHBooksCellView.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 9.01.2023.
//


import UIKit

final class BHBooksCellView: UICollectionViewCell {
    static let cellIdentifier = "BHBooksCellView"


    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2

        return label
    }()


    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        

        return label
    }()


    private let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false


        return label
    }()

    private let columnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        
        columnStackView.addArrangedSubview(nameLabel)
        columnStackView.addArrangedSubview(authorLabel)
        columnStackView.addArrangedSubview(spacing(value: 12))
        columnStackView.addArrangedSubview(languageLabel)
        columnStackView.addArrangedSubview(subjectLabel)

        contentView.addSubViews(imageView, columnStackView)
        
        addConstraints()
        setUpLayer()
    }
  
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: columnStackView.leftAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            columnStackView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            columnStackView.leftAnchor.constraint(equalTo: imageView.rightAnchor),
            columnStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.imageView.image = nil
        self.languageLabel.text = nil
        self.subjectLabel.text = nil
        self.authorLabel.text = nil
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }

    private func setUpLayer() {

        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3


    }
    func spacing(value: CGFloat) -> UIView {
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.heightAnchor.constraint(equalToConstant: value).isActive = true
        return spacerView
    }
    
    func configure(with book: BHBook) {
        self.nameLabel.text = book.title
        self.authorLabel.text = book.authors?.first?.name
        self.subjectLabel.text = book.subjects?.first ?? ""
        self.languageLabel.text = book.getLanguageReadableName()
        BHImageManager.shared.downloadImage(with: book.formats.imageJPEG) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: success)
                }
            case .failure(let failure):
                print(String(describing: failure))
            }

        }
    }

}
