import 'package:flutter/material.dart';

class Customformfield extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  final bool obscureText;  // إضافة متغير للتحكم في إخفاء النص

  const Customformfield({
    super.key,
    required this.mycontroller,
    required this.validator,
    required this.hinttext,
    required this.obscureText, // إضافة متغير للتحكم في إخفاء النص
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: mycontroller,
      obscureText: obscureText, // استخدام المتغير للتحكم في إخفاء النص
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(fontSize: 14, color: Colors.black),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        filled: true,
        fillColor: Colors.grey[400],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: const Color.fromARGB(255, 151, 151, 151)),
        ),
        enabledBorder: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: const Color.fromARGB(255, 174, 174, 174)),
        ),
        suffixIcon: obscureText
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                  
                ),
                onPressed: () {
                  // يمكنك إضافة الكود للتحكم في تغيير الحالة إذا أردت
                },
              )
            : null,
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme),
      
    );
  }
}
