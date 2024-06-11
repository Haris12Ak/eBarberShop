using eBarberShop.Model.Settings;
using Microsoft.Extensions.Options;
using System.Net;
using System.Net.Mail;

namespace eBarberShop.MailingService
{
    public class EmailSender : IEmailSender
    {
        private readonly EmailSettings _emailSettings;

        public EmailSender(IOptions<EmailSettings> emailSettings)
        {
            _emailSettings = emailSettings.Value;
        }

        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient("smtp.office365.com", 587)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(_emailSettings.OUTLOOK_MAIL, _emailSettings.OUTLOOK_PASS)
            };

            return client.SendMailAsync(
                new MailMessage(from: _emailSettings.OUTLOOK_MAIL,
                                to: email,
                                subject,
                                message
                                ));
        }
    }
}
