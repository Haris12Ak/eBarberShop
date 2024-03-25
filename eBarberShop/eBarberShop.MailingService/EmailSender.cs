using System.Net;
using System.Net.Mail;

namespace eBarberShop.MailingService
{
    public class EmailSender : IEmailSender
    {
        private readonly string _outlookMail = Environment.GetEnvironmentVariable("OUTLOOK_MAIL") ?? "ebarber_shop@outlook.com";
        private readonly string _outlookPass = Environment.GetEnvironmentVariable("OUTLOOK_PASS") ?? "ebarbershop_rs2";

        public EmailSender()
        {
        }

        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient("smtp.office365.com", 587)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(_outlookMail, _outlookPass)
            };

            return client.SendMailAsync(
                new MailMessage(from: _outlookMail,
                                to: email,
                                subject,
                                message
                                ));
        }
    }
}
