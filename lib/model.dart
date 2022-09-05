import 'package:flutter/material.dart';

class Model {
  final String image;
  final String title;
  final String body;
  final Color highlightColor;

  const Model({
    required this.image,
    required this.title,
    required this.body,
    required this.highlightColor
  });
}