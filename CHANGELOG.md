# v4.49.2
🚀Private Release - 4.49.2 date: 28/10/2021 🚀
- Fixed error screen when there is no payer payment methods but offline methods

# v4.49.1 
🚀Private Release - 4.49.1 date: 19/10/2021 🚀
- Include CFTEA when remedy is a credit

# v4.49.0 
🚀Private Release - 4.49.0 date: 30/09/2021 🚀
- Removed groups from PXInitDTO
- RemedyView secondary button layout fixes
- Security Code screen reset button main thread update fix

# v4.48.0 
🚀Private Release - 4.48.0 date: 28/09/2021 🚀
- Taxable charges support

# v4.47.1
🚀Private Release - 4.47.1 date: 23/09/2021 🚀
- Card size fixing
- Modal action fix

# v4.47.0
🚀Private Release - 4.47.0 date: 23/09/2021 🚀
- Bugfix terms and conditions opening yellow app
- Removed old network layer
- Remedy trackings
- Mercado Créditos payment confirmation modal
- Tracking external data improvements

# v4.46.0
🚀Private Release - 4.46.0 date: 16/09/2021 🚀
- Showing modal when remedies card option given from BE is Mercado Creditos (disabled until tracks are done)
- Card size on remedies dynamic according to BE response (disabled until tracks are done)
- Tokenizing without cvv/ESC
- Terms of use removed from customCard and added to top of payButton

# v4.45.0
🚀Private Release - 4.45.0 🚀
- Fixed decimal calculation for getRawAmount

# v4.44.0
🚀Private Release - 4.44.0 🚀
- Added new network layer with access token in header instead query param
- Added AndesMessage on congrats screen
- Fix label on oneTap header to limit its characters and not invading value label
- Fix on OneTapFlow where OneTapFlow instance was being killed intead of being updated

# v4.43.2
🚀Private Release - 4.43.2 🚀
- Added ProfileID protocol, default and header key-value for payments call with default processor
- Adds a parameter on congrats request

# v4.42.0
🚀Private Release - 4.42.0 🚀
- IDC regulation improvements
- Fix BCRA retries

# v4.41.1
🚀Private Release - 4.41.1 🚀
- IDC regulation 

# v4.41.0
🚀Private Release - 4.41.0 🚀
- BCRA regulation

# v4.40.1
🚀Private Release - 4.40.1 🚀
- Fixed header merchant view cornerRadius

# v4.40.0
🚀Private Release - 4.40.0 🚀
- Added the new installments v2.1 component on OneTap
- Added support for the new MLCardDrawerV3 card types
- Improved ComboSwitch behaviour on small devices 

# v4.39.5
🚀Private Release - 4.39.5 🚀
- Fix crashes caused because of mapToJSON() method on PaymentMethodSearchService class
- Fix duplicate views on congrats after unlock phone
- Remove forced unwrap from tracks

# v4.39.4
🚀Private Release - 4.39.4 🚀
- Adjusting project to manage tracks in a new way

# v4.39.3
🚀Private Release - 4.39.3 🚀
- Conforming with old CardDrawer protocol

# v4.39.0
🚀Private Release - 4.39.0 🚀
- Pix payment

# v4.38.0
🚀Private Release - 4.38.0 🚀
- Now backend sends behaviours inside applications node so we use it from there, using the old behaviours node as fallback
- BugFix duplicated button on congrats
- Changed applications location on PXOneTapViewModel+Tracking and replaced key by 'methods_applications'

# v4.37.11
🚀Private Release - 4.37.11 🚀
- Added Combo Cards Support
- Default message error provided if we do not have the error mapped 

# v4.37.7
🚀Private Release - 4.37.7 🚀
- Bumped MLCardDrawer 

# v4.37.6
🚀Private Release - 4.37.6 🚀
- Add a method to allow users from PX get validationProgramId on PXCheckoutStore

# v4.37.5
🚀Private Release - 4.37.5 🚀
- Fix cvv textField that allow typing after submit
- Add propertie validationProgramId on PXCheckoutStore to be sent on future requests

