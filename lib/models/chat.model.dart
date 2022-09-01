class RuleBasedChatbot {
  ChatModel? intro;
  List<ChatModel>? response;

  RuleBasedChatbot({this.intro, this.response});

  RuleBasedChatbot.fromJson(Map<String, dynamic> json) {
    intro = json['intro'] != null ? ChatModel.fromJson(json['intro']) : null;
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response!.add(ChatModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (intro != null) {
      data['intro'] = intro!.toJson();
    }
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatModel {
  int? id;
  String? text;
  String? author;
  String? imageUrl;
  List<Suggestion>? suggestion;

  ChatModel({this.id, this.text, this.author, this.imageUrl, this.suggestion});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    author = json['author'];
    imageUrl = json['imageUrl'];
    if (json['suggestion'] != null) {
      suggestion = <Suggestion>[];
      json['suggestion'].forEach((v) {
        suggestion!.add(Suggestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['author'] = author;
    data['imageUrl'] = imageUrl;
    if (suggestion != null) {
      data['suggestion'] = suggestion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Suggestion {
  int? id;
  String? text;

  Suggestion({this.id, this.text});

  Suggestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    return data;
  }
}
