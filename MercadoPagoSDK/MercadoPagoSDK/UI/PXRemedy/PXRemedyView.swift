//
//  PXRemedyView.swift
//  MercadoPagoSDK
//
//  Created by Eric Ertl on 21/04/2020.
//

import UIKit
import MLCardDrawer
import MLCardForm

protocol PXRemedyViewProtocol: class {
    func remedyViewButtonTouchUpInside(_ sender: PXAnimatedButton)
}

struct PXRemedyViewData {
    let oneTapDto: PXOneTapDto?
    let paymentData: PXPaymentData?
    let amountHelper: PXAmountHelper?
    let remedy: PXRemedy

    weak var animatedButtonDelegate: PXAnimatedButtonDelegate?
    weak var remedyViewProtocol: PXRemedyViewProtocol?
    let remedyButtonTapped: ((String?) -> Void)?
}

class PXRemedyView: UIView {
    private let data: PXRemedyViewData
    
    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.3621281683, green: 0.3621373773, blue: 0.3621324301, alpha: 1)
        label.numberOfLines = 0
        label.font = UIFont.ml_semiboldSystemFont(ofSize: HINT_FONT_SIZE) ?? Utils.getSemiBoldFont(size: HINT_FONT_SIZE)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var termsAndConditionsTextView: UITextView = {
        let textView = UITextView()
        textView.linkTextAttributes = [.foregroundColor: UIColor.pxBlueMp]
        textView.delegate = self
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.ml_systemFont(withWeight: 14, size: 12)
        return textView
    }()

    lazy var payButton: PXAnimatedButton = {
        let normalText = "Pagar".localized
        let button = PXAnimatedButton(normalText: normalText, loadingText: "Procesando tu pago".localized, retryText: "Reintentar".localized)
        button.animationDelegate = data.animatedButtonDelegate
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ThemeManager.shared.getAccentColor()
        button.setTitle(normalText, for: .normal)
        button.layer.cornerRadius = 4
        button.add(for: .touchUpInside, { [weak self] in
            if let remedyButtonTapped = self?.data.remedyButtonTapped {
                remedyButtonTapped(self?.textField.getValue())
            }
            self?.data.remedyViewProtocol?.remedyViewButtonTouchUpInside(button)
        })
        if shouldShowTextField() {
            button.setDisabled()
        }
        return button
    }()
    
    private lazy var textField: MLCardFormField = {
        let title = getRemedyHintMessage()
        let lenght = getRemedyMaxLength()
        let cardFormFieldSetting = PXCardFormFieldSetting(lenght: lenght, title: title)
        let textField = MLCardFormField(fieldProperty: PXCardSecurityCodeFormFieldProperty(fieldSetting: cardFormFieldSetting))
        textField.notifierProtocol = self
        textField.render()
        return textField
    }()
    
    private weak var termsAndCondDelegate: PXTermsAndConditionViewDelegate?

    init(data: PXRemedyViewData, termsAndCondDelegate: PXTermsAndConditionViewDelegate?) {
        self.data = data
        self.termsAndCondDelegate = termsAndCondDelegate
        super.init(frame: .zero)
        render()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let CONTENT_WIDTH_PERCENT: CGFloat = 84.0
    let TITLE_FONT_SIZE: CGFloat = PXLayout.XS_FONT
    let CARD_VIEW_WIDTH: CGFloat = 335
    let CARD_VIEW_HEIGHT: CGFloat = 109
    let TEXTFIELD_HEIGHT: CGFloat = 50.0
    let TEXTFIELD_FONT_SIZE: CGFloat = PXLayout.M_FONT
    let TOTAL_FONT_SIZE: CGFloat = PXLayout.XS_FONT
    let HINT_FONT_SIZE: CGFloat = PXLayout.XXS_FONT
    let BUTTON_HEIGHT: CGFloat = 50.0

    private func render() {
        removeAllSubviews()
        // Title Label
        let titleLabel = buildTitleLabel(text: getRemedyMessage())
        addSubview(titleLabel)
        let screenWidth = PXLayout.getScreenWidth(applyingMarginFactor: CONTENT_WIDTH_PERCENT)
        let height = UILabel.requiredHeight(forText: getRemedyMessage(), withFont: titleLabel.font, inWidth: screenWidth)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: PXLayout.M_MARGIN),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: CONTENT_WIDTH_PERCENT  / 100),
            titleLabel.heightAnchor.constraint(equalToConstant: height),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        // CardDrawer
        if let cardDrawerView = buildCardDrawerView() {
            addSubview(cardDrawerView)
            NSLayoutConstraint.activate([
                cardDrawerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: PXLayout.M_MARGIN),
                cardDrawerView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
                cardDrawerView.heightAnchor.constraint(equalToConstant: CARD_VIEW_HEIGHT),
                cardDrawerView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }

        // Total Amount
        if let totalAmountView = buildTotalAmountView() {
            let lastView = subviews.last ?? titleLabel
            addSubview(totalAmountView)
            NSLayoutConstraint.activate([
                totalAmountView.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: PXLayout.S_MARGIN),
                totalAmountView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
                totalAmountView.heightAnchor.constraint(equalToConstant: 40),
                totalAmountView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }

        if shouldShowTextField() {
            // TextField
            let lastView = subviews.last ?? titleLabel
            addSubview(textField)
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: PXLayout.M_MARGIN),
                textField.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
                textField.heightAnchor.constraint(equalToConstant: TEXTFIELD_HEIGHT),
                textField.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])

            //Hint Label
            if let hintText = getRemedyFieldTitle() {
                hintLabel.text = hintText
                addSubview(hintLabel)
                let height = UILabel.requiredHeight(forText: hintText, withFont: hintLabel.font, inWidth: screenWidth)
                NSLayoutConstraint.activate([
                    hintLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: PXLayout.XS_MARGIN),
                    hintLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
                    hintLabel.heightAnchor.constraint(equalToConstant: height),
                    hintLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
                ])
            }
        }

        if shouldShowButton(), let lastView = subviews.last ?? textField {
            addSubview(payButton)
            NSLayoutConstraint.activate([
                payButton.topAnchor.constraint(greaterThanOrEqualTo: lastView.bottomAnchor, constant: PXLayout.M_MARGIN),
                payButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: PXLayout.S_MARGIN),
                payButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -PXLayout.S_MARGIN),
                payButton.heightAnchor.constraint(equalToConstant: BUTTON_HEIGHT),
                payButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

        self.layoutIfNeeded()
    }

    private func buildTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.1725280285, green: 0.1725597382, blue: 0.1725237072, alpha: 1)
        label.numberOfLines = 0
        label.text = text
        label.font = UIFont.ml_semiboldSystemFont(ofSize: TITLE_FONT_SIZE) ?? Utils.getSemiBoldFont(size: TITLE_FONT_SIZE)
        label.lineBreakMode = .byWordWrapping
        label.lineBreakMode = .byTruncatingTail
        return label
    }

    private func buildCardDrawerView() -> UIView? {
        guard data.remedy.cvv != nil || data.remedy.suggestedPaymentMethod != nil,
            let oneTapDto = data.oneTapDto else {
                return nil
        }

        var cardData: CardData
        var cardUI: CardUI

        if let accountMoney = oneTapDto.accountMoney {
            cardData = PXCardDataFactory()

            if accountMoney.cardType == .defaultType {
              cardUI = AccountMoneyCard(isDisabled: false, cardLogoImageUrl: accountMoney.paymentMethodImageURL, color: accountMoney.color, gradientColors: accountMoney.gradientColors)
            } else {
              cardUI = HybridAMCard(isDisabled: false, cardLogoImageUrl: accountMoney.paymentMethodImageURL, paymentMethodImageUrl: nil, color: accountMoney.color, gradientColors: accountMoney.gradientColors)
            }

        } else if let oneTapCardUI = oneTapDto.oneTapCard?.cardUI,
            let cardName = oneTapCardUI.name,
            let cardNumber = oneTapCardUI.lastFourDigits,
            let cardExpiration = oneTapCardUI.expiration {
            cardData = PXCardDataFactory().create(cardName: cardName.uppercased(), cardNumber: cardNumber, cardCode: "", cardExpiration: cardExpiration, cardPattern: oneTapCardUI.cardPattern)

            let templateCard = TemplateCard()
            if let cardPattern = oneTapCardUI.cardPattern {
                templateCard.cardPattern = cardPattern
            }

            templateCard.securityCodeLocation = oneTapCardUI.securityCode?.cardLocation == "front" ? .front : .back

            if let cardBackgroundColor = oneTapCardUI.color {
                templateCard.cardBackgroundColor = cardBackgroundColor.hexToUIColor()
            }

            if let cardFontColor = oneTapCardUI.fontColor {
                templateCard.cardFontColor = cardFontColor.hexToUIColor()
            }

            if let cardLogoImageUrl = oneTapCardUI.paymentMethodImageUrl {
                templateCard.cardLogoImageUrl = cardLogoImageUrl
            }

            if let issuerImageUrl = oneTapCardUI.issuerImageUrl {
                templateCard.bankImageUrl = issuerImageUrl
            }
            cardUI = templateCard
        } else if let consumerCredits = oneTapDto.oneTapCreditsInfo {
            let creditsViewModel = PXCreditsViewModel(consumerCredits)
            cardData = PXCardDataFactory()
            cardUI = ConsumerCreditsCard(creditsViewModel, isDisabled: oneTapDto.status.isDisabled(), needsTermsAndConditions: false)
        } else {
            return nil
        }

        let controller = MLCardDrawerController(cardUI, cardData, false, .medium)
        let screenWidth = PXLayout.getScreenWidth(applyingMarginFactor: CONTENT_WIDTH_PERCENT)
        controller.view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: screenWidth, height: CARD_VIEW_HEIGHT))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.animated(false)
        controller.show()

        if let accountMoney = oneTapDto.accountMoney {
            let view = controller.getCardView()
            if accountMoney.cardType == .defaultType, let accountMoneyCard = cardUI as? AccountMoneyCard {
              accountMoneyCard.render(containerView: view, isDisabled: false, size: view.bounds.size)
            } else if let hybridAMCard = cardUI as? HybridAMCard {
              hybridAMCard.render(containerView: view, isDisabled: false, size: view.bounds.size)
            }
        } else if let consumerCreditsCard = cardUI as? ConsumerCreditsCard,
                  let consumerCredits = oneTapDto.oneTapCreditsInfo {
            let customConsumerCredits = PXOneTapCreditsDto(displayInfo: PXDisplayInfoDto(color: consumerCredits.displayInfo.color,
                                                                                         gradientColors: consumerCredits.displayInfo.gradientColors,
                                                                                         topText: PXTermsDto(text: "",
                                                                                            textColor: nil,
                                                                                            linkablePhrases: nil,
                                                                                            links: nil),
                                                                                         bottomText: consumerCredits.displayInfo.bottomText))
            let creditsViewModel = PXCreditsViewModel(customConsumerCredits)
            let view = controller.getCardView()
                consumerCreditsCard.render(containerView: view, creditsViewModel: creditsViewModel, isDisabled: false, size: view.bounds.size, selectedInstallments: data.paymentData?.payerCost?.installments)
            addCreditTermsIfNeeded(terms: creditsViewModel.displayInfo.bottomText)
        }

        return controller.view
    }
    
    private func addCreditTermsIfNeeded(terms: PXTermsDto?) {
        guard !subviews.contains(termsAndConditionsTextView), let terms = terms else { return }
        let termsAndConditionsTextHeight: CGFloat = 44
        termsAndConditionsTextView.attributedText = getTermsAndConditionsMutableAttributedString(terms: terms)
        termsAndConditionsTextView.textAlignment = .center
        addSubview(termsAndConditionsTextView)
        NSLayoutConstraint.activate([
            termsAndConditionsTextView.heightAnchor.constraint(equalToConstant: termsAndConditionsTextHeight),
            termsAndConditionsTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: PXLayout.M_MARGIN),
            termsAndConditionsTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -PXLayout.M_MARGIN),
            termsAndConditionsTextView.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -PXLayout.S_MARGIN)
        ])
    }

    private func getTermsAndConditionsMutableAttributedString(terms: PXTermsDto) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: terms.text)

        for linkablePhrase in terms.linkablePhrases ?? [] {
            let phraseRange = attributedString.mutableString.range(of: linkablePhrase.phrase)
            
            attributedString.addAttribute(.foregroundColor, value: UIColor.fromHex(linkablePhrase.textColor), range: phraseRange)
            
            var customLink = linkablePhrase.link
            if customLink == nil, let customHtml = linkablePhrase.html {
                customLink = HtmlStorage.shared.set(customHtml)
            } else if terms.links != nil {
                return attributedString
            }
            if let customLink = customLink {
                attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: phraseRange)
                attributedString.addAttribute(.link, value: customLink, range: phraseRange)
            }
        }

        return attributedString
    }
    
    private func buildTotalAmountView() -> UIView? {
        guard data.remedy.cvv == nil && data.remedy.suggestedPaymentMethod != nil,
            let paymentData = data.paymentData,
            let amountHelper = data.amountHelper else {
                return nil
        }

        let currency = SiteManager.shared.getCurrency()
        let defaultTextColor = UIColor.black.withAlphaComponent(0.45)
        var defaultFont = UIFont.ml_semiboldSystemFont(ofSize: TOTAL_FONT_SIZE) ?? Utils.getSemiBoldFont(size: TOTAL_FONT_SIZE)
        let interestRateAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: defaultFont,
            NSAttributedString.Key.foregroundColor: ThemeManager.shared.noTaxAndDiscountLabelTintColor()
        ]
        let firstString: NSMutableAttributedString = NSMutableAttributedString()

        if let payerCost = paymentData.payerCost {
            if payerCost.installments > 1 {
                let titleString = String(payerCost.installments) + "x " + Utils.getAmountFormated(amount: payerCost.installmentAmount, forCurrency: currency)
                let attributedTitle = NSAttributedString(string: titleString, attributes: PXNewCustomView.titleAttributes)
                firstString.append(attributedTitle)

                // Installment Rate
                if payerCost.installmentRate == 0.0 {
                    let string = " " + "Sin interés".localized.lowercased()
                    let attributedInsterest = NSAttributedString(string: string, attributes: interestRateAttributes)
                    firstString.appendWithSpace(attributedInsterest)
                }

                // Total Amount
                let totalAmountAttributes: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.font: defaultFont,
                    NSAttributedString.Key.foregroundColor: defaultTextColor
                ]
                let totalString = Utils.getAmountFormated(amount: payerCost.totalAmount, forCurrency: currency, addingParenthesis: true)
                let attributedTotal = NSAttributedString(string: totalString, attributes: totalAmountAttributes)
                firstString.appendWithSpace(attributedTotal)
            } else {
                let string = Utils.getAmountFormated(amount: payerCost.totalAmount, forCurrency: currency)
                let attributedTitle = NSAttributedString(string: string, attributes: PXNewCustomView.titleAttributes)
                firstString.append(attributedTitle)
            }
        } else {
            // Caso account money
            if let splitAccountMoneyAmount = paymentData.getTransactionAmountWithDiscount() {
                let string = Utils.getAmountFormated(amount: splitAccountMoneyAmount, forCurrency: currency)
                let attributed = NSAttributedString(string: string, attributes: PXNewCustomView.titleAttributes)
                firstString.append(attributed)
            } else {
                let string = Utils.getAmountFormated(amount: amountHelper.amountToPay, forCurrency: currency)
                let attributed = NSAttributedString(string: string, attributes: PXNewCustomView.titleAttributes)
                firstString.append(attributed)
            }
        }

        // Discount
        if let discount = paymentData.getDiscount(), let transactionAmount = paymentData.transactionAmount {
            let discountAmountAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: defaultFont,
                NSAttributedString.Key.foregroundColor: defaultTextColor,
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue
            ]
            let string = Utils.getAmountFormated(amount: transactionAmount.doubleValue, forCurrency: currency)
            let attributedAmount = NSAttributedString(string: string, attributes: discountAmountAttributes)
            firstString.appendWithSpace(attributedAmount)

            let discountString = discount.getDiscountDescription()
            let attributedString = NSAttributedString(string: discountString, attributes: interestRateAttributes)
            firstString.appendWithSpace(attributedString)
        }

        let totalView = UIView()
        totalView.translatesAutoresizingMaskIntoConstraints = false

        let totalTitleLabel = UILabel()
        
        let bottomMessage = data.remedy.suggestedPaymentMethod?.bottomMessage
        
        switch bottomMessage?.weight {
        case "regular":
            defaultFont = UIFont.ml_regularSystemFont(ofSize: 16)
        case "semi_bold":
            defaultFont = UIFont.ml_semiboldSystemFont(ofSize: 16)
        case "light":
            defaultFont = UIFont.ml_lightSystemFont(ofSize: 16)
        case "bold":
            defaultFont = UIFont.ml_boldSystemFont(ofSize: 16)
        default: break
        }
        
        totalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        totalTitleLabel.textAlignment = .left
        totalTitleLabel.backgroundColor = bottomMessage?.backgroundColor.hexToUIColor()
        totalTitleLabel.textColor = bottomMessage?.textColor.hexToUIColor()
        totalTitleLabel.numberOfLines = 1
        totalTitleLabel.text = bottomMessage?.message ?? "total_row_title_default".localized
        totalTitleLabel.font = defaultFont
        totalTitleLabel.lineBreakMode = .byTruncatingTail

        totalView.addSubview(totalTitleLabel)
        NSLayoutConstraint.activate([
            totalTitleLabel.topAnchor.constraint(equalTo: totalView.topAnchor),
            totalTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            totalTitleLabel.leftAnchor.constraint(equalTo: totalView.leftAnchor),
            totalTitleLabel.rightAnchor.constraint(equalTo: totalView.rightAnchor)
        ])

        let totalDescriptionLabel = UILabel()
        totalDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        totalDescriptionLabel.textAlignment = .left
        totalDescriptionLabel.numberOfLines = 1
        totalDescriptionLabel.attributedText = firstString
        totalDescriptionLabel.lineBreakMode = .byTruncatingTail

        totalView.addSubview(totalDescriptionLabel)
        NSLayoutConstraint.activate([
            totalDescriptionLabel.topAnchor.constraint(equalTo: totalTitleLabel.bottomAnchor),
            totalDescriptionLabel.heightAnchor.constraint(equalToConstant: 20),
            totalDescriptionLabel.leftAnchor.constraint(equalTo: totalView.leftAnchor),
            totalDescriptionLabel.rightAnchor.constraint(equalTo: totalView.rightAnchor)
        ])

        return totalView
    }
}