# v4.37.4 
🚀Private Release - 4.37.4 🚀
- Fix pay button when going to add a new card and coming back without adding one
- Fix secondary button not showing up on remedy view

# v4.37.3
🚀Private Release - 4.37.3 🚀
- Add webpay for MLC
- Fix bundle version
- Removed unused classes, removed white spaces, moved files to the correct folder
- Using Loyalty Broadcaster
- Add merchant_order_id to congrats

# v4.37.2
🚀Private Release - 4.37.2 🚀
- Removed old CVV view
- Fixed a bug where the loading indicator wouldn't be dismissed

# v4.37.1
🚀Private Release - 4.37.1 🚀
MercadoPagoSDKV4 - Private Version
- Remove groups and unused assets

# v4.37.0
🚀Private Release - 4.37.0 🚀
MercadoPagoSDKV4 - Private Version
- Add hybrid card support

# v4.36.9
🚀Private Release - 4.36.9 🚀
MercadoPagoSDKV4 - Private Version
- Added location header to congrats

# v4.36.8
🚀Private Release - 4.36.8 🚀
MercadoPagoSDKV4 - Private Version
- Support WebPay cards payments
- Fix crash adding a new card

# v4.36.7
🚀Private Release - 4.36.7 🚀
MercadoPagoSDKV4 - Private Version
- Autoreturn improvements
- Tracking fix (total_amount)

# v4.36.6 
🚀Private Release - 4.36.6 🚀
MercadoPagoSDKV4 - Private Version
- Make lib static
- Add additional discount params

# v4.36.5
🚀Private Release - 4.36.5 🚀
MercadoPagoSDKV4 - Private Version
- New SecurityCode screen

# v4.36.4
🚀Private Release - 4.36.4 🚀
MercadoPagoSDKV4 - Private Version
- Fix a bug in remedies not showing credits, and fixed amount shown

# v4.36.3
🚀Private Release - 4.36.3 🚀
MercadoPagoSDKV4 - Private Version
- Add merchantOrderId to payment body

# v4.36.2
🚀Private Release - 4.36.2 🚀
MercadoPagoSDKV4 - Private Version
- Fix button location an view constraints
- Add whitespace in discount label

# v4.36.1
🚀Private Release - 4.36.1 🚀
MercadoPagoSDKV4 - Private Version
- Fix an issue with ObjC allowing to set a nil preference
- Fix an issue with some payment methods trying to fetch instructions

# v4.36.0
🚀Private Release - 4.36.0 🚀
MercadoPagoSDKV4 - Private Version
- Tracking path distinto cuando se instancia Congrats desde afuera.

# v4.35.9
🚀Private Release - 4.35.9 🚀
MercadoPagoSDKV4 - Private Version
- Congrats desacopladas del checkout

# v4.35.8
🚀Private Release - 4.35.8 🚀
MercadoPagoSDKV4 - Private Version
- Fix onetap finishPaymentFlow when cvv is required

# v4.35.7
🚀Private Release - 4.35.7 🚀
MercadoPagoSDKV4 - Private Version
- MoneyIn MLB en Onetap
- Remote assets para medios off

# v4.35.6
🚀Private Release - 4.35.6 🚀
MercadoPagoSDKV4 - Private Version
- Fix issuer

# v4.35.5
🚀Private Release - 4.35.5 🚀
MercadoPagoSDKV4 - Private Version
- Fix bundle selection

# v4.35.4
🚀Private Release - 4.35.4 🚀
MercadoPagoSDKV4 - Private Version
- Fix discounts bug
- Fix bundle for V4

# v4.35.3
🚀Private Release - 4.35.3 🚀
MercadoPagoSDKV4 - Private Version
- Create resources bundle
- Move ESC to PXAddons

# v4.35.2
🚀Private Release - 4.35.2 🚀
MercadoPagoSDKV4 - Private Version
- Fix redirect bug

# v4.35.1
🚀Private Release - 4.35.1 🚀
MercadoPagoSDKV4 - Private Version
- Feature CFT
- Add backURL, redirectURL and autoreturn
- Show discounts row for consumer credits
- Discounts row improvements

