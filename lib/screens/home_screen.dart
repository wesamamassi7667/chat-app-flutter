

import 'package:chat_app/components/app_bar.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title:'Home' ,
        isHome: true,
      ),

      

    );
  }
}
