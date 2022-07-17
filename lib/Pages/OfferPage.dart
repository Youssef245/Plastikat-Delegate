import 'dart:ui';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:plastikat_delegate/Pages/HomePage.dart';
import 'package:plastikat_delegate/services/delegate_service.dart';
import '../Widgets/PlastikatBar.dart';
import '../Widgets/PlastikatButton.dart';
import '../Widgets/PlastikatDrawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plastikat_delegate/globals.dart' as globals;

import '../services/offer_service.dart';

class OfferPage extends StatelessWidget {
  Color plastikatGreen = Color.fromRGBO(10, 110, 15, 100);
  final String assetName = 'images/569509_main (1).jpg';
  var types =  ['Small Bottle','Small Bottle','Small Bottle','Small Bottle','Small Bottle','Small Bottle','Small Bottle','Small Bottle','Small Bottle'
    ,'Small Bottle','Small Bottle','Small Bottle','Small Bottle'];
  String bullet = '\u2022 ';
  final DelegateOffer offer;

  OfferPage(this.offer);

  void dostuff() {
    print('foo');
  }

  operationOffer(String offerID,String operation) async {
    String? accessToken = await globals.secureStorage.read(key: "access_token");
    final OfferService service = OfferService (accessToken!);
    final response = await service.operationOffer(operation,offerID);
    print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: PlastikatDrawer(),
        appBar: PlastikatBar(),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(top: 40),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    OfferFullInformation(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PlastikatButton('Accept Offer', () async {
                          final response = operationOffer(offer.id, 'ACCEPT_OFFER');
                          if(await response==200)
                          {
                            ArtSweetAlert.show(
                                context: context,
                                artDialogArgs: ArtDialogArgs(
                                    type: ArtSweetAlertType.success,
                                    text: "Offer Accepted Successfully!"
                                )
                            );
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
                          }
                        },144,50,'green'),
                        PlastikatButton('Reject Offer', () async {
                          final response = operationOffer(offer.id, 'CANCEL_OFFER');
                          if(await response==204)
                          {
                            ArtSweetAlert.show(
                                context: context,
                                artDialogArgs: ArtDialogArgs(
                                    type: ArtSweetAlertType.danger,
                                    text: "Offer Rejected Successfully!"
                                )
                            );
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
                          }
                        },144,50,'red')
                      ],
                    ),
                    const SizedBox(height: 31),
                  ],
                ))),
      ),
    );
  }

  Widget OfferItem(String field, String value,double size,MainAxisAlignment alignment, IconData icon) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Icon(
          icon,
          color: plastikatGreen,
          size: size,
        ),
        const SizedBox(width: 10,),
        Flexible(
          child: Text(
            field + ': ' + value,
            style: TextStyle(
                color: Colors.black,
                fontSize: size,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }

  Widget OfferFullInformation()
  {
    return Container(
      padding: EdgeInsets.only(left: 30),
      child: Column(
        children: [
          OfferItem('Client', offer.client!.name ,20,MainAxisAlignment.start,Icons.apartment),
          const SizedBox(height: 10),
          OfferItem('Address', offer.client.address ,20,MainAxisAlignment.start,Icons.person),
          const SizedBox(height: 10),
          OfferItem('Points', '${offer.points.toString()} point',20,MainAxisAlignment.start,Icons.wallet_giftcard),
          const SizedBox(height: 10),
          OfferItem('Status', getStatus(offer.status) ,20,MainAxisAlignment.start,Icons.apartment),
          const SizedBox(height: 10),
          Column(
            children: [
              ...offer.items.map((item) {
                return Column(
                  children: [
                    OfferItem('Name', item.name,16,MainAxisAlignment.center,Icons.drive_file_rename_outline),
                    const SizedBox(width: 10,),
                    OfferItem('Type', item.type,16,MainAxisAlignment.center,Icons.vignette_sharp),
                    const SizedBox(width: 10,),
                    OfferItem('Quantity', item.quantity.toString(),16,MainAxisAlignment.center,Icons.numbers),
                    Divider(
                      color: plastikatGreen,
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,)
                  ],
                );
              }).toList()
            ],
          )
        ],
      ),
    );
  }

  String getStatus (String status)
  {
    if(status=="COMPLETED")   return "Collected";
    else if(status=="DELEGATE_ASSIGNED") return "Assigned";
    else return "Rejected";

  }

}