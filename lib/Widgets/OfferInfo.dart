import 'dart:ui';

import 'package:flutter/material.dart';
import '../Pages/OfferInformationPage.dart';
import '../Pages/OfferPage.dart';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plastikat_delegate/services/delegate_service.dart';
import '../Pages/OfferInformationPage.dart';
import '../Pages/OfferPage.dart';

class OfferInfo extends StatelessWidget {
  static const Color plastikatGreen = Color.fromRGBO(10, 110, 15, 100);
  final DelegateOffer offer;
  final BuildContext context;
  String bullet = '\u2022 ';

  OfferInfo(this.offer,this.context);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /* Image.asset(
          assetName,
          height: 135,
          width: 122,
        ),*/
        Flexible( child : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            listItem('Points', offer.points.toString()),
            listItem('Client', offer.client!.name),
            listItem('Address', offer.client!.address),
            listItem('Status', getStatus(offer.status)),
            TextButton(
              child: const Text('View Full Information',
                style: TextStyle(
                    color: plastikatGreen,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w200,
                    decoration: TextDecoration.underline),
              ),
              onPressed: (){
                Navigator.of(this.context).push(MaterialPageRoute(
                        builder: (context) => OfferInformationPage(offer)));
            },
            ),
          ],
        ))
      ],
    );
  }

  Widget listItem(String field, String value) {
    return Text(
      bullet + ' ' + field + ': ' + value,
      style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w200),
    );
  }
  String getStatus (String status)
  {
    if(status=="COMPLETED")   return "Collected";
    else if(status=="DELEGATE_ASSIGNED") return "Assigned";
    else return "Rejected";

  }
}

