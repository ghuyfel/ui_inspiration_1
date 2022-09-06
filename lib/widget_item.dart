import 'package:flutter/material.dart';
import 'package:ui_inspiration_1/generated/assets.dart';
import 'package:ui_inspiration_1/model.dart';

class WidgetItem extends StatefulWidget {
  const WidgetItem({
    required this.index,
    required this.onScroll,
    required this.model,
    this.canDown = true,
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;
  final bool canDown;
  final Model model;

  final int index;
  final Function(int index, double height) onScroll;

  @override
  State<WidgetItem> createState() => _WidgetItemState();
}

class _WidgetItemState extends State<WidgetItem> {
  bool animate = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final visible = widget.currentIndex == widget.index;
    return SizedBox(
      height: mediaQuery.size.height,
      width: mediaQuery.size.width,
      child: Stack(
        children: [
          SizedBox(
              height: mediaQuery.size.height,
              width: mediaQuery.size.width,
              child: FadeInImage(
                alignment: mediaQuery.size.width > 600
                    ? Alignment.topRight
                    : Alignment.center,
                fadeInCurve: Curves.ease,
                fadeOutCurve: Curves.easeOut,
                image: AssetImage(widget.model.image),
                fit: mediaQuery.size.width > 600
                    ? BoxFit.fitWidth
                    : BoxFit.cover,
                width: mediaQuery.size.width,
                height: mediaQuery.size.height,
                placeholder: const AssetImage(
                  Assets.assetsPh,
                ),
              )),
          if (visible)
            Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TweenAnimationBuilder(
                  duration: const Duration(seconds: 1),
                  builder: (BuildContext context, double value, Widget? child) {
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                  tween: Tween<double>(begin: 0, end: 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.face_rounded,
                          size: 35,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "StyleShare",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold)
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          if (visible)
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: (BuildContext context, double value, Widget? child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [
                              0.4,
                              // 0.9,
                              1.0
                            ],
                            colors: [
                              Colors.transparent,
                              widget.model.highlightColor.withOpacity(0.9),
                              // highlightColor.withOpacity(0.8),
                            ])),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomLeft,
                            stops: const [
                              0.0,
                              0.9,
                              // 0.6
                            ],
                            colors: [
                              Colors.transparent,
                              widget.model.highlightColor.withOpacity(0.8),
                              // Colors.lightGreen,
                              // highlightColor,

                              // Colors.transparent
                            ])),
                  ),
                ],
              ),
            ),
          if (visible)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TweenAnimationBuilder(
                    tween: Tween<double>(
                        begin: mediaQuery.size.height / 2, end: 0),
                    duration: const Duration(
                      seconds: 1,
                    ),
                    curve: Curves.easeOut,
                    builder:
                        (BuildContext context, double value, Widget? child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: child,
                      );
                    },
                    child: Text(
                      widget.model.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TweenAnimationBuilder(
                    duration: const Duration(seconds: 1, milliseconds: 500),
                    curve: Curves.easeOut,
                    tween: Tween<double>(
                        begin: -2 * mediaQuery.size.width, end: 0),
                    builder:
                        (BuildContext context, double value, Widget? child) {
                      return Transform.translate(
                        offset: Offset(value, 0),
                        child: child,
                      );
                    },
                    child: Text(
                      widget.model.body,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    curve: Curves.easeIn,
                    duration: const Duration(seconds: 2),
                    builder:
                        (BuildContext context, double value, Widget? child) {
                      return Opacity(
                        opacity: value,
                        child: child,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RotatedBox(
                          quarterTurns: 1,
                          child: TextButton(
                            onPressed: () {
                              widget.onScroll
                                  .call(widget.index, mediaQuery.size.height);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Scroll",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                const Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
