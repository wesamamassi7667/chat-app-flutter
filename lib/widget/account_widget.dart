import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    Key? key,
    required this.userChat,
    required this.tap,
  }) : super(key: key);

  final UserChat userChat;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color(0xffE8E8E8), borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Material(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: '${userChat.photoUrl}',
                errorWidget: (context, url, error) => Icon(Icons.error),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                        )),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Nickname: ${userChat.displayName}',
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      child: Text(
                        'About me: ${userChat.aboutMe}',
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
