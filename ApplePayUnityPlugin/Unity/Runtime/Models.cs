using System;

namespace NativePlugins.ApplePayPlugin
{
    public class PaymentRequestInfo
    {
        public string merchantId;
        public string countryCode;  // US
        public PaymentNetworks supportedNetworks;
        public string packageName;
        public decimal packagePrice;
        public string currencyCode;  // USD
    }

    public class PaymentForm
    {
        public string lng;
        public string lat;
        public string deviceSessionId;
        public Source source = new();
        public string packageId;
        public ThreeDSecure threeDSecure = new();
        public string idfa;
        public string idfv;
        public string adId;
    }

    public class Source
    {
        public string type;
        public string token;
    }

    public class ThreeDSecure
    {
        public bool enabled;
    }
}
