import 'dart:math';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chatbot/models/chat.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  List<ChatModel> chat = [
    ChatModel(
        text: 'Hello there',
        author: 'FLUTTER BOT',
        imageUrl:
            'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
        id: 0)
  ];

  final _input = TextEditingController();
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                  children: chat
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Directionality(
                              textDirection: e.author == widget.title
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(e.imageUrl),
                                  ),
                                  Flexible(
                                    child: GestureDetector(
                                        onLongPress: () async {
                                          await showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Delete this message?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Text('No')),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {});
                                                        chat.remove(e);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('Yes'))
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: BubbleSpecialThree(
                                          text: e.text,
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              color: e.author != widget.title
                                                  ? Colors.white
                                                  : null),
                                          color: e.author != widget.title
                                              ? Colors.blueGrey
                                              : Colors.white,
                                          delivered: e.author != widget.title
                                              ? true
                                              : false,
                                          tail: false,
                                          isSender: e.author != widget.title
                                              ? true
                                              : false,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList()),
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            trailing: IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                if (_input.text.isNotEmpty) {
                  var id = Random().nextInt(10);
                  setState(() {
                    chat.add(ChatModel(
                        text: _input.text,
                        author: 'user',
                        imageUrl:
                            'https://flyclipart.com/thumb2/user-icon-png-pnglogocom-133466.png',
                        id: id));
                  });
                  _input.clear();
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  getResponse(id);
                  _scrollDown();
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
        ],
      ),
    );
  }

  void _scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  void getResponse(int id) {
    if (id == 0) {
      setState(() {});
      chat.add(ChatModel(
          text: 'Can you repeat again?',
          author: 'FLUTTER BOT',
          imageUrl:
              'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
          id: 11));
    } else if (id == 1) {
      setState(() {});
      chat.add(ChatModel(
          text: 'How are you?',
          author: 'FLUTTER BOT',
          imageUrl:
              'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
          id: 11));
    } else {
      setState(() {});
      chat.add(ChatModel(
          text: 'Good to hear',
          author: 'FLUTTER BOT',
          imageUrl:
              'https://cdn.technologyadvice.com/wp-content/uploads/2018/02/friendly-chatbot.jpg',
          id: 12));
    }
  }
}
