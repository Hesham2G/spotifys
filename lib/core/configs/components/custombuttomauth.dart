// ignore_for_file: non_constant_identifier_names, use_super_parameters

import 'package:flutter/material.dart';
class CustomButtonAuth extends StatelessWidget {
  final void Function()? onPressed ;
  final String Title ;
  const CustomButtonAuth({Key? key, this.onPressed, required this.Title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(10),
              
            ),

            
            height: 50,
                  color: const Color.fromARGB(255, 27, 16, 0),
                  textColor: Colors.white,
                  onPressed: onPressed,
                  child:  Text(Title),);
  }
}