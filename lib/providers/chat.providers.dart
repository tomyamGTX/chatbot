import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/chat.model.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatModel> chat = [];

  getFromJson(List<ChatModel> data) {
    chat = data;
    notifyListeners();
  }

  void addChat(ChatModel chatModel) {
    try {
      chat.add(chatModel);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void getResponse(int id, String text) {
    // if (id == 0) {
    //   Provider.of<ChatProvider>(context, listen: false).addChat(ChatModel(
    //       text: 'Can you repeat again?',
    //       author: 'FLUTTER BOT',
    //       imageUrl:
    //           'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
    //       suggestion: [],
    //       id: 11));
    // } else if (id == 1) {
    //   Provider.of<ChatProvider>(context, listen: false).addChat(ChatModel(
    //       text: 'How are you?',
    //       author: 'FLUTTER BOT',
    //       suggestion: [],
    //       imageUrl:
    //           'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
    //       id: 11));
    // } else {
    //   Provider.of<ChatProvider>(context, listen: false).addChat(ChatModel(
    //       text: 'Good to hear',
    //       author: 'FLUTTER BOT',
    //       suggestion: [],
    //       imageUrl:
    //           'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
    //       id: 12));
    // }
    if (text.toLowerCase().split(' ').contains('hello')) {
      addChat(ChatModel(
          text: 'Hello too! ☺',
          author: 'FLUTTER BOT',
          suggestion: [],
          imageUrl:
              'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
          id: id + 1));
    } else if (text.toLowerCase().split(' ').contains('hi')) {
      addChat(ChatModel(
          text: 'Hi there! ☺',
          author: 'FLUTTER BOT',
          suggestion: [],
          imageUrl:
              'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
          id: id + 1));
    } else if (text.toLowerCase().split(' ').contains('no') ||
        text.toLowerCase().split(' ').contains('yes')) {
      addChat(ChatModel(
          text: 'Okay. 🐣',
          author: 'FLUTTER BOT',
          suggestion: [],
          imageUrl:
              'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
          id: id + 1));
    } else if (text.toLowerCase().split(' ').contains('or')) {
      var data = text.split(' or ');
      var number = Random().nextInt(data.length);
      addChat(ChatModel(
          text: data[number],
          author: 'FLUTTER BOT',
          imageUrl:
              'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
          suggestion: [],
          id: id + 1));
    } else if (text.toLowerCase().contains('can ')) {
      var data = ['Yes. Of course.', 'No. Never'];
      var number = Random().nextInt(data.length);
      addChat(ChatModel(
          text: data[number],
          author: 'FLUTTER BOT',
          imageUrl:
              'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
          suggestion: [],
          id: id + 1));
    } else if (text.toLowerCase().contains('why')) {
      var data = ['Because i am just a chat bot', 'Because you are noob'];
      var number = Random().nextInt(data.length);
      addChat(ChatModel(
          text: data[number],
          author: 'FLUTTER BOT',
          imageUrl:
              'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
          suggestion: [],
          id: id + 1));
    } else {
      addChat(ChatModel(
          text: 'Sorry I don\'t understand. Can you repeat again?',
          author: 'FLUTTER BOT',
          imageUrl:
              'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
          suggestion: [],
          id: id + 1));
    }
    notifyListeners();
  }
}
