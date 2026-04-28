import Foundation

public typealias PaymentFinishedDelegate = @convention(c) (_ success: Bool, _ data: CStringPtr, _ errorCode: Int32) -> Void;

public final class Callbacks {
    public static var onFinishPayment: PaymentFinishedDelegate?
}

let _plugin = ApplePayPlugin()

@_cdecl("_CanMakePayments")
public func _CanMakePayments() -> Bool {
    _plugin.canMakePayments()
}

@_cdecl("_CanMakePaymentsWithNetworks")
public func _CanMakePaymentsWithNetworks(_ supportedNetworksMask: Int64) -> Bool {
    _plugin.canMakePayments(usingNetworks: decodePaymentNetworks(from: supportedNetworksMask))
}

@_cdecl("_OpenPaymentSetup")
public func _OpenPaymentSetup() {
    _plugin.openPaymentSetup()
}

@_cdecl("_OpenPaymentScreen")
public func _OpenPaymentScreen(paymentRequestInfoJson: CStringPtr, onFinishPayment: @escaping PaymentFinishedDelegate) {
    guard let paymentRequestInfo = try? JsonConvert.deserializeObject(paymentRequestInfoJson.toString(), as: PaymentRequestInfo.self) else {
        onFinishPayment(false, "Invalid JSON for PaymentRequestInfo: \(paymentRequestInfoJson.toString())", PaymentError.unknown.rawValue)
        return
    }
    Callbacks.onFinishPayment = onFinishPayment
    _plugin.openPaymentScreen(paymentRequestInfo: paymentRequestInfo)
}