# v4.35.0
🚀Private Release - 4.35.0 🚀
MercadoPagoSDKV4 - Private Version
- Use MLCardFormField as Remedy textfield
- Add extraInfo for consumer credits
- Fix oneTap crash
- Swap remedy textfield title and help texts

# v4.34.9
🚀Private Release - 4.34.9 🚀
MercadoPagoSDKV4 - Private Version
- Add new values to Pref additional info
- Deprecate Groups models
- Fix oneTap crash

# v4.34.8
🚀Private Release - 4.34.8 🚀
MercadoPagoSDKV4 - Private Version
- Discounts enhancements
- Melidata fix
- Remedy title fix
- Ifpe backoffice fix

# v4.34.7 
🚀Private Release - 4.34.7 🚀
MercadoPagoSDKV4 - Private Version
- Fix url for tracking
- Fix medios off con kyc

# v4.34.6 
🚀Private Release - 4.34.6 🚀
MercadoPagoSDKV4 - Private Version
- Add ExpenseSplitView to congrats
- Fix silverBullet amount
- Use PXAddons tracking
- Remedies tracking changes

# v4.34.5
🚀Private Release - 4.34.5 🚀
MercadoPagoSDKV4 - Private Version
- Reduce image sizes

# v4.34.4
🚀Private Release - 4.34.4 🚀
MercadoPagoSDKV4 - Private Version
- Fix discounts bug for pay-preference
- Appium improvements

# v4.34.3
🚀Private Release - 4.34.3 🚀
MercadoPagoSDKV4 - Private Version
- Se agrego la sigla CNTFA para credits

# v4.34.2
🚀Private Release - 4.34.2 🚀
MercadoPagoSDKV4 - Private Version
- Feature Highlight Installments

# v4.34.1
🚀Private Release - 4.34.1 🚀
MercadoPagoSDKV4 - Private Version
- Se actualiza la congrats
- Se corrigio un bug al agregar una nueva tarjeta

# v4.34.0
🚀Private Release - 4.34.0 🚀
MercadoPagoSDKV4 - Private Version
- Se actualiza el monto para la validacion de biometric
- Se agrego security type al PXCheckoutStore
- Se redujo el numero de warnings en xCode

# v4.33.9
🚀Private Release - 4.33.9 🚀
MercadoPagoSDKV4 - Private Version
- Se corrigieron tracks invalidos (Melidata)
- Se quitaron clases en desuso
- Se corrigio el bug 1062
- Se corrigio el bug 1100

# v4.33.8
🚀Private Release - 4.33.8 🚀
MercadoPagoSDKV4 - Private Version
- Se agrego el nuevo componente MLBusinessTouchpointsView
- Refactor Codable

# v4.33.7
🚀Private Release - 4.33.7 🚀
MercadoPagoSDKV4 - Private Version
- Fix cardlabel bug

# v4.33.6
🚀Private Release - 4.33.6 🚀
MercadoPagoSDKV4 - Private Version
- Feature CoronaVoucher
- Fix loading issue
- Agregado de datos para tracking de remedies
- Fix CardForm flowID value

# v4.33.5
🚀Private Release - 4.33.5 🚀
MercadoPagoSDKV4 - Private Version
- Add total amount for silver bullet remedy
- Add flow name to every request header. Remove flow name as remedies request param
- Fix tyc view

# v4.33.4
🚀Private Release - 4.33.4 🚀
MercadoPagoSDKV4 - Private Version
- Updated AndesUI version to 3.0

# v4.33.3
🚀Private Release - 4.33.3 🚀
MercadoPagoSDKV4 - Private Version
- Remedy improvements

# v4.33.2
🚀Private Release - 4.33.2 🚀
MercadoPagoSDKV4 - Private Version
- IFPE support
- Add Card to CVV Remedy
- Fix bug 1081
- Accessibility improvements

# v4.33.1
🚀Private Release - 4.33.1 🚀
MercadoPagoSDKV4 - Private Version
- ODR support
- Accessibility improvements
- Fix remedy bug

# v4.33.0
🚀Private Release - 4.33.0 🚀
MercadoPagoSDKV4 - Private Version
- Accessibility
- Fix CallForAuth crash

