class RuleModel {
  List<ChatModel>? chatModel;

  RuleModel({this.chatModel});

  RuleModel.fromJson(Map<String, dynamic> json) {
    if (json['chatModel'] != null) {
      chatModel = <ChatModel>[];
      json['chatModel'].forEach((v) {
        chatModel!.add(ChatModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chatModel != null) {
      data['chatModel'] = chatModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatModel {
  int? id;
  String? text;
  String? author;
  String? imageUrl;
  List? suggestion;

  ChatModel({this.id, this.text, this.author, this.imageUrl, this.suggestion});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    author = json['author'];
    imageUrl = json['imageUrl'];
    suggestion = json['suggestion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['author'] = author;
    data['imageUrl'] = imageUrl;
    data['suggestion'] = suggestion;
    return data;
  }
}
