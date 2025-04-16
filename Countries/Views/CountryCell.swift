import UIKit

final class CountryCell: UITableViewCell {

    private let nameRegionLabel = UILabel()
    private let codeLabel = UILabel()
    private let capitalLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 1) Subviews
        nameRegionLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameRegionLabel)
        contentView.addSubview(codeLabel)
        contentView.addSubview(capitalLabel)

        // 2) Label configurations
        nameRegionLabel.numberOfLines = 0  // allow wrapping for longer name+region
        codeLabel.numberOfLines = 1
        capitalLabel.numberOfLines = 0     // or 1 if you prefer

        // For dynamic type
        nameRegionLabel.adjustsFontForContentSizeCategory = true
        codeLabel.adjustsFontForContentSizeCategory = true
        capitalLabel.adjustsFontForContentSizeCategory = true

        // Example fonts
        nameRegionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        codeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        codeLabel.textAlignment = .right
        capitalLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        capitalLabel.textColor = .secondaryLabel

        // 3) Constraints

        // First, set codeLabel's compression resistance priority *outside* the array
        codeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        NSLayoutConstraint.activate([
            // A) nameRegionLabel pinned top-left
            nameRegionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameRegionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            // Let nameRegion extend up to codeLabel (lessThanOrEqual)
            nameRegionLabel.trailingAnchor.constraint(lessThanOrEqualTo: codeLabel.leadingAnchor, constant: -8),

            // B) codeLabel pinned top-right
            codeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            codeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // C) capitalLabel pinned below nameRegionLabel (for however many lines nameRegionLabel used)
            capitalLabel.topAnchor.constraint(equalTo: nameRegionLabel.bottomAnchor, constant: 8),
            capitalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            capitalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            capitalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Called from cellForRowAt
    func configure(name: String, region: String, code: String, capital: String) {
        nameRegionLabel.text = "\(name), \(region)"
        codeLabel.text = code
        capitalLabel.text = capital
    }
}
