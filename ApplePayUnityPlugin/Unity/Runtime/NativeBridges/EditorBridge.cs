#if UNITY_EDITOR

using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using UnityEngine;
using UnityEngine.Networking;

namespace NativePlugins.ApplePayPlugin
{
    internal class EditorBridge : INativeBridge
    {
        public bool CanMakePayments() => true;
        public bool CanMakePayments(PaymentNetworks supportedNetworks) => true;
        public void OpenPaymentSetup() { }
        public async UniTask<AuthorizeResult> OpenPaymentScreen(PaymentRequestInfo paymentRequestInfo) => new AuthorizeResult("{}");
    }
}

#endif