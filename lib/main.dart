import 'package:flutter/material.dart';
import 'dart:core';

import 'package:ui_inspiration_1/generated/assets.dart';
import 'package:ui_inspiration_1/model.dart';
import 'package:ui_inspiration_1/widget_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final scrollController = ScrollController();
  int currentIndex = 0;

  final items = <Model>[
    const Model(
        image: "assets/bg1.jpg",
        title: "Greenery\nDays",
        body: "is simply dummy text of the printing and typesetting",
        highlightColor: Colors.green),
    const Model(
        image: "assets/bg.jpg",
        title: "My fav\nYellow",
        body:
            "Nam eget dignissim leo, sit amet aliquet massa. Proin in felis viverra, faucibus sem eu",
        highlightColor: Colors.orangeAccent),
    const Model(
        image: "assets/bg3.jpg",
        title: "Perfect\nRed St.",
        body:
            "Duis ut tortor ut lorem consequat ullamcorper. Mauris quis lacus ac diam feugiat luctus. ",
        highlightColor: Colors.red),
    const Model(
        image: "assets/bg2.jpg",
        title: "Sky blue\nDays",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
        highlightColor: Colors.blue),
  ];

  final widgets = <Widget>[];

  void _scrollToIndex(int index, double height) async {
    if (index == 3) {
      index = 0;
    } else {
      index++;
    }

    await scrollController.position.animateTo(height * index,
        duration: const Duration(milliseconds: 750), curve: Curves.easeInOut);

    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        currentIndex = index;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollController.addListener(() {
      final mediaQuery = MediaQuery.of(context).size;
      final activity = scrollController.position.isScrollingNotifier;

      activity.addListener(() {
        if (!activity.value) {
          int position = scrollController.offset ~/ (mediaQuery.height).abs();
          if (currentIndex != position) {
            setState(() {
              currentIndex = position;
            });
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      controller: scrollController,
      physics: MediaQuery.of(context).size.width <= 600
          ? const PageScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(childCount: items.length,
                (context, index) {
          return WidgetItem(
              index: index,
              onScroll: _scrollToIndex,
              model: items[index],
              currentIndex: currentIndex);
        }))
      ],
    ));
  }
}

