import PassKit

public struct PaymentRequestInfo: Codable {
    public let merchantId: String
    public let countryCode: String  // US
    public let supportedNetworks: Int64 // Bitmask
    public let packageName: String
    public let packagePrice: Decimal
    public let currencyCode: String  // USD
}
