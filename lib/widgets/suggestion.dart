import 'package:chatbot/models/chat.model.dart';
import 'package:chatbot/providers/chat.providers.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class Suggestion extends StatelessWidget {
  const Suggestion({
    Key? key,
    required this.id,
    required this.item,
  }) : super(key: key);
  final int id;
  final String item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Provider.of<ChatProvider>(context, listen: false).addChat(ChatModel(
              text: item,
              author: 'user',
              imageUrl:
                  'https://flyclipart.com/thumb2/user-icon-png-pnglogocom-133466.png',
              id: id + 1,
              suggestion: []));
          Provider.of<ChatProvider>(context, listen: false)
              .getResponse(id + 1, item);
        },
        child: Chip(
          label: Text(
            item,
            style: const TextStyle(color: white),
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    );
  }
}
