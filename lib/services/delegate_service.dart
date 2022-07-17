import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../entities/client.dart';
import '../entities/common/device_token.dart';
import '../entities/offer.dart';
import '../entities/delegate.dart';
import '../utils/api.dart';
import '../utils/status_codes.dart';

class DelegateService {
  final String authToken;

  const DelegateService(this.authToken);

  // GET /:id
  Future<Delegate> getDelegateInformation(String delegateId) async {
    final response = await http.get(Uri.parse(delegateByIdUrl(delegateId)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        });

    if (response.statusCode == ok) {
      final payload = jsonDecode(response.body);

      return Delegate.fromJson(payload['data'] as Map<String, dynamic>);
    } else {
      throw Exception('Failed to fetch delegate information');
    }
  }

  // GET /:id/offers
  Future<List<DelegateOffer>> getDelegateOffers(String delegateId) async {
    final response = await http.get(Uri.parse(delegateOffersUrl(delegateId)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        });
    if (response.statusCode == ok) {
      final payload = jsonDecode(response.body);
      return (payload['data'] as List)
          .map((item) => DelegateOffer.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to fetch delegate offers');
    }
  }

  // PATCH /:id
  Future<int> updateDelegateInformation(String delegateId, Map<String, dynamic> payload) async {
    final response = await http.patch(Uri.parse(delegateByIdUrl(delegateId)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(payload));

    switch (response.statusCode) {
      case noContent:
        log('Delegate information updated');
        break;
      case unauthorized:
        throw Exception('Unauthorized');
      case badRequest:
        throw Exception('Bad request');
      case internalServerError:
        throw Exception('Internal server error');
      default:
        throw Exception('Unknown error');
    }
    return response.statusCode;
  }

  Future<void> updateDelegateTokens(String clientId, DeviceToken token) async {
    final response = await http.patch(Uri.parse(delegateTokensUrl(clientId)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode({
          'token': token.token,
          'platform': token.platform,
          'created_at': token.createdAt,
        }));

    switch (response.statusCode) {
      case noContent:
        log('Delegate tokens updated successfully');
        break;
      case unauthorized:
        throw Exception('Unauthorized Error');
      case badRequest:
        throw Exception('Failed to update client tokens');
      case internalServerError:
        throw Exception('Internal Server Error');
    }
  }

}

class DelegateOffer {
  final String id;
  final Client client;
  final List<ItemOffer> items;
  final String status;
  final int points;

  const DelegateOffer(this.id, this.client, this.items, this.status,this.points);

  factory DelegateOffer.fromJson(Map<String, dynamic> json) {
    return DelegateOffer(
        json['_id'] as String,
        Client.fromJson(json['client'] as Map<String, dynamic>),
        (json['items'] as List)
            .map((item) => ItemOffer.fromJson(item as Map<String, dynamic>))
            .toList(),
        json['status'] as String,
        json['points'] as int);
  }
}
