
import 'package:chat_app/components/app_bar.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_chat.dart';
import 'package:chat_app/provider/providers.dart';
import 'package:chat_app/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/models.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key,
      required this.userId,
      required this.userAvatar,
      required this.userNickname})
      : super(key: key);
  final String userId;
  final String userAvatar;
  final String userNickname;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String currentUserId, chatId;
  late ChatProvider _chatProvider;
  final TextEditingController _controller = TextEditingController();
  var _limit =20;
  final ScrollController listScrollController = ScrollController();



  @override
  void initState() {
    // TODO: implement initState
    AuthProvider _authProvider = context.read<AuthProvider>();
     _chatProvider = context.read<ChatProvider>();
    currentUserId = _authProvider.getUserFirebaseId();
    if (currentUserId.compareTo(widget.userId) > 0) {
      chatId = '$currentUserId-${widget.userId}';
    } else {
      chatId = '${widget.userId}-$currentUserId';
    }
    _chatProvider.updateDataFirestore(userCollection, currentUserId,{"chattingWith":chatId});


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: widget.userNickname,
      ),
      body:Column(
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream:_chatProvider.getChatStream(chatId,_limit),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot> _listMessage =
                      snapshot.data!.docs??[] ;
                  // Do not forget return !!
               return  ListView.builder(
                    itemCount: _listMessage.length,
                    padding: EdgeInsets.all(15),
                    controller: listScrollController,
                    reverse: true,
                    itemBuilder: (context,index){
                      QueryDocumentSnapshot _document=_listMessage[index];
                      MessageChat message=MessageChat.fromDocument(_document,);
                      if(message.idFrom==currentUserId){
                        return message.messageType==MessageTypeEnum.text?
                        MessageChatWidget(textMessage: message.content, color: Color.fromRGBO(225, 255, 199, 1.0), time: '2:66 pm'):
                         Material(
                          clipBehavior: Clip.hardEdge,
                         );
                      }
                        else{
                          return MessageChatWidget(textMessage: message.content, time: '2:66 pm',color: Colors.white,);}
                        },
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
            )
          ),
          SendMessageField(
             textEditingController:_controller,
             press: ()=>_sendMessage(_controller.text),
            pressCamera:() =>_getImages(),
          )
        ],
      )
    );
  }

   _sendMessage(String content) {
    if (content.trim().isNotEmpty) {
      _controller.clear();
      _chatProvider.sendMessage(content, 0, chatId, currentUserId, widget.userId);
      listScrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  _getImages() async {
    final ImagePicker _picker = ImagePicker(

    );
    XFile? pickedFile;
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
    Navigator.pushNamed(context, '/previewImage',arguments: pickedFile.path);
    }
  }
}
