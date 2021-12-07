enum MessageTypeEnum { text, image, sticker }

class MessageType {
  MessageType({required this.type});

  final MessageTypeEnum type;

  factory MessageType.fromValue(int value) {
    if (value == 0) {
      return MessageType(type: MessageTypeEnum.text);
    } else if (value == 1) {
      return MessageType(type: MessageTypeEnum.image);
    } else {
      return MessageType(type: MessageTypeEnum.sticker);
    }
  }
}
