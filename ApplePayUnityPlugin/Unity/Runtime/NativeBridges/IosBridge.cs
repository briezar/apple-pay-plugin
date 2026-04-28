#if UNITY_EDITOR || UNITY_IOS

using System;
using System.Runtime.InteropServices;
using AOT;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json;
using UnityEngine;

namespace NativePlugins.ApplePayPlugin
{
    internal class IosBridge : INativeBridge
    {
        private static IosBridge _instance;

        private static UniTaskCompletionSource<AuthorizeResult> _authorizeTcs;

        internal IosBridge()
        {
            if (_instance != null)
            {
                Debug.LogError($"Instantiating multiple instances of {nameof(IosBridge)} is not allowed!");
                return;
            }
            _instance = this;
        }

        public bool CanMakePayments() => _CanMakePayments();
        public bool CanMakePayments(PaymentNetworks supportedNetworks) => _CanMakePaymentsWithNetworks((long)supportedNetworks);
        public void OpenPaymentSetup() => _OpenPaymentSetup();

        public UniTask<AuthorizeResult> OpenPaymentScreen(PaymentRequestInfo paymentRequestInfo)
        {
            _authorizeTcs = new();
            var paymentRequestInfoJson = JsonConvert.SerializeObject(paymentRequestInfo);
            _OpenPaymentScreen(paymentRequestInfoJson, InvokeOnPaymentFinished);
            return _authorizeTcs.Task;
        }

        private delegate void PaymentFinishedDelegate(bool success, string data, int errorCode);

        [MonoPInvokeCallback(typeof(PaymentFinishedDelegate))]
        private static void InvokeOnPaymentFinished(bool success, string data, int errorCode)
        {
            if (success)
            {
                _authorizeTcs?.TrySetResult(new(data, null));
            }
            else
            {
                _authorizeTcs?.TrySetResult(new(null, new((AuthorizeErrorCode)errorCode, data)));
            }
        }

        [DllImport("__Internal")] private static extern bool _CanMakePayments();
        [DllImport("__Internal")] private static extern bool _CanMakePaymentsWithNetworks(long supportedNetworksMask);
        [DllImport("__Internal")] private static extern void _OpenPaymentSetup();
        [DllImport("__Internal")] private static extern void _OpenPaymentScreen(string paymentRequestInfoJson, PaymentFinishedDelegate onFinishPayment);
    }
}

#endif