import Foundation
import PassKit

public class ApplePayPlugin {
    private var _paymentHandler: PaymentHandler?

    public func canMakePayments() -> Bool {
        PKPaymentAuthorizationController.canMakePayments()
    }

    public func canMakePayments(usingNetworks supportedNetworks: [PKPaymentNetwork]) -> Bool {
        PKPaymentAuthorizationController.canMakePayments(usingNetworks: supportedNetworks)
    }

    public func openPaymentSetup() {
        let passLibrary = PKPassLibrary()
        passLibrary.openPaymentSetup()
    }

    public func openPaymentScreen(paymentRequestInfo: PaymentRequestInfo) {
        _paymentHandler = PaymentHandler(paymentRequestInfo: paymentRequestInfo)
        _paymentHandler?.present()
    }
}
