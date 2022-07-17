// import '../entities/common/device_token.dart';

// import '../entities/client.dart';
import 'client_service.dart';
import 'delegate_service.dart';
import 'exchange_service.dart';
import 'offer_service.dart';

const accessToken =
    "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ijg3UW5TT1ZjVGVzbXB0XzRFZjZBNiJ9.eyJpc3MiOiJodHRwczovL3BsYXN0aWthdC5ldS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMTE2NjkwODQ0NDg1NzI2NjA1OTkiLCJhdWQiOlsicGxhc3Rpa2F0LWFwcC1hcGkiLCJodHRwczovL3BsYXN0aWthdC5ldS5hdXRoMC5jb20vdXNlcmluZm8iXSwiaWF0IjoxNjU3NTU1OTQ3LCJleHAiOjE2NTc2NDIzNDcsImF6cCI6InMwSDlxU2FXRFpvalhFUDViblc4SWRiN2k4WURnajdoIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSIsInBlcm1pc3Npb25zIjpbXX0.p8i4N6GHnDl1nqJwnR2EPHfE7gBgWdCqyeLPvI8_D_XcW-RdpxYBhSPB30D9r0wf7e6LoX_zgnPhQCw79x8Xpwu0D-0FY__3OJdbMgTdqP9Fjrk9wS6ayIgibG99ZNb8q0LGGwGSLUu1OD-WaE-YAw8wILSNmmFLDRzPIsiSdYMKfHQ0g5aBly7bBbdyy3-7oxPUlB_VDeN7eHULLSVjwuTJYHslmMMZHnJ9XkySECOs9amMwk9Ko9TAMWZnTIsToeJ87yQO0mkQxmf9cLBQ57mbCCRXH6wthzbxaLXsL-xBKZn4D7SU2X1Wdpgzt-GvoT4BBUlTU7XZSCYWkV3wAA";

const accessToken2 =
    "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ijg3UW5TT1ZjVGVzbXB0XzRFZjZBNiJ9.eyJpc3MiOiJodHRwczovL3BsYXN0aWthdC5ldS5hdXRoMC5jb20vIiwic3ViIjoiYXV0aDB8NjJjODhlN2Y3YjEyMzAzNTgzZWVkZjVlIiwiYXVkIjpbInBsYXN0aWthdC1hcHAtYXBpIiwiaHR0cHM6Ly9wbGFzdGlrYXQuZXUuYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTY1NzU2MjcyMCwiZXhwIjoxNjU3NjQ5MTIwLCJhenAiOiJ5Tml5SFpDd1M0cUpRTTZua2g2Vms1N3R2YjFkUENZZSIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJwZXJtaXNzaW9ucyI6W119.XNU946FUYfctETOLtv8DKbqIi-WV0dT61PItvGQZW2koOU_KH-IfxqUtK9nN0pyFAe5khPzoGSou1yuv2qGJVH3i0DfjyeZi0wY5uZSpsSWnF0W2RSJZGzSz_34cbQfoOQEsnYe_wCn1LlB9Aj9RQCQe-onJhuKV2HvSaTDrNWz4VDFMO-8wmb_h97Xc98OIF7U-yLA_ndFwVzs9IUWwYeKxnqZV0BSltVdlSubMnohBoTGP60Dxy47sN5NuyuQb2WASZolYxmFznHMiW8kk_A8dJBRyIwtd77woly5Vhz1cD9laF1Yvrm_LMJpEWHFSS2qFWuinSbmoXQIvT92ovA";

void main() async {
  try {
    // const clientService = ClientService(accessToken);

    // await clientService.updateClientTokens("google-oauth2|111669084448572660599",
    //     DeviceToken("123", "android", DateTime.now().toString()));

    // final client = await clientService
    //     .getClientInformation("google-oauth2|111669084448572660599");

    // clientService.updateClient("google-oauth2|111669084448572660599", {
    //   "name": "Omar Abdelaziz",
    //   "address": {
    //     "street": "123 Main St",
    //     "city": "New York",
    //     "state": "NY",
    //     "zip": "10001"
    //   },
    //   "location": {
    //     "type": "Point",
    //     "coordinates": [-74.0060, 40.7128]
    //   },
    //   "phone_number": "123456789"
    // });

    // final exchanges = await clientService
    //     .getClientExchanges("google-oauth2|111669084448572660599");

    // exchanges.forEach((element) {
    //   print(element.toJson());
    // });

    // const delegateService = DelegateService(accessToken2);
    // final delegate = await delegateService.getDelegateInformation("auth0|62c88e7f7b12303583eedf5e");
    // print(delegate.toJson());

    // await delegateService
    //     .updateDelegateInformation("auth0|62c88e7f7b12303583eedf5e", {
    //   "name": "Hello World",
    // });

    // const exchangeService = ExchangeService(accessToken);

    // await exchangeService.exchangeReward({
    //   "client": "google-oauth2|111669084448572660599",
    //   "partner": "6285496d5af64f773e9012cc",
    //   "reward": "6285496d5af64f773e9012c9"
    // });

    // Initiate Offer
    const offerService = OfferService(accessToken);

    final response = await offerService.initiateOffer({
      "client": "auth0|62c6e14b1a255fd179a65e22",
      "points": 414,
      "items": [
        {"item_id": "6285496d5af64f773e90126f", "quantity": 1},
        {"item_id": "6285496d5af64f773e90127f", "quantity": 1},
        {"item_id": "6285496d5af64f773e901271", "quantity": 1}
      ]
    });
  } catch (error) {
    print(error);
  }
}
