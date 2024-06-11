using EasyNetQ;
using eBarberShop.Model.Settings;
using eBarberShop.Services.Interfejsi;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using RabbitMQ.Client;
using System.Text;

namespace eBarberShop.Services.Servisi
{
    public class MessageProducer : IMessageProducer
    {
        private readonly RabbitMQSettings _rabbitMQSettings;

        public MessageProducer(IConfiguration configuration, IOptions<RabbitMQSettings> rabbitMQSettings)
        {
            _rabbitMQSettings = rabbitMQSettings.Value;
        }

        public void SendingMessage(string message)
        {
            try
            {
                var factory = new ConnectionFactory
                {
                    HostName = _rabbitMQSettings.RABBITMQ_HOST,
                    UserName = _rabbitMQSettings.RABBITMQ_USERNAME,
                    Password = _rabbitMQSettings.RABBITMQ_PASSWORD,
                    VirtualHost = _rabbitMQSettings.RABBITMQ_VIRTUALHOST,
                };

                using var connection = factory.CreateConnection();
                using var channel = connection.CreateModel();

                channel.QueueDeclare(queue: "reservation_added",
                                     durable: false,
                                     exclusive: false,
                                     autoDelete: false,
                                     arguments: null);

                var body = Encoding.UTF8.GetBytes(message);

                channel.BasicPublish(exchange: string.Empty,
                                     routingKey: "reservation_added",
                                     basicProperties: null,
                                     body: body);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred while sending message to RabbitMQ: {ex.Message}");

            }
        }

        public void SendingObject<T>(T obj)
        {
            var host = _rabbitMQSettings.RABBITMQ_HOST;
            var username = _rabbitMQSettings.RABBITMQ_USERNAME;
            var password = _rabbitMQSettings.RABBITMQ_PASSWORD;
            var virtualhost = _rabbitMQSettings.RABBITMQ_VIRTUALHOST;

            using var bus = RabbitHutch.CreateBus($"host={host};virtualHost={virtualhost};username={username};password={password}");

            bus.PubSub.Publish(obj);
        }
    }
}
