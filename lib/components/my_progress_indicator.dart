

import 'package:flutter/material.dart';
  class MyProgressIndicator extends StatelessWidget {
    const MyProgressIndicator({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
          ),
        ),
        color: Colors.black.withOpacity(0.2),
      );
    }
  }
