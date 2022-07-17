import 'dart:convert';
import 'dart:ui';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:plastikat_delegate/Pages/HomePage.dart';
import 'package:plastikat_delegate/services/client_service.dart';
import 'package:plastikat_delegate/services/delegate_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/PlastikatBar.dart';
import '../Widgets/PlastikatButton.dart';
import '../Widgets/PlastikatDrawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:plastikat_delegate/globals.dart' as globals;

class EditProfile extends StatefulWidget {
  EditProfile();

  @override
  _EditProfileState createState() => _EditProfileState();
}

class  _EditProfileState extends State<EditProfile> {
  Color plastikatGreen = Color.fromRGBO(10, 110, 15, 100);
  TextEditingController? emailController ;
  TextEditingController? nameController ;
  TextEditingController? phoneNumberController;
  TextEditingController? companyController;
  TextEditingController? ratingController;
  String? name;
  String? email;
  String? phone;
  String? company;
  String? rating;
  String dropdownValue = 'Male';
  bool errorhappened=false;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    name = await globals.user.read(key: "name");
    email = await globals.user.read(key: "email");
    phone = await globals.user.read(key: "phone_number");
    company = await globals.user.read(key: "company");
    rating = await globals.user.read(key: "rating");
    emailController = TextEditingController(text: email);
    nameController = TextEditingController(text: name);
    phoneNumberController = TextEditingController(text: phone);
    companyController = TextEditingController(text: company);
    ratingController = TextEditingController(text: rating);
    setState(() {
      isLoaded = true;
    });
}

  void updateProfile() async {
    String? token = await globals.secureStorage.read(key: "access_token");
    final DelegateService service = DelegateService(token!);
    String? id = await globals.user.read(key: "id");
    final response = service.updateDelegateInformation(id!, {
      'name' : nameController!.text,
      'phone_number' : phoneNumberController!.text,
    });
    if(await response==204)
      {
        await globals.user.write(
            key: 'name', value: nameController!.text);
        await globals.user.write(
            key: 'phone_number', value: phoneNumberController!.text);
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                text: "Profile Updated Successfully!"
            )
        );
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      }
    else
      {
        setState(() {
          errorhappened = true;
        });
      }

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          drawer: PlastikatDrawer(),
          appBar: PlastikatBar(),
          body: SingleChildScrollView(
            child: isLoaded ? Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    InputWidget("Name",nameController,false,false),
                    InputWidget("Email",emailController,false,true),
                    InputWidget("Phone Number",phoneNumberController,true,false),
                    InputWidget("Company",companyController,false,true),
                    InputWidget("Rating",ratingController,false,true),
                    const SizedBox(height: 20,),
                    PlastikatButton("Update Profile", updateProfile),
                    errorhappened ? const Text("Please Enter Your Data Correctly"
                      , style: TextStyle(color: Colors.red),) : const Text("")
                  ],
                )
            ) :  const CircularProgressIndicator()
          )
      ),
    );
  }

  Widget TextWidget(String name) {
    return Text(name,
        style: TextStyle(
            color: plastikatGreen,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline));
  }

  Widget InputWidget (String label, TextEditingController? controller, bool numbers,bool readOnly)
  {

    return Container(
      height: 90,
      padding: EdgeInsets.all(20),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        cursorColor: plastikatGreen,
        keyboardType: numbers ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide:  BorderSide(width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder:OutlineInputBorder(
            borderSide:  BorderSide(color: plastikatGreen, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),

          label: Text(
              label,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500)
          ),
        ),
      ),
    );
  }

}
