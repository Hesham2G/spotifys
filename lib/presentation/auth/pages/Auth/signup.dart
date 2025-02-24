// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_super_parameters, use_build_context_synchronously, avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotifys/common/widgets/button/basic_app_button.dart';
import 'package:spotifys/core/configs/components/is_loading.dart';
import 'package:spotifys/presentation/auth/pages/Auth/login.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../core/configs/assets/app_vectors.dart';
import '../../../../core/configs/components/custombuttomauth.dart';
import '../../../../core/configs/components/textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Username",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Customformfield(
                    hinttext: "Enter your username",
                    mycontroller: username,
                    validator: (val) {
                      if (val == "") {
                        return "You can't let it empty";
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Customformfield(
                    hinttext: "Enter Your Email",
                    mycontroller: Email,
                    validator: (val) {
                      if (val == "") {
                        return "You can't let it empty";
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Customformfield(
                    hinttext: "Enter Your Password",
                    mycontroller: Password,
                    validator: (val) {
                      if (val == "") {
                        return "You can't let it empty";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BasicAppButton(
              title: "SignUp",
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  showLoading(context, () async {
                    try {
                      final credential =
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: Email.text,
                        password: Password.text,
                      );

                      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    } on FirebaseAuthException catch (e) {
                      Navigator.pop(context); // إغلاق صفحة التحميل عند حدوث خطأ

                      String errorMessage = "An error occurred";
                      if (e.code == 'weak-password') {
                        errorMessage = 'The password provided is too weak.';
                      } else if (e.code == 'email-already-in-use') {
                        errorMessage = 'The account already exists for that email.';
                      }

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: errorMessage,
                      ).show();
                    } catch (e) {
                      Navigator.pop(context); // إغلاق صفحة التحميل عند حدوث خطأ
                      print(e);
                    }
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: "Have an account?"),
                  TextSpan(
                      text: " login",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}