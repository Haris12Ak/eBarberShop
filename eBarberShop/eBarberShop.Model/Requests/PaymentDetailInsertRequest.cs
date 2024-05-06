namespace eBarberShop.Model.Requests
{
    public class PaymentDetailInsertRequest
    {
        public string TransactionId { get; set; }
        public string PaymentMethod { get; set; }
        public string PayerId { get; set; }
        public string PayerFirstName { get; set; }
        public string PayerLastName { get; set; }
        public string RecipientName { get; set; }
        public string RecipientAddress { get; set; }
        public string RecipientCity { get; set; }
        public string RecipientState { get; set; }
        public int RecipientPostalCode { get; set; }
        public string RecipientCountryCode { get; set; }
        public double Total { get; set; }
        public string Currency { get; set; }
        public double Subtotal { get; set; }
        public double ShippingDiscount { get; set; }
        public string Message { get; set; }
        public DateTime CreateTime { get; set; }
        public int NarudzbaId { get; set; }
    }
}
