import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:plastikat_delegate/Pages/EditProfile.dart';
import '../Widgets/PlastikatBar.dart';
import '../Widgets/PlastikatButton.dart';
import '../Widgets/PlastikatDrawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plastikat_delegate/globals.dart' as globals;

class ProfilePage extends StatefulWidget {

  ProfilePage();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Color plastikatGreen = Color.fromRGBO(10, 110, 15, 100);
  final String assetName = 'images/abstract-user-flat-1.svg';
  String? name;
  String? email;
  String? company;
  String? rating;
  String? phoneNumber;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData () async {
    name = await globals.user.read(key: "name");
    email = await globals.user.read(key: "email");
    phoneNumber = await globals.user.read(key: "phone_number");
    company = await globals.user.read(key: "company");
    rating = await globals.user.read(key: "rating");
    setState(() {
      isLoaded = true;
    });
  }

  void dostuff() {
    print('foo');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: PlastikatDrawer(),
        appBar: PlastikatBar(),
        body: Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: isLoaded ? Column(
              children: [
                SvgPicture.asset(
                  assetName,
                  color: plastikatGreen,
                  height: 121,
                  width: 119,
                ),
                nameWidget(name!),
                infoWidget('Email', email!,Icons.email_outlined),
                const SizedBox(height: 31),
                infoWidget('Mobile', phoneNumber!,Icons.call),
                const SizedBox(height: 31),
                infoWidget('Company', company!,Icons.apartment),
                const SizedBox(height: 31),
                infoWidget('Rating', rating!,Icons.star),
                const SizedBox(height: 31),
                PlastikatButton('Edit Profile', (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditProfile()));}),
              ],
            ): const CircularProgressIndicator()),
      ),
    );
  }

  Widget infoWidget(String field, String value, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: plastikatGreen,
            ),
            const SizedBox(width: 10),
            Text(
              field,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w200),
            )
          ],
        ),
        Text(
          value,
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w200),
        ),
      ],
    );
  }

  Widget nameWidget(String name) {
    return Padding(
        padding: EdgeInsets.all(35),
        child: Text(name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500)));
  }
}
