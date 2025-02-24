import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spotifys/presentation/auth/pages/Auth/signup.dart';


class IsLoadingPage extends StatefulWidget {
  final VoidCallback onDone; // يتم استدعاؤها عند انتهاء التحميل

  IsLoadingPage({required this.onDone});

  @override
  _IsLoadingPageState createState() => _IsLoadingPageState();
}

class _IsLoadingPageState extends State<IsLoadingPage> {
  @override
  void initState() {
    super.initState();

    // عد تنازلي لمدة 7 ثوانٍ ثم استدعاء الدالة onDone
    Future.delayed(Duration(seconds: 2), () {
      widget.onDone(); // تنفيذ الدالة onDone بعد 7 ثوانٍ
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // خلفية الصفحة
      body: Center(
        child: LottieBuilder.asset(
          "lib/Lottie/spotify.json", // ملف Lottie
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// دالة لإظهار صفحة التحميل
void showLoading(BuildContext context, VoidCallback onDone) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => IsLoadingPage(onDone: onDone),
    ),
  );
}

// الصفحة الرئيسية
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            
            showLoading(context, () {
              
               Navigator.pushReplacement(
          context,
            MaterialPageRoute(
             builder: (BuildContext context) => SignUp(),
          ),
               );
            });
          },
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue,
            child: Text(
              'Go to Signup',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}