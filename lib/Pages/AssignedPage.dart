import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../Pages/OfferPage.dart';
import '../Widgets/PlastikatButton.dart';
import '../Widgets/OfferInfo.dart';
import '../Widgets/PlastikatBar.dart';
import '../Widgets/PlastikatDrawer.dart';
import '../services/delegate_service.dart';
import 'package:plastikat_delegate/globals.dart' as globals;

class AssignedPage extends StatefulWidget {
  @override
  State<AssignedPage> createState() => _AssignedPageState();
}

class _AssignedPageState extends State<AssignedPage> {
  Color plastikatGreen = Color.fromRGBO(10, 110, 15, 100);

  List<DelegateOffer> assigned = [];
  bool isLoaded=false;
  int? i;


  @override
  void initState() {
    super.initState();
    getOffers();
  }

  getOffers() async {
    String? token = await globals.secureStorage.read(key: "access_token");
    final DelegateService service =  DelegateService(token!);
    String? id = await globals.user.read(key: "id");
    List<DelegateOffer> offers = await service.getDelegateOffers(id!);
    for (DelegateOffer offer in offers)
    {
      if(offer.status=="DELEGATE_ASSIGNED") {
        assigned.add(offer);
      }
    }
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    i=0;
    return MaterialApp(
      home: Scaffold(
          drawer: PlastikatDrawer(),
          appBar: PlastikatBar(),
          body: isLoaded? SingleChildScrollView(
            padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  ...assigned.map((offer) {
                    i = i!+1;
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Offer No. ${i}",
                            style: TextStyle(
                              color: plastikatGreen,
                              fontSize: 30,
                              fontFamily: 'comfortaa',
                              fontWeight: FontWeight.bold,
                            ),),
                          const SizedBox(height: 20,),
                          OfferInfo(offer,context),
                          PlastikatButton('Go To Offer', ()=> Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OfferPage(offer)))
                                 ,70,30),
                          Divider(
                            color: plastikatGreen,
                            thickness: 1,
                            indent: 30,
                            endIndent: 30,),
                        ],
                      ),
                    );
                  }).toList()
                ],
              )): const CircularProgressIndicator()),
    );
  }
}
