
using EasyNetQ;
using eBarberShop.Model;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;

namespace eBarberShop.MailingService
{
    public class ConsumeRabbitMQHostedService : BackgroundService
    {
        private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost";
        private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
        private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
        private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

        private readonly ILogger _logger;
        private IConnection _connection;
        private IModel _channel;
        private readonly IEmailSender _emailSender;

        public ConsumeRabbitMQHostedService(ILoggerFactory loggerFactory, IEmailSender emailSender)
        {
            _logger = loggerFactory.CreateLogger<ConsumeRabbitMQHostedService>();
            _emailSender = emailSender;
            InitRabbitMQ();
        }

        private void InitRabbitMQ()
        {
            var factory = new ConnectionFactory
            {
                HostName = _host,
                UserName = _username,
                Password = _password,
                VirtualHost = _virtualhost
            };

            _connection = factory.CreateConnection();
            _channel = _connection.CreateModel();

            //_channel.ExchangeDeclare("demo.exchange", ExchangeType.Topic);
            _channel.QueueDeclare("reservation_added", false, false, false, null);

            //_channel.QueueBind("demo.queue.log", "demo.exchange", "demo.queue.*", null);
            _channel.BasicQos(0, 1, false);

            _connection.ConnectionShutdown += RabbitMQ_ConnectionShutdown;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    using (var bus = RabbitHutch.CreateBus($"host={_host};virtualHost={_virtualhost};username={_username};password={_password}"))
                    {
                        bus.PubSub.Subscribe<ReservationNotifier>("New_Reservations", HandleMessage);
                        Console.WriteLine("Listening for reservations.");
                        await Task.Delay(TimeSpan.FromSeconds(7), stoppingToken);
                    }


                }
                catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
                {
                    // Gracefully handle cancellation
                    break;
                }
                catch (Exception ex)
                {
                    // Handle exceptions
                    Console.WriteLine($"Error in RabbitMQ listener: {ex.Message}");
                }
            }

        }

        private async Task HandleMessage(ReservationNotifier reservation)
        {
            _logger.LogInformation($"Reservation received: {reservation.Id}, {reservation.UposlenikIme}, {reservation.UposlenikPrezime}");
            await _emailSender.SendEmailAsync(reservation.Email, "Uspješno ste rezervisali svoj termin koristeći eBarberShop!",
                $"Poštovani/a {reservation.KorisnikIme}, " +
                $"\n\nVaša rezervacija je uspješno potvrđena! " +
                $"\n\nDetalji rezervacije: " +
                $"\nDatum: {reservation.Datum.ToShortDateString()} " +
                $"\nVrijeme: {reservation.Vrijeme.ToShortTimeString()} " +
                $"\nUsluga: {reservation.UslugaNaziv} " +
                $"\nBarber: {reservation.UposlenikIme} {reservation.UposlenikPrezime} " +
                $"\nCijena: {reservation.CijenaUsluge} KM " +
                $"\n\nMolimo Vas dođite na vrijeme na vaš termin. Ako se desi da ne možete doći, molimo vas da nas obavijestite što prije ili otkažete svoj termin." +
                $"\n\nHvala vam na povjerenju i radujemo se što ćemo vam pružiti izvrsno iskustvo u našem salonu!");
        }

        private void OnConsumerConsumerCancelled(object sender, ConsumerEventArgs e) { }
        private void OnConsumerUnregistered(object sender, ConsumerEventArgs e) { }
        private void OnConsumerRegistered(object sender, ConsumerEventArgs e) { }
        private void OnConsumerShutdown(object sender, ShutdownEventArgs e) { }
        private void RabbitMQ_ConnectionShutdown(object? sender, ShutdownEventArgs e) { }

        public override void Dispose()
        {
            _channel.Close();
            _connection.Close();
            base.Dispose();
        }
    }
}
