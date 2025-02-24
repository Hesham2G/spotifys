// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:spotifys/common/widgets/appbar/app_bar.dart';
import 'package:spotifys/common/widgets/button/basic_app_button.dart';
import 'package:spotifys/core/configs/assets/app_vectors.dart';
import 'package:spotifys/core/configs/components/is_loading.dart';
import 'package:spotifys/presentation/auth/pages/Auth/signup.dart';

import '../../../../core/configs/components/square_tile.dart';
import '../../../../core/configs/components/textformfield.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../../../home/pages/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;

  Future signInWithGoogle() async {
   isLoading=true;
    
    // Trigger the authentication flow
    
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    isLoading=false;
    if (googleUser == null) {
      return;
    
    }
  

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    
    );
    
    
  
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    showLoading(context, () async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ),
    );
    });
    
  }

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
      
      body: isLoading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                LottieBuilder.asset("lib/Lottie/spotify.json"),
                
              ],
            ))
          : Container(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const SizedBox(height: 20),
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Login to Continue Using the App",
                          style: TextStyle(
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Customformfield(
                          hinttext: "Enter your email",
                          mycontroller: Email,
                          validator: (val) {
                            if (val == "") {
                              return "You can't let it empty ";
                            }
                            return null;
                          },
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Customformfield(
                          hinttext: "Enter your password",
                          mycontroller: Password,
                          obscureText: true,
                          validator: (val) {
                            if (val == "") {
                              return "You can't let it empty";
                            }
                            return null;
                          },
                        ),
                        InkWell(
                          onTap: () async {
                            if (Email.text == "") {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'Warning',
                                desc:
                                    'Please you should apply your email to send a new password to your email.',
                              ).show();
                              return;
                            }
                            ;
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: Email.text);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Reset your password',
                                desc:
                                    'A password reset has been sent to your email.',
                              ).show();
                            } catch (e) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc:
                                    'The email you applied not correct Please check and try again.',
                              ).show();
                            }
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            child: const Text(
                              "Forget password?",
                              textAlign: TextAlign.right,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BasicAppButton(
                    title: "Login",
                    onPressed: () async {
                      
                      if (formState.currentState!.validate()) {
                        try {
                          isLoading = true;
                          setState(() {});
                          
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: Email.text.trim(),
                            password: Password.text.trim(),
                          );
                          
                        
                          isLoading = false;
                          setState(() {});

                          // Navigate to the next page
                          if (credential.user!.emailVerified) {
                            showLoading(context, () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Home(),
                              ),

                            );
                            });
                          } else {
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.infoReverse,
                              animType: AnimType.rightSlide,
                              title: 'Warning',
                              desc:
                                  'Please you should verifie your account first.',
                            ).show();
                          }
                        } on FirebaseAuthException catch (e) {
                          isLoading = false;
                          setState(() {});
                          String errorMessage;

                          if (e.code == 'user-not-found') {
                            errorMessage = 'No user found for that email.';
                          } else if (e.code == 'wrong-password') {
                            errorMessage =
                                'Wrong password provided for that user.';
                          } else {
                            errorMessage =
                                'Something went wrong. Please try again.';
                          }

                          // Show error dialog
                          if (context.mounted) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Login failed',
                              desc: errorMessage,
                            ).show();
                          }
                        } catch (e) {
                          if (context.mounted) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc:
                                  'An unexpected error occurred. Please try again later.',
                            ).show();
                          }
                        }
                      } else {
                        print("Not valid");
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      // النص "Or Login With"
                      const Text(
                        "Or continue with",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // إضافة خط رمادي

                      const Divider(
                        color: Colors.grey, // اللون الرمادي
                        thickness: 2, // سمك الخط
                        indent: 50, // المسافة من الجوانب
                        endIndent: 50, // المسافة من الجوانب الأخرى
                      ),

                      // إضافة المربع الخاص بجوجل
                      GestureDetector(
                        onTap: () {
                          
                          signInWithGoogle();
                        },
                        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // مربع جوجل
                            SquareTile(
                              imagePath: "assets/images/google.png",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                       isLoading = true;
                          setState(() {});
                            
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SignUp(),)
                              );
                            isLoading = false;
                    },
                    child: const Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Don't have an account?"),
                            TextSpan(
                              text: " Register",
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