# v4.32.9
🚀Private Release - 4.32.9 🚀
MercadoPagoSDKV4 - Private Version
- Translation fixes

# v4.32.8
🚀Private Release - 4.32.8 🚀
MercadoPagoSDKV4 - Private Version
- Reset ESC Cap hot fix

# v4.32.7
🚀Private Release - 4.32.7 🚀
MercadoPagoSDKV4 - Private Version
- ESC tracking

# v4.32.6
🚀Private Release - 4.32.6 🚀
MercadoPagoSDKV4 - Private Version
- Reset ESC Cap
- Services refactor
- Fonts fixes
- Minor bug fixes

# v4.32.5
🚀Private Release - 4.32.5 🚀
MercadoPagoSDKV4 - Private Version
- Pay preference fixes
- Translations fixes
- Tracking enhancements

# v4.32.4
🚀Public Release - 4.32.4 🚀
MercadoPagoSDK - Public Version
- Edit CPF button removed
- Brasil locale fix
- Benefits fix
- Translations fixes
- Old code deleted

# v4.32.3
🚀Private Release - 4.32.3 🚀
MercadoPagoSDKV4 - Private Version
- MLBusiness Discount Tracker
- Edit CPF button removed
- Brasil locale fix
- Benefits fix
- Translations fixes
- Old code deleted

# v4.32.2
🚀Public Release - 4.32.2 🚀
MercadoPagoSDK - Public Version
- One Tap for new and white label users
- ESC Always on
- Translations fixes
- Minor UI Fixes

# v4.32.1
🚀Private Release - 4.32.1 🚀
MercadoPagoSDKV4 - Private Version
- MLBusiness Discount Tracker disabled

# v4.32.0
🚀Private Release - 4.32.0 🚀
MercadoPagoSDKV4 - Private Version
- ESC Always on
- One Tap for new and white label users
- Consumer credits terms and conditions for MLB
- MLBusiness Discount Tracker
- Congrats tracking protocol
- Translations fixes
- Minor UI Fixes

# v4.31.1
🚀Private Release - 4.31.1 🚀
MercadoPagoSDKV4 - Private Version
- Offline payment methods
- Consumer credits view in Congrats
- Site fix
- ESC fix

# v4.30.2
🚀Private Release - 4.30.2 🚀
MercadoPagoSDKV4 - Private Version
- Business Result help message fix
- MLFonts fixed on One Tap
- Discounts dynamic modal

# v4.30.1
🚀Private Release - 4.30.1 🚀
MercadoPagoSDKV4 - Private Version
- MLCardForm update
- Added max retries for Init refresh

# v4.30
🚀Private Release - 4.30 🚀
MercadoPagoSDKV4 - Private Version
- MLCardForm support

# v4.29.1
🚀Private Release - 4.29.1 🚀
MercadoPagoSDKV4 - Private Version
- Babel support
- Error result screen layout updated
- Payment method pre selection fix

# v4.29
🚀Private Release - 4.29 🚀
MercadoPagoSDKV4 - Private Version
- Babel support
- Error result screen layout updated
- Payment method pre selection fix

# v4.28.3
🚀Private Release - 4.28.3 🚀
MercadoPagoSDKV4 - Private Version
- Discount params config Product ID fix

# v4.28.2
🚀Private Release - 4.28.2 🚀
MercadoPagoSDKV4 - Private Version
- Max installments fix
- Double rounded fix
- One Tap header UI fix

# v4.28.1
🚀Private Release - 4.28.1 🚀
MercadoPagoSDKV4 - Private Version
- Benefits support
- Installments UI enhancements

# v4.28
🚀Public Release - 4.28 🚀
MercadoPagoSDKV4 - Public Version
- Parity with external version

# v4.27.2
🚀Private Release - 4.27.2 🚀
MercadoPagoSDKV4 - Private Version
- Order ID & Merchant Order ID fix

# v4.27.1
🚀Private Release - 4.27.1 🚀
MercadoPagoSDKV4 - Private Version
- Charge rule message support

# v4.27
🚀Private Release - 4.27 🚀
MercadoPagoSDKV4 - Private Version
- Disabled payment methods support

