import 'dart:io';

import 'package:chat_app/components/app_bar.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/utils.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/provider/providers.dart';

import 'package:chat_app/widget/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider homeProvider;
  final ScrollController _scrollListController = ScrollController();
  int _limit = 10;
  String textSearch="";
  final TimerAction _timerAction=TimerAction(milliSeconds: 400);
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late String currentUserId ;

  @override
  void initState() {
    homeProvider = context.read<HomeProvider>();
    AuthProvider _authProvider=context.read<AuthProvider>();
    currentUserId=_authProvider.getUserFirebaseId();
    // TODO: implement initState
    super.initState();
    registerNotification();
    configLocalNotification();


  }
  void registerNotification() {
    firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: $message');
      if (message.notification != null) {
        showNotification(message.notification!);
      }
      return;
    });

    firebaseMessaging.getToken().then((token) {
      print('push token: $token');
      if (token != null) {
        homeProvider.updateDataFirestore(userCollection, currentUserId, {'pushToken': token});
      }
    }).catchError((err) {
      print(err);
    });
  }


  void showNotification(RemoteNotification remoteNotification) async {

    // await FirebaseMessaging.instance
    //     .setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      Platform.isAndroid ? 'com.example.chat_app' : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      channelDescription: 'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );

        IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);



    await flutterLocalNotificationsPlugin.show(
      0,
      remoteNotification.title,
      remoteNotification.body,
      platformChannelSpecifics,
      payload: null,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarComponent(
          title: 'Home',
          isHome: true,
        ),
        body: Column(
          children: [
            SearchFieldWidget(onChanged: _onChange,),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: homeProvider.getAccountStream(userCollection, _limit,searchText:textSearch),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> data =
                        snapshot.data!.docs ?? [];
                    if (data.length > 0) {
                      return ListView.separated(
                        itemCount: data.length,
                        padding: EdgeInsets.all(10),
                        physics: ClampingScrollPhysics(),
                        controller: _scrollListController,
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot doc = data[index];
                          UserChat userChat = UserChat.fromDocument(doc);
                          return AccountWidget(
                            userChat: userChat,
                            tap: () {
                              if (Utilities.isKeyboardShowing()) {
                                Utilities.closeKeyboard(context);
                              }
                              var _argument={
                                "id":userChat.id,
                                "avatar":userChat.photoUrl,
                                "name":userChat.displayName
                              };
                              Navigator.pushNamed(context, '/chat',arguments: _argument);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: 6,
                        ),
                      );
                    }
                    return Center(
                      child: Text('No User'),
                    );
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Container();
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ));
  }

   _onChange(value) {
       _timerAction.run(() {
         setState(()=> textSearch=value);
       });
   }


  //to show message in foreground
  void configLocalNotification() {
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android:initializationSettingsAndroid, iOS:initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
