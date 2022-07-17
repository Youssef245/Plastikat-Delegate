import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../utils/status_codes.dart';
import '../utils/api.dart';

class OfferService {
  final String authToken;

  const OfferService(this.authToken);

  // POST /
  Future<void> initiateOffer(Map<String, dynamic> payload) async {
    final response = await http.post(Uri.parse(offersUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(payload));

    switch (response.statusCode) {
      case created:
        log('Offer created');
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
  }

  // PATCH /:id
  Future<int> operationOffer(String operation,String offerID) async {
    final response = await http.patch(Uri.parse(operationOfferUrl(offerID)), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken'
    }, body: jsonEncode({
      'operation_type' : operation,
      'offer_id' : offerID
    }));
    print(response.statusCode);
    /*switch (response.statusCode) {
      case ok:
        break;
      case unauthorized:
        throw Exception('Unauthorized');
      case badRequest:
        throw Exception('Bad request');
      case internalServerError:
        throw Exception('Internal server error');
      default:
        throw Exception('Unknown error');
    }*/
    return response.statusCode;
  }
}