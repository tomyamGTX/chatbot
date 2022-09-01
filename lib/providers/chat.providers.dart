import 'package:flutter/foundation.dart';

import '../models/chat.model.dart';

class ChatProvider extends ChangeNotifier {
  ChatModel? greeting;
  List<ChatModel> chat = [];
  List<ChatModel> response = [];

  getFromJson(RuleBasedChatbot data) {
    try {
      greeting = data.intro;
      chat.add(greeting!);
      response = data.response!;
      response.add(greeting!);
      notifyListeners();
    } catch (e) {
      print('error json and model');
    }
  }

  Future<void> addChat(ChatModel chatModel) async {
    try {
      chat.add(chatModel);
      await getResponse(chatModel.id!);
      notifyListeners();
    } catch (e) {
      print('error chat list');
    }
  }

  Future<void> getResponse(int id) async {
    try {
      var exist = response.any((element) => element.id == id);
      if (!exist) {
        chat.add(ChatModel(
            text: 'Sorry I don\'t understand. Can you repeat again?',
            author: 'FLUTTER BOT',
            imageUrl:
                'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
            suggestion: [],
            id: id + 1));
      } else {
        response.forEach((element) {
          if (element.id == id) {
            chat.add(element);
            notifyListeners();
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

// void addChat(ChatModel chatModel) {
//   try {
//     chat.add(chatModel);
//     notifyListeners();
//   } catch (e) {
//     if (kDebugMode) {
//       print(e);
//     }
//   }
// }

// void getResponse(int id, String text) {
//   if (text.toLowerCase().split(' ').contains('hello')) {
//     addChat(ChatModel(
//         text: 'Hello too! ☺',
//         author: 'FLUTTER BOT',
//         suggestion: [],
//         imageUrl:
//             'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
//         id: id + 1));
//   } else if (text.toLowerCase().split(' ').contains('hi')) {
//     addChat(ChatModel(
//         text: 'Hi there! ☺',
//         author: 'FLUTTER BOT',
//         suggestion: [],
//         imageUrl:
//             'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
//         id: id + 1));
//   } else if (text.toLowerCase().split(' ').contains('no') ||
//       text.toLowerCase().split(' ').contains('yes')) {
//     addChat(ChatModel(
//         text: 'Okay. 🐣',
//         author: 'FLUTTER BOT',
//         suggestion: [],
//         imageUrl:
//             'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
//         id: id + 1));
//   } else if (text.toLowerCase().split(' ').contains('or')) {
//     var data = text.split(' or ');
//     var number = Random().nextInt(data.length);
//     addChat(ChatModel(
//         text: data[number],
//         author: 'FLUTTER BOT',
//         imageUrl:
//             'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
//         suggestion: [],
//         id: id + 1));
//   } else if (text.toLowerCase().contains('can ')) {
//     var data = ['Yes. Of course.', 'No. Never'];
//     var number = Random().nextInt(data.length);
//     addChat(ChatModel(
//         text: data[number],
//         author: 'FLUTTER BOT',
//         imageUrl:
//             'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
//         suggestion: [],
//         id: id + 1));
//   } else if (text.toLowerCase().contains('why')) {
//     var data = ['Because i am just a chat bot', 'Because you are noob'];
//     var number = Random().nextInt(data.length);
//     addChat(ChatModel(
//         text: data[number],
//         author: 'FLUTTER BOT',
//         imageUrl:
//             'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
//         suggestion: [],
//         id: id + 1));
//   } else {
//     addChat(ChatModel(
//         text: 'Sorry I don\'t understand. Can you repeat again?',
//         author: 'FLUTTER BOT',
//         imageUrl:
//             'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
//         suggestion: [],
//         id: id + 1));
//   }
//   notifyListeners();
// }
}
