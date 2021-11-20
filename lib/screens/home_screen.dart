import 'package:chat_app/components/app_bar.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/timer_action.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/provider/home_provider.dart';
import 'package:chat_app/widget/account_widget.dart';
import 'package:chat_app/widget/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  void initState() {
    homeProvider = context.read<HomeProvider>();

    // TODO: implement initState
    super.initState();
    _scrollListController.addListener(scrollListener);
  }

  void scrollListener() {
    if (_scrollListController.offset >=
            _scrollListController.position.maxScrollExtent &&
        !_scrollListController.position.outOfRange) {
      setState(() {
        _limit += 10;
        ;
      });
    }
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
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                              Navigator.pushNamed(context, '/chat');
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
         setState(() {
           textSearch=value;
         });


       });
  }
}
