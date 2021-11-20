
import 'package:chat_app/components/app_bar.dart';
import 'package:chat_app/components/my_progress_indicator.dart';
import 'package:chat_app/provider/auth_model.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider=Provider.of<AuthProvider>(context);
    switch(_authProvider.status){
      case Status.authenticateError:
        _showMessage("Sign in fail",context);
        break;
      case Status.authenticateCanceled:
        _showMessage("Sign in canceled",context);
        break;
      case Status.authenticated:
        _showMessage("Sign in success",context);
        break;
      default:

    }
    return Scaffold(
      appBar: AppBarComponent(
        title: 'Login',
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: OutlinedButton(
                onPressed: () async {
                 bool success=await _authProvider.signWithGoogle();
                 if(success){
                   Navigator.pushReplacementNamed(context, '/home');
                 }

                },
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    Image.asset(
                      imagePath + 'google.png',
                      width: 20,
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'Continue with Google',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          _authProvider.status==Status.authenticating? MyProgressIndicator():SizedBox(),
        ],
      ),
    );
  }

  void _showMessage(String s,context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:Text(s),
        behavior: SnackBarBehavior.floating,
      )
    );
  }


}


