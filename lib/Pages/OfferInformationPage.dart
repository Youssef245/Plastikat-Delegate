import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../Widgets/PlastikatBar.dart';
import '../Widgets/PlastikatButton.dart';
import '../Widgets/PlastikatDrawer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/delegate_service.dart';

class OfferInformationPage extends StatelessWidget {
  Color plastikatGreen = Color.fromRGBO(10, 110, 15, 100);
  final String assetName = 'images/569509_main (1).jpg';
  var types =  ['Small Bottle','Small Bottle','Small Bottle','Small Bottle','Small Bottle','Small Bottle','Small Bottle','Small Bottle','Small Bottle'
    ,'Small Bottle','Small Bottle','Small Bottle','Small Bottle'];
  String bullet = '\u2022 ';
  final DelegateOffer offer;

  OfferInformationPage(this.offer);

  void dostuff() {
    print('foo');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: PlastikatDrawer(),
        appBar: PlastikatBar(),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(top: 40),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    /*Image.asset(
                      assetName,
                      height: 105,
                      width: 164,
                    ),*/
                    //const SizedBox(height: 10),
                    OfferFullInformation(),
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