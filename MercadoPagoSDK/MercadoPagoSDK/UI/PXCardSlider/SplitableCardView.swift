//
//  SplitableCardView.swift
//  MercadoPagoSDKV4
//
//  Created by Matheus Leandro Martins on 05/07/21.
//

import UIKit

final class SplitableCardView: UIView {
    typealias PXAddMethodData = (title: PXText?, subtitle: PXText?, icon: UIImage?, compactMode: Bool)
    //Icon sizes
    let COMPACT_ICON_SIZE: CGFloat = 48.0
    let DEFAULT_ICON_SIZE: CGFloat = 64.0

    let data: PXAddMethodData

    init(data: PXAddMethodData) {
        self.data = data
        super.init(frame: .zero)
        isAccessibilityElement = true
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func render() {
        self.removeAllSubviews()
        self.backgroundColor = .white

        let iconImageView = buildCircleImage(with: data.icon)
        addSubview(iconImageView)

        let labelsContainerView = UIStackView()
        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        labelsContainerView.axis = .vertical
        labelsContainerView.distribution = .fillEqually

        var titleLabel: UILabel?
        let titleView = UIView()
        if let title = data.title {
            titleLabel = UILabel()
            if let titleLabel = titleLabel {
                titleLabel.numberOfLines = 2
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                titleLabel.attributedText = title.getAttributedString(fontSize: PXLayout.XS_FONT)
                titleLabel.textAlignment = data.compactMode ? .left : .center
                titleView.addSubview(titleLabel)
                labelsContainerView.addArrangedSubview(titleView)
                NSLayoutConstraint.activate([
                    titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
                    titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor)
                ])
            }
        }

        if let subtitle = data.subtitle {
            let subtitleLabel = UILabel()
            subtitleLabel.numberOfLines = 2
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            subtitleLabel.attributedText = subtitle.getAttributedString(fontSize: PXLayout.XXS_FONT)
            subtitleLabel.textAlignment = data.compactMode ? .left : .center

            let subtitleView = UIView()
            subtitleView.addSubview(subtitleLabel)
            labelsContainerView.addArrangedSubview(subtitleView)
            NSLayoutConstraint.activate([
                subtitleLabel.leadingAnchor.constraint(equalTo: subtitleView.leadingAnchor),
                subtitleLabel.trailingAnchor.constraint(equalTo: subtitleView.trailingAnchor),
                subtitleLabel.topAnchor.constraint(equalTo: subtitleView.topAnchor)
            ])
            if let titleLabel = titleLabel {
                titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
            }
        } else {
            titleLabel?.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        }

        accessibilityLabel = data.title?.message
        addSubview(labelsContainerView)

        if data.compactMode {
            let chevronImage = ResourceManager.shared.getImage("oneTapArrow_color")
            let chevronImageView = UIImageView(image: chevronImage)
            chevronImageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(chevronImageView)

            NSLayoutConstraint.activate([
                chevronImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                chevronImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -PXLayout.M_MARGIN),
                chevronImageView.heightAnchor.constraint(equalToConstant: 13),
                chevronImageView.widthAnchor.constraint(equalToConstant: 8),
                iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: PXLayout.S_MARGIN),
                iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                labelsContainerView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: PXLayout.S_MARGIN),
                labelsContainerView.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -PXLayout.S_MARGIN),
                labelsContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                labelsContainerView.heightAnchor.constraint(equalToConstant: 80)
            ])
        } else {
            NSLayoutConstraint.activate([
                iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: PXLayout.XL_MARGIN),
                iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                labelsContainerView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: PXLayout.S_MARGIN),
                labelsContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: PXLayout.S_MARGIN),
                labelsContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -PXLayout.S_MARGIN),
                labelsContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                labelsContainerView.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }

    func buildCircleImage(with image: UIImage?) -> PXUIImageView {
        let iconSize = data.compactMode ? COMPACT_ICON_SIZE : DEFAULT_ICON_SIZE
        return PXUIImageView(image: image, size: iconSize)
    }
}

//extension SplitableCardView:
