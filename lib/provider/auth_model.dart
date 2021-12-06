import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/util_shared_preferences.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  AuthProvider(
      {required this.googleSignIn,
      required this.firebaseFirestore,
      required this.firebaseAuth});

  Status _status = Status.uninitialized;

  Status get status => _status;


  Future<bool> isLoggedIn() async {
    return UtilSharedPreference.getString('uid') != null;
  }

  String getUserFirebaseId() {
    return UtilSharedPreference.getString('uid')!;
  }

  Future<bool> signWithGoogle() async {
    _status = Status.authenticating;
    notifyListeners();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final _authentication = await googleUser.authentication;
      final _credential = GoogleAuthProvider.credential(
          idToken: _authentication.idToken,
          accessToken: _authentication.accessToken);
      User? firebaseUser = (await firebaseAuth.signInWithCredential(_credential)).user;
      if (firebaseUser != null) {
        final result = await firebaseFirestore
            .collection(userCollection)
            .where("id", isEqualTo: firebaseUser.uid)
            .get();  //get for Future<querySnapShot> not stream
        final docs = result.docs; // get List<QueryDocumentSnapshot<T>>
        if (docs.length == 0) {
          //create new user
          firebaseFirestore
              .collection(userCollection)
              .doc(firebaseUser.uid)
              .set({
            "displayName": firebaseUser.displayName,
            "photoUrl": firebaseUser.photoURL,
            "id": firebaseUser.uid,
            "chattingWith": null,
            'createdAt': DateTime.now().toString(),
            "AboutMe": ""
          });

          UtilSharedPreference.setString("uid", firebaseUser.uid);
          UtilSharedPreference.setString("displayName", firebaseUser.displayName ?? "");
          UtilSharedPreference.setString("photoUrl", firebaseUser.photoURL ?? "");
        } else {
          // user is exist
          final document = docs[0];
          UserChat userChat = UserChat.fromDocument(document);
          UtilSharedPreference.setString("uid", userChat.id);
          UtilSharedPreference.setString("displayName", userChat.displayName);
          UtilSharedPreference.setString("photoUrl", userChat.photoUrl);
        }
        _status = Status.authenticating;
        notifyListeners();
        return true;
      }
      else {
        _status = Status.authenticateError;
        notifyListeners();
        return false;
      }
    }
    else {
      _status = Status.authenticateCanceled;
      notifyListeners();
      return false;
    }
  }
}