# v4.26.1
🚀Private Release - 4.26.1 🚀
MercadoPagoSDKV4 - Private Version
- PXExperiments ID fix

# v4.26
🚀Private Release - 4.26 🚀
MercadoPagoSDKV4 - Private Version
- New init endpoint

# v4.24.3
🚀Private Release - 4.24.3 🚀
MercadoPagoSDKV4 - Private Version
- Payment IDs fix

# v4.24.2
🚀Private Release - 4.24.2 🚀
MercadoPagoSDKV4 - Private Version
- Rut Fix
- Congrats improvements


# v4.24
🚀Private Release - 4.24 🚀
MercadoPagoSDKV4 - Private Version
- Congrats improvements
- Fix warnings and possible leaks
- Fix bug oneTap installmentsView


# v4.23
🚀Private Release - 4.23 🚀
MercadoPagoSDKV4 - Private Version
- Congrats improvements
- Handler for Biometric and ESC
- Business Result receiptIdList and shouldShowReceipt


# v4.22.1
🚀Private Release - 4.22.1 🚀
MercadoPagoSDKV4 - Private Version
- Congrats hot fix

# v4.22
🚀Private Release - 4.22 🚀
MercadoPagoSDKV4 - Private Version
- Points and Discounts feature

# v4.21.2
🚀Private Release - 4.21.2 🚀
MercadoPagoSDKV4 - Private Version
- Change access level PXBiometricConfig

# v4.21.1
🚀Private Release - 4.21.1 🚀
MercadoPagoSDKV4 - Private Version
- iOS 13 navigation bar - Meli compatibility


# v4.21
🚀Private Release - 4.21 🚀
MercadoPagoSDKV4 - Private Version
- Add collector id to checkout pref
- Add importantView to sign business result
- FIX / One tap title label fix

# v4.20.0
🚀Private Release - 4.20.0 🚀
MercadoPagoSDKV4 - Private Version
- Fix onetap summary animation
- Fix identification type
- Tracking improvements
- Deprecate iOS 9 Support
- Biometric abstraction and default implementation
- Add productId to addCardFlow
- General improvements

# v4.19.0
🚀Private Release - 4.19.0 🚀
MercadoPagoSDKV4 - Private Version
- Credits
- iOS13 improvements
- Fix aspect ratio
- Fix CFT

# v4.18.3
🚀Public Release - 4.18.3 🚀
MercadoPagoSDK - Public Version
- Bugfixing and iOS13 support

# v4.18.2
🚀Private Release - 4.18.2 🚀
MercadoPagoSDKV4 - Private Version
- Fix CFT

# v4.18.1
🚀Private Release - 4.18.1 🚀
MercadoPagoSDKV4 - Private Version
- Credits
- iOS13 improvements
- Fix aspect ratio

# v4.18.0
🚀Private Release - 4.18.0 🚀
MercadoPagoSDKV4 - Private Version
- Credits
- iOS13 improvements

# v4.17.0
🚀Private Release - 4.17.0 🚀
MercadoPagoSDKV4 - Private Version
- Pay preference

# v4.16.1
🚀Private Release - 4.16.1 🚀
MercadoPagoSDKV4 - Private Version
- Tracking expiration_date_from crash fix


# v4.16.0
🚀Private Release - 4.16.0 🚀
MercadoPagoSDKV4 - Private Version
- Max installments fix
- Empty issuer fix

# v4.15.2
🚀Private Release - 4.15.2 🚀
MercadoPagoSDKV4 - Private Version
- Environment fix

# v4.15.1
🚀Private Release - 4.15.1 🚀
MercadoPagoSDKV4 - Private Version
 - Processing Modes Fixes

# v4.15.0
🚀Private Release - 4.15.0 🚀
MercadoPagoSDKV4 - Private Version
 - Gateway Mode Support

# v4.14.0
🚀Private Release - 4.14.0 🚀
MercadoPagoSDKV4 - Private Version
 - Session id fixes
 - Card drawer lib added
 - iOS 13 Support for presents


