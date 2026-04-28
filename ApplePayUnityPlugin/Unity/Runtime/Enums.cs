using System;

namespace NativePlugins.ApplePayPlugin
{
    /// <summary>
    /// Payment networks supported by Apple Pay
    /// </summary>
    [Flags]
    public enum PaymentNetworks : long
    {
        None = 0,
        Amex = 1L << 0,
        // PagoBancomat = 1L << 1,
        // Bancontact = 1L << 2,
        CartesBancaires = 1L << 3,
        ChinaUnionPay = 1L << 4,
        // Dankort = 1L << 5,
        Discover = 1L << 6,
        Eftpos = 1L << 7,
        Electron = 1L << 8,
        // Elo = 1L << 9,
        IdCredit = 1L << 10,
        Interac = 1L << 11,
        JCB = 1L << 12,
        // Mada = 1L << 13,
        Maestro = 1L << 14,
        MasterCard = 1L << 15,
        // Mir = 1L << 16,
        PrivateLabel = 1L << 17,
        QuicPay = 1L << 18,
        Suica = 1L << 19,
        Visa = 1L << 20,
        VPay = 1L << 21,
        // Barcode = 1L << 22,
        // Girocard = 1L << 23,
        // Waon = 1L << 24,
        // Nanaco = 1L << 25,
        // PostFinance = 1L << 26,
        // Tmoney = 1L << 27,
        // Meeza = 1L << 28,
        // NAPAS = 1L << 29,
        // BankAxept = 1L << 30,
        // Himyan = 1L << 31,
        // Jaywan = 1L << 32,
        // MyDebit = 1L << 33,
    }

    public enum AuthorizeErrorCode
    {
        UserCancelled = 0,

        FailedToPresent = 1000,

        Unknown = 4000,
    }

}
