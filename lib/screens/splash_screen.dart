import 'package:chat_app/provider/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),()=> _checkSignedIn()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
           child: Icon(
                Icons.chat_rounded,
                size: 100,
            ),
      ),
    );
  }

  Future<void> _checkSignedIn() async {
   AuthProvider _authProvider=context.read<AuthProvider>();
   if(await _authProvider.isLoggedIn()){
     Navigator.pushReplacementNamed(context, '/home');
   }
   else{
     Navigator.pushReplacementNamed(context, '/login');
   }
  }
}

