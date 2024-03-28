namespace eBarberShop.Services.Helper
{
    public static class NumberGenerator
    {
        public static string GenerateNumber()
        {
            Random generator = new Random();
            String r = generator.Next(0, 1000000).ToString("D6");
            string OrderNumber = String.Format("{0}-{1}{2}-{3}", "ORD", DateTime.Now.Year, DateTime.Now.Month.ToString("D2"), r);
            return OrderNumber;
        }
    }
}
