import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:location/location.dart';
import 'package:plastikat_delegate/services/delegate_service.dart';
import '../Pages/AssignedPage.dart';
import '../Pages/HistoryPage.dart';
import '../Widgets/PlastikatBar.dart';
import '../Widgets/PlastikatButton.dart';
import '../Widgets/PlastikatDrawer.dart';
import 'package:plastikat_delegate/globals.dart' as globals;

class HomePage extends StatefulWidget {

  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color plastikatGreen = Color.fromRGBO(10, 110, 15, 100);

  String? name;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData () async
  {
    sendLocation();
    name = await globals.user.read(key: "name");
    setState(() {
      isLoaded = true;
    });
  }
  sendLocation () async
  {
    Location location =  Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissiongranted;
    LocationData? _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }
    _permissiongranted = await location.hasPermission();
    if (_permissiongranted == PermissionStatus.denied) {
      _permissiongranted = await location.requestPermission();
      if (_permissiongranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    String? token = await globals.secureStorage.read(key: "access_token");
    String? id = await globals.user.read(key: "id");
    final DelegateService service = DelegateService(token!);
    service.updateDelegateInformation(id!, {
      'location' : {
        "type" : "point",
        "coordinates" : [_locationData.longitude , _locationData.latitude]
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          drawer: PlastikatDrawer(),
          appBar: PlastikatBar(),
          body: isLoaded ? Container(
            padding: const EdgeInsets.symmetric(vertical: 80),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Welcome, ${name!.split(" ")[0]}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    'images/logo1.png',
                  ),
                  PlastikatButton("Assigned Offers", (){
                    Navigator.of(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AssignedPage()));},280),
                  const SizedBox(height: 20,),
                  PlastikatButton("View History", (){
                    Navigator.of(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HistoryPage()));},280)

                ],
              ),
            ),
          ): const CircularProgressIndicator()),
    );
  }
}