# v4.13.1
🚀Private Release - 4.13.1 🚀
MercadoPagoSDKV4 - Private Version
 - Multiplayer pay button customization
 - Fix crash back button in card flow

# v4.13.0
🚀Private Release - 4.13.0 🚀
MercadoPagoSDKV4 - Private Version
 - Add flow to esc
 - Congrats fix waiting for payment will be green
 - SP Support charges
 - Fix to enable loyalty integration
 - Session tracking update
 - Tracking names updated
 - Fix cache on add card flow

# v4.12.1
🚀Private Release - 4.12.1 🚀
MercadoPagoSDKV4 - Private Version
- Change cap esc tracking name

# v4.12.0
🚀Private Release - 4.12.0 🚀
MercadoPagoSDKV4 - Private Version
- ESC for new cards
- Tracking ESC
- Improvements in tokenization service
- Loyalty discount name

# v4.10.2
🚀Private Release - 4.10.2 🚀
MercadoPagoSDKV4 - Private Version
- Fix for broken card layout

# v4.10.0
🚀Private RC - 4.10.0 🚀
MercadoPagoSDKV4 - Private Version
- New comunications for rejected screens
- Disabled previous payment method for high risk scenarios
- Session id for tracking
- Support for single player in one tap
- New banamex images

# v4.9.0
🚀Private RC - 4.9.0 🚀
MercadoPagoSDKV4 - Private Version
- MoneyIn CNPJ
- Loyalty support
- Issuer images feature
- Instore YPF AddCard flow (Skip Congrats)
- Fix payer cost bug with saved cards
- Fix swiftlint
- Remove track token and off paymets

# v4.8.2
🚀Private RC - 4.8.2 🚀
MercadoPagoSDKV4 - Private Version
- Fix loading vending processor

# v4.8.1
🚀Private RC - 4.8.1 🚀
MercadoPagoSDKV4 - Private Version
- Fix screen processor vending bug

# v4.8.0
🚀Private RC - 4.8.0 🚀
MercadoPagoSDKV4 - Private Version
- Sould out
- Discount for payment method for account money
- Fix loading payment processor
- Fix ESC with payment processor
- Fix one tap animation button with no approved payments
- Add identifiers for ETES

# v4.7.6
🚀Public RC - 4.7.6 🚀
MercadoPagoSDK - Public Version

# v4.7.5
🚀Private RC - 4.7.5 🚀
MercadoPagoSDKV4 - Private Version
- Fix split payments fail flow.
- Fix payment flow after not saved ESC.


# v4.7.4
🚀Private RC - 4.7.4 🚀
MercadoPagoSDKV4 - Private Version
- Fix double rounding error
- Fix ESC

# v4.7.3
🚀Private RC - 4.7.3 🚀
MercadoPagoSDKV4 - Private Version
- Fix deserializing discount id as int instead of int64
- Fix sold out discounts legal terms
- Fix CFT with one installment in one tap
- Fix double rounding error

# v4.7.2
🚀Private RC - 4.7.2 🚀
MercadoPagoSDKV4 - Private Version
- Split Payments Fix Switch size.

# v4.7.1
🚀Private RC - 4.7.1 🚀
MercadoPagoSDKV4 - Private Version
- Split Payments UI Switch (Minor Fix)

# v4.7.0
🚀Private RC - 4.7.0 🚀
MercadoPagoSDKV4 - Private Version
- Split Payment Method
- CPF & CNPJ validator
- Cross button in Congrats with tracking
- Fix default installments bug
- Fix bug with checkout preference
- Fix additional step total row bug

# v4.6.5
🚀Private RC - 4.6.5 🚀
MercadoPagoSDKV4 - Private Version
- Terms and Conditions tracking crash fix

# v4.6.4
🚀Private RC - 4.6.4 🚀
MercadoPagoSDKV4 - Private Version
- Discount obj-c support fix
- Discount clear when changing payment method

# v4.6.3
🚀Private RC - 4.6.3 🚀
MercadoPagoSDKV4 - Private Version
- Discount Terms and Conditions fix

# v4.6.2
🚀Private RC - 4.6.2 🚀
MercadoPagoSDKV4 - Private Version
- Discount Token fix

