// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotifys/core/configs/assets/app_vectors.dart';
import 'package:spotifys/presentation/intro/pages/get_started.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AppVectors.logo),
      ),
    );
  }
  
  Future<void>redirect() async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
       MaterialPageRoute(
        builder: (BuildContext context) => const GetStartedPage(),
        ),
       );
  }
}
