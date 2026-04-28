using System;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json;
using UnityEngine;

namespace NativePlugins.ApplePayPlugin
{
    public static class ApplePay
    {
        private static readonly INativeBridge _bridge;

        static ApplePay()
        {
#if UNITY_EDITOR
            _bridge = new EditorBridge();
#elif UNITY_IOS
            _bridge = new IosBridge();
#endif
        }

        /// <summary>
        /// Check if Apple Pay is supported on the current platform.
        /// </summary>
        public static bool IsSupported => _bridge != null;

        /// <summary>
        /// Check if the device is capable of making payments.<br/>
        /// <seealso href="https://developer.apple.com/documentation/passkit/pkpaymentauthorizationviewcontroller/canmakepayments()">PKPaymentAuthorizationViewController.canMakePayments()</seealso>
        /// </summary>
        public static bool CanMakePayments() => _bridge.CanMakePayments();

        /// <summary>
        /// Check if the device is capable of making payments with the specified payment networks.<br/>
        /// <seealso href="https://developer.apple.com/documentation/passkit/pkpaymentauthorizationviewcontroller/canmakepayments(usingnetworks:)">PKPaymentAuthorizationViewController.canMakePayments(usingNetworks:)</seealso>
        /// </summary>
        public static bool CanMakePayments(PaymentNetworks supportedNetworks) => _bridge.CanMakePayments(supportedNetworks);

        /// <summary>
        /// Opens the user interface to set up credit cards for Apple Pay.<br/>
        /// <seealso href="https://developer.apple.com/documentation/passkit/pkpasslibrary/openpaymentsetup()">PKPassLibrary.openPaymentSetup()</seealso>
        /// </summary>
        public static void OpenPaymentSetup() => _bridge.OpenPaymentSetup();

        /// <summary>
        /// Opens the Apple Pay payment sheet with the provided payment request information.<br/>
        /// Pass in custom <see cref="JsonSerializerSettings"/> if you need to customize the serialization process for the payment request.<br/>
        /// <seealso href="https://developer.apple.com/documentation/passkit/pkpaymentauthorizationcontroller/present(completion:)">PKPaymentAuthorizationController.present(completion:)</seealso>
        /// </summary>
        public static UniTask<AuthorizeResult> OpenPaymentScreen(PaymentRequestInfo paymentRequestInfo) => _bridge.OpenPaymentScreen(paymentRequestInfo);
    }
}
