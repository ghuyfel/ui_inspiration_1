import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_inspiration_1/model.dart';
import 'package:ui_inspiration_1/widget_item.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
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
      // themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);

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

