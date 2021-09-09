//
//  PXTermsAndConditionsTextView.swift
//  MercadoPagoSDKV4
//
//  Created by Victor Pereira De Paula on 09/09/21.
//

import MLCardDrawer

final class PXTermsAndConditionsTextView: UITextView {
    init(terms: PXTermsDto, selectedInstallments: Int?, cardType: MLCardDrawerTypeV3? = .large, textColor: UIColor, linkColor: UIColor) {
        super.init(frame: .zero, textContainer: nil)
        
        linkTextAttributes = [.foregroundColor: linkColor]
        isUserInteractionEnabled = true
        isEditable = false
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false

        let attributedString = getTermsAndConditionsText(terms: terms, selectedCreditsInstallments: selectedInstallments)
        
        attributedText = attributedString
        textAlignment = .center
        self.textColor = textColor
        
        if cardType == .small {
            font = self.font?.withSize(10)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getTermsAndConditionsText(terms: PXTermsDto, selectedCreditsInstallments: Int?) -> NSMutableAttributedString {
        let tycText = terms.text
        let attributedString = NSMutableAttributedString(string: tycText)

        var phrases: [PXLinkablePhraseDto] = [PXLinkablePhraseDto]()
        if let remotePhrases = terms.linkablePhrases {
            phrases = remotePhrases
        }

        for linkablePhrase in phrases {
            var customLink = linkablePhrase.link
            if customLink == nil, let customHtml = linkablePhrase.html {
                customLink = HtmlStorage.shared.set(customHtml)
            } else if let links = terms.links {
                guard let installmentsSelected = selectedCreditsInstallments else { return attributedString }
                let key = linkablePhrase.installments?[String(installmentsSelected)]
                if let htmlKey = key, let customHtml = links[htmlKey] {
                    customLink = HtmlStorage.shared.set(customHtml)
                }
            }
            if let customLink = customLink {
                let tycLinkRange = (tycText as NSString).range(of: linkablePhrase.phrase)
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: tycLinkRange)
                attributedString.addAttribute(NSAttributedString.Key.link, value: customLink, range: tycLinkRange)
            }
        }

        return attributedString
    }
}
