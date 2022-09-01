import 'dart:convert';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chatbot/models/chat.model.dart';
import 'package:chatbot/providers/chat.providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatProvider>(
            create: (context) => ChatProvider())
      ],
      child: MaterialApp(
        title: 'ChatBot App',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'FLUTTER BOT'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    readJson();
    super.initState();
  }

  final _input = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 14),
        child: Consumer<ChatProvider>(builder: (context, data, _) {
          return data.chat.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                  semanticsLabel: 'Loading',
                ))
              : SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                      children: data.chat
                          .map((e) => Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16,
                                        left: 16,
                                        right: 16,
                                        bottom: 8),
                                    child: e.author == widget.title
                                        ? Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(e.imageUrl!),
                                              ),
                                              Flexible(
                                                child: GestureDetector(
                                                    onTap: () async {
                                                      RegExp exp = RegExp(
                                                          r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
                                                      Iterable<RegExpMatch>
                                                          matches =
                                                          exp.allMatches(
                                                              e.text!);
                                                      if (matches.isNotEmpty) {
                                                        await showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Navigate to the url?'),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context),
                                                                    child: const Text(
                                                                        'No')),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      matches.forEach(
                                                                          (match) {
                                                                        launchUrl(Uri.parse(e.text!.substring(
                                                                            match.start,
                                                                            match.end)));
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Text(
                                                                        'Yes'))
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                    onLongPress: () async {
                                                      await showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Delete this message?'),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child:
                                                                      const Text(
                                                                          'No')),
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {});
                                                                    data.chat
                                                                        .remove(
                                                                            e);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Yes'))
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: BubbleSpecialThree(
                                                      text: e.text!,
                                                      textStyle: TextStyle(
                                                          fontSize: 18,
                                                          color: e.author !=
                                                                  widget.title
                                                              ? Colors.white
                                                              : null),
                                                      color: e.author !=
                                                              widget.title
                                                          ? Colors.blueGrey
                                                          : Colors.white,
                                                      delivered: e.author !=
                                                              widget.title
                                                          ? true
                                                          : false,
                                                      tail: false,
                                                      isSender: e.author !=
                                                              widget.title
                                                          ? true
                                                          : false,
                                                    )),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Flexible(
                                                child: GestureDetector(
                                                    onLongPress: () async {
                                                      await showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Delete this message?'),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child:
                                                                      const Text(
                                                                          'No')),
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {});
                                                                    data.chat
                                                                        .remove(
                                                                            e);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Yes'))
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: BubbleSpecialThree(
                                                      text: e.text!,
                                                      textStyle: TextStyle(
                                                          fontSize: 18,
                                                          color: e.author !=
                                                                  widget.title
                                                              ? Colors.white
                                                              : null),
                                                      color: e.author !=
                                                              widget.title
                                                          ? Colors.blueGrey
                                                          : Colors.white,
                                                      delivered: e.author !=
                                                              widget.title
                                                          ? true
                                                          : false,
                                                      tail: false,
                                                      isSender: e.author !=
                                                              widget.title
                                                          ? true
                                                          : false,
                                                    )),
                                              ),
                                              CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(e.imageUrl!),
                                              ),
                                            ],
                                          ),
                                  ),
                                  Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    spacing: 8,
                                    children: [
                                      for (var item in e.suggestion!)
                                        GestureDetector(
                                          onTap: () async {
                                            await data.addChat(ChatModel(
                                                text: item.text,
                                                author: 'user',
                                                imageUrl:
                                                    'https://flyclipart.com/thumb2/user-icon-png-pnglogocom-133466.png',
                                                id: item.id,
                                                suggestion: []));
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 500),
                                                _scrollDown);
                                            // Provider.of<ChatProvider>(context, listen: false)
                                            //     .getResponse(id + 1, item);
                                          },
                                          child: Chip(
                                            label: Text(
                                              item.text!,
                                              style:
                                                  const TextStyle(color: white),
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .primaryColorDark,
                                            labelPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8),
                                          ),
                                        )
                                    ],
                                  )
                                ],
                              ))
                          .toList()),
                );
        }),
      ),
      bottomSheet: ListTile(
        tileColor: Colors.white,
        trailing: IconButton(
          icon: const Icon(
            Icons.send,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            if (_input.text.isNotEmpty) {
              setState(() {
                Provider.of<ChatProvider>(context, listen: false).addChat(ChatModel(
                    text: _input.text,
                    author: 'user',
                    imageUrl:
                        'https://flyclipart.com/thumb2/user-icon-png-pnglogocom-133466.png',
                    id: 4,
                    suggestion: []));
              });

              SystemChannels.textInput.invokeMethod('TextInput.hide');
              // Provider.of<ChatProvider>(context, listen: false)
              //     .getResponse(id, _input.text);
              _input.clear();
              Future.delayed(const Duration(milliseconds: 500), _scrollDown);
            }
          },
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormField(
            controller: _input,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Type your message here',
            ),
          ),
        ),
      ),
    );
  }

  void _scrollDown() {
    setState(() {});
    _controller.jumpToBottom();
  }

  Future<void> readJson() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/rule_based_chatbot.json");

    final jsonResult = RuleBasedChatbot.fromJson(jsonDecode(data));
    setState(() {});
    if (!mounted) return;
    Provider.of<ChatProvider>(context, listen: false).getFromJson(jsonResult);
  }
}
