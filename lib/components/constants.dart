import 'package:flutter/material.dart';



 Color themecolor = Colors.grey.shade400;
const Color fontsDark = Color.fromRGBO(12, 10, 34, 1);

const fontSize20 = TextStyle(
    fontSize: 20
);


const fontSizebold =TextStyle(fontWeight: FontWeight.bold);


class ButtonRound extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback ontap;
  const ButtonRound({Key? key, required this.text, required this.ontap, this.loading= false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
        ),
        child: Center(child: loading? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,):Text( text, style: TextStyle(fontSize: 25, color: Colors.white),)),
      ),
    );
  }
}