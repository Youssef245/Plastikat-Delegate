import 'package:flutter/material.dart';

class PlastikatButton extends StatelessWidget {
  final Color plastikatGreen = Color.fromRGBO(10, 110, 15, 100);
  final String buttonText;
  double width;
  double height;
  String color;
  final VoidCallback onclicked;

  PlastikatButton(this.buttonText, this.onclicked,[this.width=144,this.height=50,this.color='green']);

  Color buttonColor ()
  {
    if(this.color == 'green')
      return plastikatGreen;
    else
      return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onclicked,
      child: Text(
        buttonText,
        style:
            TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Poppins'),
      ),
      style: ElevatedButton.styleFrom(
          primary: buttonColor(),
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          )),
    );
  }
}
