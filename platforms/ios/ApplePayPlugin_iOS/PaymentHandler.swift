import PassKit

typealias PaymentCompletionHandler = (PKPaymentAuthorizationResult) -> Void

class PaymentHandler: NSObject {
    private var _paymentRequestInfo: PaymentRequestInfo
    private var _paymentController: PKPaymentAuthorizationController

    private var _paymentResult: (success: Bool, data: String, error: PaymentError?) = (false, "User Cancelled", .userCancelled)

    init(paymentRequestInfo: PaymentRequestInfo) {
        _paymentRequestInfo = paymentRequestInfo
        let item = PKPaymentSummaryItem(label: paymentRequestInfo.packageName, amount: paymentRequestInfo.packagePrice as NSDecimalNumber, type: .final)

        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = paymentRequestInfo.merchantId
        paymentRequest.countryCode = paymentRequestInfo.countryCode
        paymentRequest.supportedNetworks = decodePaymentNetworks(from: paymentRequestInfo.supportedNetworks)
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.paymentSummaryItems = [item]
        paymentRequest.currencyCode = paymentRequestInfo.currencyCode

        _paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
    }

    func present() {
        _paymentController.delegate = self
        _paymentController.present(completion: { (presented: Bool) in
            if !presented {
                Callbacks.onFinishPayment?(
                    false, "Failed to present the payment sheet, check your configs and try again", PaymentError.failedToPresent.rawValue)
            }
        })
    }
}

extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {

    func paymentAuthorizationController(
        _ controller: PKPaymentAuthorizationController,
        didAuthorizePayment payment: PKPayment,
        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
    ) {
        let paymentData = String(decoding: payment.token.paymentData, as: UTF8.self)
        _paymentResult = (true, paymentData, nil)
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }

    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        // The payment sheet doesn't automatically dismiss once it has finished. Dismiss the payment sheet.
        controller.dismiss {
            DispatchQueue.main.async {
                let paymentResult = self._paymentResult
                Callbacks.onFinishPayment?(paymentResult.success, paymentResult.data, paymentResult.error?.rawValue ?? -1)
            }
        }
    }
}

enum PaymentError: Int32 {
    case userCancelled = 0

    case failedToPresent = 1000

    case unknown = 4000
}

func decodePaymentNetworks(from mask: Int64) -> [PKPaymentNetwork] {
    if mask == 0 { return [] }
    var networks: [PKPaymentNetwork] = []
    func hasBit(_ n: Int64) -> Bool { (mask & (Int64(1) << n)) != 0 }

    if hasBit(0) { networks.append(.amex) }
    //         if hasBit(1) { networks.append(.pagoBancomat) }
    //         if hasBit(2) { networks.append(.bancontact) }
    if hasBit(3) { networks.append(.cartesBancaires) }
    if hasBit(4) { networks.append(.chinaUnionPay) }
    //         if hasBit(5) { networks.append(.dankort) }
    if hasBit(6) { networks.append(.discover) }
    if hasBit(7) { networks.append(.eftpos) }
    if hasBit(8) { networks.append(.electron) }
    if hasBit(9) { networks.append(.elo) }
    if hasBit(10) { networks.append(.idCredit) }
    if hasBit(11) { networks.append(.interac) }
    if hasBit(12) { networks.append(.JCB) }
    if hasBit(13) { networks.append(.mada) }
    if hasBit(14) { networks.append(.maestro) }
    if hasBit(15) { networks.append(.masterCard) }
    //         if hasBit(16) { networks.append(.mir) }
    if hasBit(17) { networks.append(.privateLabel) }
    if hasBit(18) { networks.append(.quicPay) }
    if hasBit(19) { networks.append(.suica) }
    if hasBit(20) { networks.append(.visa) }
    if hasBit(21) { networks.append(.vPay) }
    //         if hasBit(22) { networks.append(.barcode) }
    //         if hasBit(23) { networks.append(.girocard) }
    //         if hasBit(24) { networks.append(.waon) }
    //         if hasBit(25) { networks.append(.nanaco) }
    //         if hasBit(26) { networks.append(.postFinance) }
    //         if hasBit(27) { networks.append(.tmoney) }
    //         if hasBit(28) { networks.append(.meeza) }
    //         if hasBit(29) { networks.append(.NAPAS) }
    //         if hasBit(30) { networks.append(.bankAxept) }
    //         if hasBit(31) { networks.append(.himyan) }
    //         if hasBit(32) { networks.append(.jaywan) }
    //         if hasBit(33) { networks.append(.myDebit) }

    return networks
}