# v4.6.1
🚀Private RC - 4.6.1 🚀
MercadoPagoSDKV4 - Private Version
- Tracking key hot fix

# v4.6.0
🚀Private RC - 4.6.0 🚀
MercadoPagoSDKV4 - Private Version
- Disocunt V2, discounts by payment method
- Swift 4.2

# v4.5.2
🚀Private RC - 4.5.2 🚀
MercadoPagoSDKV4 - Private Version
- Resolve visual bug in Review And Confirm and Congrats
- Resolve bug in boleto without payment processor

# v4.5.1
🚀Private RC - 4.5.1 🚀
MercadoPagoSDKV4 - Private Version
- Resolve visual bug en congrats

# v4.5.0
🚀Private RC - 4.5.0 🚀
MercadoPagoSDKV4 - Private Version
- Account money as First Class Member, plugin funcionality is deprecated.
- Add tracking events and data in screen views.

# v4.4.1
🚀Private RC - 4.4.1 🚀
MercadoPagoSDKV4 - Private Version
- Hotfix save ESC in one tap.

# v4.4.0
🚀Private RC - 4.4.0 🚀
MercadoPagoSDKV4 - Private Version
- Share ESC feature
- Save ESC when tokenized card
- MoneyIn fixes & tech debt
- One tap visual improvements

# v4.3.6
🚀Private RC - 4.3.6 🚀
HotFix One Tap

# v4.3.5
🚀Private RC - 4.3.5 🚀
MercadoPagoSDKV4 - Private Version
HOTFIX: OneTap check by cardId / 1 installment UI Row
- One Tap
- MoneyIn
- Fix ESC Impl Default value.
- Improvement Green discount arrow OneTap.
- Improvement Aspectfill congrats image.

# v4.3.4
🚀Private RC - 4.3.4 🚀
MercadoPagoSDKV4 - Private Version
- One Tap
- MoneyIn
- Fix ESC Impl Default value.
- Improvement Green discount arrow OneTap.
- Improvement Aspectfill congrats image.

# v4.3.3
🚀Private RC - 4.3.3 🚀
MercadoPagoSDKV4 - Private Version
- One Tap
- MoneyIn
- Fix ESC Impl Default value.

# v4.3.2
🚀Private RC - 4.3.2 🚀
MercadoPagoSDKV4 - Private Version
- One Tap
- MoneyIn - Fix Revisa y Confirma bucle infinito.

# v4.3.1
🚀Private RC - 4.3.1 🚀
MercadoPagoSDKV4 - Private Version
- One Tap
- MoneyIn

# v4.3.0
🚀Private RC - 4.3.0 🚀
MercadoPagoSDKV4 - Private Version
- One Tap RC

# v4.2.1
🚀4.2.1 - Private RC 🚀
- HotFix xCode and Swift error:
https://developer.apple.com/documentation/swift/array/3017532-removeall

# v4.2.0
🚀4.2.0 - Private RC 🚀
- Remove tracking from error screen
- Fix bank deals
- Change way of deleting dynamic views
- Cambio paths tracking
- Dynamic View Controllers
- Dynamic views in Review and Confirm
- Fix create payment flow

# v4.1.1
🚀4.1.1 - Private RC 🚀
MercadoPagoSDKV4 - Private Version
- Alta tarjeta support flow (Add new endpoint url)


# v4.1.0
🚀4.1.0 - Private RC 🚀
MercadoPagoSDKV4 - Private Version
- Alta tarjeta support flow
- Translations improvement.

# v4.0.12

🚀Public RC - 4.0.12 🚀
MercadoPagoSDK - Public Version

- Changes for scalable private and public pod.
- Translations Improvement

Readme
https://github.com/mercadopago/px-ios/blob/4.0.12/README.md

Documentation reference
http://mercadopago.github.io/px-ios/v4/

# v4.0.11

🚀Public RC - 4.0.11 🚀
MercadoPagoSDK - Public Version

Readme
https://github.com/mercadopago/px-ios/blob/4.0.11/README.md

Documentation reference
http://mercadopago.github.io/px-ios/v4/