// MARK: MLCardFormFieldNotifierProtocol
extension PXRemedyView: MLCardFormFieldNotifierProtocol {
    func didChangeValue(newValue: String?, from: MLCardFormField) {
        if from.property.isValid(value: newValue) {
            payButton.setEnabled()
        } else {
            payButton.setDisabled()
        }
    }
}

extension PXRemedyView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}

// PXRemedy Helpers
extension PXRemedyView {
    private func getRemedyMessage() -> String {
        let remedy = data.remedy
        if let cvv = remedy.cvv, let text = cvv.message {
            return text
        } else if let highRisk = remedy.highRisk, let text = highRisk.message {
            return text
        } else if let suggestionPaymentMethod = remedy.suggestedPaymentMethod, let text = suggestionPaymentMethod.message {
            return text
        }
        return ""
    }

    private func getRemedyFieldTitle() -> String? {
        if let cvv = getCVVRemedy(), let text = cvv.fieldSetting?.title {
            return text
        }
        return nil
    }

    private func getRemedyHintMessage() -> String {
        if let cvv = getCVVRemedy(), let text = cvv.fieldSetting?.hintMessage {
            return text
        }
        return ""
    }

    private func getRemedyMaxLength() -> Int {
        if let cvv = getCVVRemedy(), let length = cvv.fieldSetting?.length {
            return length
        }
        return 0
    }

    private func shouldShowTextField() -> Bool {
        if getCVVRemedy() != nil && data.remedyViewProtocol != nil {
            return true
        }
        return false
    }

    public func shouldShowButton() -> Bool {
        let remedy = data.remedy
        if (remedy.cvv != nil || remedy.suggestedPaymentMethod != nil) &&
            data.animatedButtonDelegate != nil &&
            data.remedyButtonTapped != nil {
            return true
        }
        return false
    }

    private func getCVVRemedy() -> PXInvalidCVV? {
        if let cvv = data.remedy.cvv {
            return cvv
        }
        return nil
    }
}

// MARK: UITextViewDelegate
extension PXRemedyView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            if let range = Range(characterRange, in: textView.text),
                let text = textView.text?[range] {
                let title = String(text).capitalized
                termsAndCondDelegate?.shouldOpenTermsCondition(title, url: URL)
            }
        return false
    }
}
