
import 'package:chat_app/models/popup_choice.dart';
import 'package:flutter/material.dart';
class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final bool isHome;
  final List<PopupChoice> choices=[
    PopupChoice('Settings', Icons.settings),
    PopupChoice('Log out', Icons.logout),
  ];
   AppBarComponent({
    Key? key, this.title="", this.isHome=false,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
     actions:isHome? [
        _buildPopupMenu(context),
      ]:[],
    );


  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;

  Widget _buildPopupMenu(context) {
    return PopupMenuButton(
      itemBuilder: (context){
        return choices.map((choice){
          return PopupMenuItem(
            padding: EdgeInsets.all(0),
            child: ListTile(
               leading: Icon(choice.icon),
               title: Text(choice.title),
            ),
          );
        }).toList();
      },
    );
  }
}