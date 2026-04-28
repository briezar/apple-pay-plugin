using System;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json;

namespace NativePlugins.ApplePayPlugin
{
    internal interface INativeBridge
    {
        bool CanMakePayments();
        bool CanMakePayments(PaymentNetworks supportedNetworks);
        void OpenPaymentSetup();
        UniTask<AuthorizeResult> OpenPaymentScreen(PaymentRequestInfo paymentRequestInfo);
    }

    public record AuthorizeResult(string PaymentDataJson, AuthorizeError Error = null) { public bool Success => Error == null; };
    public record AuthorizeError(AuthorizeErrorCode Code, string Message);
}

namespace System.Runtime.CompilerServices
{
    internal class IsExternalInit { }
}
