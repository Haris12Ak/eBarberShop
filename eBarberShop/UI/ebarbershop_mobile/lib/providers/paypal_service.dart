import 'dart:convert';

import 'package:http/http.dart' as http;

class PaypalServices {
  final String clientId, secretKey;
  final bool sandboxMode;

  PaypalServices({
    required this.clientId,
    required this.secretKey,
    required this.sandboxMode,
  });

  getAccessToken() async {
    String baseUrl = sandboxMode
        ? "https://api-m.sandbox.paypal.com"
        : "https://api.paypal.com";

    try {
      var authToken = base64.encode(
        utf8.encode("$clientId:$secretKey"),
      );
      final response = await http.post(
        Uri.parse('$baseUrl/v1/oauth2/token?grant_type=client_credentials'),
        headers: {
          'Authorization': 'Basic $authToken',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final body = jsonDecode(response.body);
      return {
        'error': false,
        'message': "Success",
        'token': body["access_token"]
      };
    } on Exception {
      return {
        'error': true,
        'message': "Your PayPal credentials seems incorrect"
      };
    } catch (e) {
      return {
        'error': true,
        'message': "Unable to proceed, check your internet connection."
      };
    }
  }

  Future<Map> createPaypalPayment(
    transactions,
    accessToken,
  ) async {
    String domain = sandboxMode
        ? "https://api.sandbox.paypal.com"
        : "https://api.paypal.com";

    try {
      final response = await http.post(
        Uri.parse('$domain/v1/payments/payment'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(transactions),
      );

      final body = jsonDecode(response.body);
      if (body["links"] != null && body["links"].length > 0) {
        List links = body["links"];

        String executeUrl = "";
        String approvalUrl = "";
        final item = links.firstWhere((o) => o["rel"] == "approval_url",
            orElse: () => null);
        if (item != null) {
          approvalUrl = item["href"];
        }
        final item1 =
            links.firstWhere((o) => o["rel"] == "execute", orElse: () => null);
        if (item1 != null) {
          executeUrl = item1["href"];
        }
        return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
      }
      return {};
    } on Exception catch (e) {
      return {
        'error': true,
        'message': "Payment Failed.",
        'data': e.toString(),
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<Map> executePayment(
    url,
    payerId,
    accessToken,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"payer_id": payerId}),
      );

      final body = jsonDecode(response.body);
      return {'error': false, 'message': "Success", 'data': body};
    } on Exception catch (e) {
      return {
        'error': true,
        'message': "Payment Failed.",
        'data': e.toString(),
      };
    } catch (e) {
      return {'error': true, 'message': e, 'exception': true, 'data': null};
    }
  }
}