
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthModel extends ChangeNotifier{
GoogleSignInAccount? currentUser;

 bool isLoggedIn(){
 return currentUser!=null;
 }


}