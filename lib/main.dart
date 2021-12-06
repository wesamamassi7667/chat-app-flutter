import 'package:chat_app/helper/util_shared_preferences.dart';
import 'package:chat_app/provider/chat_provider.dart';
import 'package:chat_app/provider/home_provider.dart';
import 'package:chat_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/provider/auth_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UtilSharedPreference.load();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => AuthProvider(
          firebaseFirestore: FirebaseFirestore.instance,
          googleSignIn: GoogleSignIn(),
          firebaseAuth: FirebaseAuth.instance,
        ),
      ),
      Provider(
        create: (BuildContext context) => HomeProvider(
          firebaseFirestore: FirebaseFirestore.instance,
        ),
      ),
      Provider(
        create: (BuildContext context) => ChatProvider(
        ),
      ),


    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      onGenerateRoute: (setting){
        if(setting.name=='/chat'){
          final arguments = setting.arguments as Map;
          return MaterialPageRoute(builder: (_)=>ChatScreen(userId:arguments['id'],userAvatar:arguments['avatar'] ,userNickname:arguments['name']));
        }
      },
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
